require 'alghemy/glyphs'

module Alghemy
  module Comrades
    # Public: Decipher the shorthand used for Option automation.
    module Cryptographer
      class << self
        include Methods[:decipher]

        def decipher_options( options )
          auto_options(options).transform_values do |value|
            decipher value.sub(auto_key, '')
          end
        end

        private

        def auto_options( options )
          options.select do |_k, val|
            next unless val.is_a?(String)
            val[%r{^#{auto_key}}]
          end
        end

        def auto_key
          'a//'
        end
      end
    end
  end
end
