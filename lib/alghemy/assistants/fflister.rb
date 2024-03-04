require 'alghemy/factories'

module Alghemy
  module Assistants
    # Public: Transmutation methods to assist in creating text input files for
    # ffmpeg. Useful when multiple input files are wanted for the same stream.
    module Fflister
      # Public: Assign the variables necessary to allow for files to be read
      # from a text file by the Alghemist.
      #
      # pad - Boolean whether to use #pad_input on the list.
      def fflist_prep( pad: false )
        stuff[:format]    = 'concat'
        stuff[:name_tome] = tome
        @mult = false
        @tome = pad ? pad_input : write_list
      end

      private

      # Internal: Append the first file to the end of the list, twice. Useful
      # for creating properly looped videos with the LoopFade Transmutation?
      def pad_input
        list = tome.entries.append(*[tome.first] * 2)
        write_list list
      end

      # Internal: Create a text file with the list of files to be used.
      #
      # list - Array containing filenames.
      def write_list( list = tome )
        fflist = '.fflist.txt'
        list = list.map {|file| "file '#{file}'\n" }
        File.write(fflist, list.join)
        Factories[:scribe].call [fflist]
      end
    end
  end
end
