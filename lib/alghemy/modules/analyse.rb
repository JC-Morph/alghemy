require 'alghemy/comrades'
require 'alghemy/modules'

module Alghemy
  module Modules
    # Public: Analyse a file with a tool.
    module Analyse
      include Modules[:request]
      attr_reader :cat, :fmt
      alias request this

      def this( sijil, asp = nil )
        return report(sijil) unless asp
        @cat = catdex[asp] || asp
        @fmt = fmtdex[asp]
        result = request(sijil).strip
        format result
      end

      def report( sijil )
        Comrades[:invoker].cast [moniker, "\"#{sijil}\"", '2>&1']
      end

      def process
        moniker << sub_process << input
      end

      private

      def aspdex( arr )
        index = Struct.new(*infodex)
        index.new(*arr)
      end

      def catdex
        {}
      end
      alias fmtdex catdex

      def infodex
        raise NotImplementedError
      end

      def format( result )
        return result unless fmt
        fmt.is_a?(Proc) ? fmt.call(result) : result.send(fmt)
      end
    end
  end
end
