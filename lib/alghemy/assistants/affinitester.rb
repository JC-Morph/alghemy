require 'alghemy/affinities'

module Alghemy
  module Assistants
    # Public: Test test_sijil for identifiable affinity.
    module Affinitester
      def affinitest
        discern || :element
      end

      def test_sijil
        raise NotImplementedError
      end

      private

      def discern
        %i[sound video image].each do |affinity|
          return affinity unless wrong? affinity
        end
        nil
      end

      def wrong?( affinity )
        affinity = Affinities[affinity]
        report = affinity.analyse.this test_sijil

        affinity.tests.any? do |test|
          test.class == Regexp ? report =~ test : !report[/#{test}/]
        end
      end
    end
  end
end
