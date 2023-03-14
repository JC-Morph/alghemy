require 'alghemy/ancestors'
require 'alghemy/rubrics'

module Alghemy
  module Cdps
    # Public: Process Sound with CDP multichannel reverb.
    class Rmverb < Ancestors[:transmutation]
      def self.priorities
        [:rmsize, :rgain, :mix, :fback, :absorb, :lpfreq, :trtime]
      end

      def self.expects
        with_plural :Sound
      end

      def rubric
        Rubrics[:cdp]
      end

      def tran_init
        templates = {
          channels: {flag: :c, default: 1, delim: ''}
        }
        bare_number_options = {
          rmsize: {default: 1},
          rgain:  {default: 1},
          mix:    {default: 0},
          fback:  {default: 1},
          absorb: {default: 0},
          lpfreq: {default: 0},
          trtime: {default: 0}
        }
        bare_number_options.values.each do |template|
          %i[flag prefix].each do |key|
            template[key] ||= ''
          end
        end
        stuff[:option_templates] = templates.merge(bare_number_options)
      end

      def write_rubric
        rubric = write(moniker).c.input.output
        rubric.rmsize.rgain.mix.fback.absorb.lpfreq.trtime
      end

      def moniker
        self.class.name.split('::').last.
          split(/(?=[A-Z])/).
          map(&:downcase).
          join(' ')
      end

      private

      def defaults
        {ext: 'wav', label: 'V'}
      end
    end
  end
end
