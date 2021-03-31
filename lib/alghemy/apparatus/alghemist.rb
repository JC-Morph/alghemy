require 'alghemy/apparatus'
require 'alghemy/factories'
require 'alghemy/methods'
require_relative 'alghemist/algput'

module Alghemy
  module Apparatus
    module Alghemist
      class << self
        include Methods[:mem_rec]
        attr_reader :lmnt, :tran, :cata, :namer, :rubric

        # TODO: rewrite
        # Public: Initialises Algput to define output environment, then Rubric
        # to define the process String. Invoke Tome with Algput & Rubric to
        # create new files, then evoke new instance of Matter.
        #
        # Returns new instance of Matter.
        def transmute( lmnt, transform, lyst = {} )
          @lmnt = lmnt
          @tran = transform
          @cata = tran.cata
          @namer  = Algput.new(cata.merge name_options)
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
          memory = mem_rec(cata, lmnt.mems, short_term)
          tome.sijil.evoke memory
        end

        # Internal: Collect aspects that could be useful for future
        # Transmutations.
        #
        # Returns Hash.
        def short_term
          affinity = lmnt.class.name.split('::').last.to_sym
          memory   = {affinity: affinity, ext: lmnt.sijil.ext}
          tran.anchors.each do |anchor|
            defunct = rubric.option_memory.keys.any? do |option|
              anchor == rubric.options[option]
            end
            retrieved = cata[anchor] || lmnt.send(anchor)
            memory[anchor] = retrieved unless defunct
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
          rubriclass == Rubrics[:fock] && enum == :group_sijil
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
