require 'alghemy/apparatus'
require 'alghemy/factories'
require 'alghemy/methods'
require_relative 'alghemist/algput'
require_relative 'alghemist/memrec'

module Alghemy
  module Apparatus
    module Alghemist
      class << self
        include Methods[:alget]
        include MemRec
        attr_reader :lmnt, :tran, :cata, :namer, :rubric

        # TODO: rewrite
        # Internal: Initialises Algput to define output environment, then Rubric
        # to define the process String. Invoke Tome with Algput & Rubric to
        # create new files, then evoke new instance of Matter.
        #
        # Returns new instance of Matter.
        def transmute( lmnt, transform, lyst = {} )
          @lmnt = lmnt
          @tran = transform
          @cata = tran.cata
          @namer  = Algput.new cata.merge name_options
          @rubric = tran.write_rubric
          heard   = enumerate tran.tome
          evoke list(heard)
        end

        def enumerate( tome )
          ears.listen namer.dir
          tome.send('each_' + namer.enum.to_s) do |input|
            input  = input.ffglob if ffgroup(rubric.class, namer.enum)
            output = input.swap_parts namer.parts
            io = {input: input.to_s, output: output}
            invoke io
          end
          ears.amputate
        end

        def ears
          @ears ||= Apparatus[:ears]
        end


        # Public: Executes process with input and output provided. Creates a new
        # file.
        #
        # io - Hash of filenames to use in process:
        #      :input  - String naming input file(s). Files should exist.
        #      :output - String naming output file(s). Files can exist.
        def invoke( io )
          Apparatus[:invoker].io(rubric.scroll, io, alget(:print_rubric))
        end

        # Internal: Evoke new Matter from Tome with memories from the
        # transmutation.
        #
        # tome - Tome of filenames that were heard during transmutation.
        #
        # Returns new instance of Matter.
        def evoke( tome )
          tome_error if tome.empty?
          memory = record_memory(lmnt.mems, memorise)
          tome.sijil.evoke memory
        end

        def memorise
          memory = {ext: lmnt.sijil.ext, affinity: lmnt.class.name[/\w+$/]}
          tran.anchors.each do |anchor|
            defunct = rubric.swist.keys.any? do |switch|
              anchor == rubric.switch_label(switch)
            end
            retrieved = cata[anchor] || lmnt.send(anchor)
            memory[anchor] = retrieved unless defunct
          end
          memory.merge rubric.swist
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
          msg = 'No created files found! Increase Alghemy.ear_sleep if ' \
            'problem persists.'
          raise msg
        end
      end
    end
  end
end
