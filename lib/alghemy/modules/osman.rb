module Alghemy
  module Modules
    # Public: Writes Rubrics for transmutations.
    module Osman
      def write_rubric
        write.send cata[:tran]
      end

      def write
        rubric.write cata.merge(raw: lmnt.raw?)
      end

      # Internal: Returns appropritate Rubric class for current transmutation.
      def rubric
        clss = cata[:type] || lmnt.class
        clss.rubric
      end

      # Public: Duckable Hash of options to initiaise Rubric with.
      def cata
        {}
      end

      # Public: Typically an instance of Matter provided by class. Must duck the
      # #raw? method, to discern whether the input will be raw data.
      def lmnt
        raise NotImplementedError
      end

      # Public: Look up the label for rubric's default switches.
      def switch_label( switch )
        switches = rubric.write.switches
        switches.alias(switch).label
      end
    end
  end
end
