require 'alghemy/apparatus'
require 'alghemy/factories'
require 'alghemy/modules'
require_relative 'alghemist/algput'

module Alghemy
  module Apparatus
    module Alghemist
      class << self
        include Modules[:memorise]
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
          @namer  = Algput.new(stuff.merge name_options)
          @rubric = tran.write_rubric
          results = cast tran.tome
          evoke list(results)
        end

        def cast( tome )
          ears.listen namer.dir
          tome.send('each_' + namer.enum.to_s) do |input|
            input  = input.ffglob if ffgroup(rubric.class, namer.enum)
            output = input.swap_parts namer.parts
            io = {input: input.to_s, output: output}
            rubric.invoke io
          end
          ears.amputate
        end

        def ears
          @ears ||= Apparatus[:ears]
        end

        # Public: Evoke new Matter from Tome with memories from the
        # transmutation.
        #
        # tome - Tome of filenames that were heard during transmutation.
        #
        # Returns new instance of Matter.
        def evoke( tome )
          tome_error if tome.empty?
          sijil  = tome.sijil
          memory = record_memory(stuff, lmnt.mems, short_term)
          store_memory(sijil, memory)
          sijil.evoke memory
        end

        # Internal: Collect aspects that could be useful for future
        # Transmutations.
        #
        # Returns Hash.
        def short_term
          memory = {affinity: lmnt.affinity, ext: lmnt.sijil.ext}
          tran.anchors.each do |anchor|
            next if rubric.option_memory.keys.any? do |option|
              anchor == option
            end
            memory[anchor] = stuff[anchor] || lmnt.send(anchor)
          end
          memory.merge rubric.option_memory
        end

        # Internal: Returns Hash with variables specific to Algput
        # initialisation.
        def name_options
          {sijil: lmnt.sijil, plural: tran.plural?}
        end

        # Internal: Returns a Tome of all files in Array.
        #
        # arr - Array containing Strings of filenames.
        def list( arr )
          Factories[:scribe].call arr
        end

        # NOTE: WHAT IS THIS
        def ffgroup( rubriclass, enum )
          rubriclass == Rubrics[:ffmpeg] && enum == :group_sijil
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
