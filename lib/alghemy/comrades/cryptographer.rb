module Alghemy
  module Comrades
    # Public: Decipher the shorthand used for Option automation.
    module Cryptographer
      class << self
        def decipher_options( options )
          auto_options(options).transform_values {|value| decipher value }
        end

        # Public: Expects a Hash of options to initialise Rubric with.
        def stuff; end

        # Public: Expects an instance of Matter. Must respond to #raw? method,
        # to discern whether the input will be raw data.
        def lmnt; end

        private

        def auto_options( hsh )
          hsh.select do |_k, val|
            next unless val.is_a?(String)
            val[auto_key]
          end
        end

        def auto_key
          %r{^a//}
        end

        def decipher( value )
          parts = val_split value
          iterate(parts) if parts.size == 3 && parts[1] == '/'
        end

        def val_split( value )
          value.sub(auto_key, '').split(%r{([*/])})
        end

        def iterate( parts )
          count = parts[-1].to_i
          max   = parts[0].to_f
          step  = max / (count - 1)
          count.times.with_object([]) do |iterations, arr|
            arr << (step * iterations).round(3)
          end
        end
      end
    end
  end
end
