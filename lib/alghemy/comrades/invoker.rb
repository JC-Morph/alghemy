require 'alghemy/methods'

module Alghemy
  module Comrades
    # Public: Execute a command. Accepts Strings and Arrays as viable processes.
    # Use #io to inject input and output.
    module Invoker
      class << self
        include Methods[:alget]

        # Public: Resolves processes with given input and output, interpolating
        # them in the process String.
        #
        # process - String or Array representing executable command. Array may
        #           include resolvable Procs.
        #
        # io      - Hash of inputs and outputs to be used.
        #
        # verbose - Boolean for verbosity. If true, prints process before
        #           execution.
        def io( process, io = {}, verbose = false )
          process = condense(process, io) % io
          puts process if verbose
          engage process
        end

        # Public: Takes process and formats it, flattening Arrays and resolving
        # Procs.
        #
        # Returns String.
        def condense( process, io = {} )
          return process if process.is_a? String
          process.flatten.collect do |word|
            word.is_a?(Proc) ? word.call(io) : word
          end.join(' ')
        end

        # Public: Execute given process on the command line.
        def engage( process )
          process = condense process
          puts process if alget(:verbose)
          `#{process}`
        end
      end
    end
  end
end
