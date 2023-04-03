require 'alghemy/ancestors'
require 'alghemy/rubrics'

module Alghemy
  module Cdps
    # Public: Process Sound with CDP multichannel reverb.
    class Rmverb < Ancestors[:cdp_transmutation]
      def self.priorities
        [:rmsize, :rgain, :mix, :fback, :absorb, :lpfreq, :trtime]
      end

      def tran_init
        templates = option_templates.merge bare_templates
        stuff[:option_templates] = templates
      end

      def write_rubric
        rubric = write(moniker).c.input.output
        rubric.rmsize.rgain.mix.fback.absorb.lpfreq.trtime
      end

      private

      def defaults
        {ext: 'wav', label: 'V'}
      end

      def option_templates
        {
          channels: {flag: :c, default: 1, delim: ''}
        }
      end

      def bare_options
        {
          rmsize: {default: 1},
          rgain:  {default: 1},
          mix:    {default: 0},
          fback:  {default: 1},
          absorb: {default: 0},
          lpfreq: {default: 0},
          trtime: {default: 0}
        }
      end
    end
  end
end
