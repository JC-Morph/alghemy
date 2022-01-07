require 'alghemy/comrades'
require 'alghemy/factories'
require 'alghemy/rubrics'
require_relative 'alghemist/algput'

module Alghemy
  module Comrades
    # Public: Performs Transmutations.
    module Alghemist
      class << self
        attr_reader :lmnt, :tran, :stuff, :namer, :rubric

        # TODO: rewrite
        # Public: Initialises Algput to define output environment, then Rubric
        # to define the process String. Invoke Tome with Algput & Rubric to
        # create new files, then evoke new instance of Matter.
        #
        # Returns new instance of Matter.
        def transmute( lmnt, transform )
          @lmnt = lmnt
          @tran = transform
          @stuff = tran.stuff
          @namer = Algput.new(stuff.merge name_options)
          @rubric = tran.write_rubric
          results = cast tran.tome
          evoke list(results)
        end

        def cast( tome )
          scout.monitor namer.dir
          tome.send('each_' + namer.enum.to_s) do |input|
            input  = tome.ffglob if ffgroup
            output = input.swap_parts namer.next_batch
            io = {input: input.to_s, output: output}
            rubric.invoke io
          end
          scout.report
        end

        def scout
          @scout ||= Comrades[:scout]
        end

        # Public: Evoke new Matter from Tome with memories from the
        # transmutation.
        #
        # tome - Tome of filenames that were heard during transmutation.
        #
        # Returns new instance of Matter.
        def evoke( tome )
          tome_error if tome.empty?
          matter = tome.evoke(memory, stuff.fetch(:record, true))
          stuff[:autotrim] ? autotrim(matter) : matter
        end

        # Public: Trim excess material from Matter if it was unintentionally
        # introduced by a Transmutation. Enabled on a per Transmutation basis
        # using the :autotrim variable.
        #
        # Returns Matter.
        def autotrim( matter )
          fat = matter.span - lmnt.span
          matter = matter.trim("-#{fat}s") if fat > 0
          matter
        end

        # Internal: Collect aspects that could be useful for future
        # Transmutations.
        #
        # Returns Hash.
        def memory
          opt_mem = rubric.option_memory
          memory  = memory_template
          tran.anchors.each do |anchor|
            next if opt_mem.keys.include?(anchor)
            memory[anchor] = stuff[anchor] || lmnt.send(anchor)
          end
          memory.merge opt_mem
        end

        def memory_template
          {
            name:     stuff[:name].to_sym,
            affinity: lmnt.affinity,
            list:     lmnt.list
          }
        end

        # Internal: Returns Hash with variables specific to Algput
        # initialisation.
        def name_options
          {tome: lmnt.list, mult: tran.mult}
        end

        # Internal: Returns a Tome of all files in Array.
        #
        # arr - Array containing Strings of filenames.
        def list( arr )
          Factories[:scribe].call arr
        end

        # NOTE: BAD PRACTICE
        def ffgroup
          namer.enum == :group_sijil && rubric.class == Rubrics[:ffmpeg]
        end

        def tome_error
          msg = "No created files found! Something has gone wrong.\n" \
                "The last Transmutation may have failed.\n" \
                "Check the Rubric to see intended file output, " \
                "and then check if the file(s) actually exist.\n" \
                "If they do, try increasing Alghemy.ear_sleep, " \
                "to give Listen more time to detect the files."
          raise msg
        end
      end
    end
  end
end
