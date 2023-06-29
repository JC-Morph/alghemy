require 'alghemy/ancestors'

module Alghemy
  module Rubrics
    # Public: Define an executable process for byebyte.
    class Byebyte < Ancestors[:rubric]
      def self.moniker
        'byebyte'
      end

      def option_templates
        {
          # no argument
          destroy: {prefix: ''},
          shuffle: {prefix: ''},
          # no default
          C:       {shortcut: 'continuous-chance'},
          times:   {flag: :t}
        }.merge prefixed_templates
      end

      # Public: Method for adding input and output to process.
      def input
        io = __callee__
        add(io => ["-#{io[/^\w/]}", "%<#{io}>s"])
      end
      alias output input

      private

      def prefixed_templates
        {
          # no argument
          c:      {flag: :continuous},
          # with default
          min:    {default: 0.1},
          max:    {default: 0.9},
          chumin: {default: 20, flag: 'chunk-min'},
          chumax: {default: 50, flag: 'chunk-max'}
        }.transform_values do |val|
          val.merge prefix: '--'
        end
      end
    end
  end
end
