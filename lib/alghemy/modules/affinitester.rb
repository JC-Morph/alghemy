require 'alghemy/affinities'

module Alghemy
  module Modules
    # Public: Test test_sijil for identifiable affinity.
    module Affinitester
      def affinity
        discern || :element
      end

      def discern
        %i[sound video image].each do |affinity|
          return affinity unless wrong affinity
        end
        nil
      end

      def test_sijil
        raise NotImplementedError
      end

      private

      def wrong( affinity )
        affinity = Affinities[affinity]
        report   = affinity.analyse.this test_sijil

        affinity.tests.any? do |test|
          test.class == Regexp ? report =~ test : !report[/#{test}/]
        end
      end
    end
  end
end
