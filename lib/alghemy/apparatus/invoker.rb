module Alghemy
  module Apparatus
    # Public: Execute a command. Accepts Strings and Arrays as viable processes.
    # Use #io to inject input and output.
    module Invoker
      class << self
        def io( process, io = {}, verbose = false )
          process = compress(process, io) % io
          puts process if verbose
          engage process
        end

        def compress( process, io = {} )
          return process if process.is_a? String
          process.flatten.collect do |lmnt|
            lmnt.is_a?(Proc) ? lmnt.call(io) : lmnt
          end.join(' ')
        end

        def engage( process )
          `#{compress process}`
        end
      end
    end
  end
end
