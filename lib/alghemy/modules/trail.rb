require 'alghemy/comrades'
require 'alghemy/methods'

module Alghemy
  module Modules
    # Public: Methods used to dissect a path. Similar to Pathname.
    module Trail
      include Methods[:alget]

      # Public: Open Matter with default application.
      def behold
        spell = Gem.win_platform? ? fenestrate : "xdg-open #{self}"
        Comrades[:invoker].cast "#{spell} > /dev/null 2>&1"
      end

      # Public: Convert Trail for Windows processes.
      #
      # Returns String.
      def fenestrate
        seps = %w[/ \\]
        path = swap_parts dir: dir.gsub(*seps)
        "\"#{path.sub(*seps)}\""
      end

      # Public: Replace parts in Trail.
      #
      # other_parts - Hash of parts to replace.
      #              :dir  - Directory.
      #              :base - Basename.
      #              :seq  - Numerical sequence.
      #              :ext  - Extension.
      #
      # Returns new instance of class.
      def swap_parts( other_parts = {} )
        swap = parts.merge other_parts
        file = swap[:base]
        file += swap[:seq] if swap[:seq]
        file += swap[:ext]
        self.class.new File.join(swap[:dir], file)
      end

      # Public: Returns Directory.
      def dir
        File.dirname to_s
      end

      # Public: Basename.
      def base
        File.basename(to_s, '.*')
      end

      # Public: Extension.
      def ext
        File.extname to_s
      end

      # Public: Attempt to return unique part of Trail.
      def label
        dir_label || unglob.base
      end

      # Public: Attempt to detect a descriptive directory if present.
      def dir_label
        root = alget(:ROOT)
        sep  = alget(:SEP)
        child_dir = dir[/(?<=#{root + sep})[^#{sep}]+/]
        child_dir || dir[/[^#{sep}.]+$/]
      end

      def unglob
        self.class.new gsub(/[_-]*(?<!\\)[*?]+/, '')
      end

      private

      # Internal: Returns Hash containing default parts of a filename used by
      # #swap_parts method.
      def parts
        {dir: dir, base: base, ext: ext}
      end
    end
  end
end
