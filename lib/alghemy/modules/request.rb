require 'alghemy/comrades'

module Alghemy
  module Modules
    # Public: Methods for input-based commandline processes.
    module Request
      # Public: Execute process with a given input.
      #
      # sijil - Sijil or filename formatted String that responds to #fenestrate.
      #         Should represent existing files.
      #
      # Returns String as result of process.
      def this( sijil )
        sijil = sijil.fenestrate if windows_process?
        Comrades[:invoker].io(process, input: sijil)
      end

      def process
        moniker << sub_process
      end

      # Public: Duck for name of executable.
      def moniker
        raise NotImplementedError
      end

      # Public: String or Array to append to #moniker.
      def sub_process
        input
      end

      # Internal: Returns Array containing String for input interpolation.
      def input
        ['"%<input>s"']
      end

      # Internal: Boolean whether utility requires Windows formatted paths.
      def windows_process?
        false
      end
    end
  end
end
