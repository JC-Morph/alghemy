require 'alghemy/ancestors'
require 'alghemy/rubrics'

module Alghemy
  module Ancestors
    class CdpTransmutation < Ancestors[:transmutation]
      def self.expects
        with_plural :Sound
      end

      def rubric
        Rubrics[:cdp]
      end

      def moniker
        self.class.name.split('::').last
            .split(/(?=[A-Z])/)
            .map(&:downcase)
            .join(' ')
      end

      private

      def tran_init
        templates = option_templates.merge bare_templates
        stuff[:option_templates] = templates
      end

      def bare_templates
        bare_options.each_value do |template|
          %i[flag prefix].each do |key|
            template[key] ||= ''
          end
        end
      end

      def bare_options
        {}
      end
    end
  end
end
