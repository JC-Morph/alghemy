require 'alghemy/comrades'
require 'alghemy/factories'
require 'alghemy/methods'
require 'alghemy/rubrics'
require_relative 'alghemist/algput'

module Alghemy
  module Comrades
    # Public: Performs Transmutations.
    module Alghemist
      class << self
        include Methods[:alget]
        attr_reader :lmnt, :tran, :stuff, :namer, :rubric

        # TODO: rewrite
        # Public: Initialises Algput to define output environment, then Rubric
        # to define the process String. Invoke Tome with Algput & Rubric to
        # create new files, then evoke new instance of Matter.
        #
        # Returns new instance of Matter.
        def transmute( lmnt, transform )
          @lmnt = lmnt
          assign_variables transform
          tome = tran.tome

          results = scout.mission(-> { cast(tome) }, namer.dir)

          tome_error    if tome.empty?
          tome.dissolve if alget(:leave_no_trace)
          evoke list(results)
        end

        def cast( tome )
          tome.send("each_#{namer.enum}") do |input|
            @rubric = tran.write_rubric(rubric)
            output  = input.swap_parts namer.next_batch
            io = {input: input.to_s, output: output}
            rubric.invoke io
            rubric.increment_options
          end
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
          record = stuff.fetch(:record, true)
          memory = form_memory
          if record.is_a?(Hash)
            memory = record
            record = true
          end
          matter = tome.evoke(memory, record)
          stuff[:autotrim] ? autotrim(matter) : matter
        end

        # Public: Trim excess material from Matter if it was unintentionally
        # introduced by a Transmutation. Enabled on a per Transmutation basis
        # using the :autotrim variable.
        #
        # Returns Matter.
        def autotrim( matter )
          surplus = matter.span - lmnt.span
          matter  = matter.trim("-#{surplus}s") if surplus.positive?
          matter
        end

        private

        def assign_variables( transform )
          @rubric = nil
          @tran   = transform
          @stuff  = tran.stuff
          @namer  = Algput.new(stuff.merge(name_options))
        end

        # Internal: Returns Hash with variables specific to Algput
        # initialisation.
        def name_options
          {tome: tran.tome, mult: tran.mult}
        end

        # Internal: Returns a Tome of all files in Array.
        #
        # arr - Array containing Strings of filenames.
        def list( arr )
          Factories[:scribe].call arr
        end

        # Internal: Collect aspects that could be useful for future
        # Transmutations.
        #
        # Returns Hash.
        def form_memory
          opt_mem = rubric.option_memory
          anchors = tran.anchors.reject do |anchor|
            opt_mem.keys.include?(anchor)
          end
          init_memory(anchors).merge opt_mem
        end

        def init_memory( anchors )
          anchors.each.with_object(memory_template) do |anchor, memory|
            memory[anchor] = stuff[anchor] || lmnt.send(anchor)
          end
        end

        def memory_template
          {
            affinity: lmnt.affinity,
            list:     lmnt.list,
            name:     stuff[:name].to_sym
          }
        end

        def tome_error
          msg = "No created files found! Something has gone wrong.\n" \
                "The last Transmutation may have failed.\n" \
                'Check the Rubric to see intended file output, ' \
                "and then check if the file(s) actually exist.\n" \
                'If they do, try increasing Alghemy.ear_sleep, ' \
                'to give Listen more time to detect the files.'
          raise msg
        end
      end
    end
  end
end
