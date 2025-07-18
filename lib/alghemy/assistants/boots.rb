require 'alghemy/rubrics'

module Alghemy
  module Assistants
    # Public: Sox related methods for Transmutations.
    module Boots

      def self.priorities
        [:ext]
      end

      def self.expects
        with_plural :Sound
      end

      def rubric
        Rubrics[:sox]
      end

      def aural?
        !(lmnt.class.name =~ /Sounds*$/).nil?
      end

      private

      def defaults
        {ext: '.wav'}
      end
    end
  end
end
