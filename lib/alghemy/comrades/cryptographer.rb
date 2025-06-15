require 'alghemy/glyphs'

module Alghemy
  module Comrades
    # Public: Decipher the shorthand used for Option automation.
    module Cryptographer
      class << self
        include Methods[:decipher]

        def decipher_options( options )
          auto_options(options).transform_values {|value| decipher value }
        end

        def auto_options( options )
          options.each_with_object({}) do |(key, val), hsh|
            next unless val.is_a?(String) && val[%r{^#{auto_key}}]
            hsh[key] = val.sub(auto_key, '')
          end
        end

        def auto_key
          'a//'
        end
      end
    end
  end
end
