require 'alghemy/glyphs'

module Alghemy
  module Assistants
    # Public: Handles identifying iterative numbers in filename Strings.
    module Gnumbers
      def num_list( filenames )
        filenames.each.with_object([]) do |filename, arr|
          arr << num_scan(filename)
        end
      end

      def num_scan( filename )
        File.basename(filename.to_s).scan(/\d+/)
      end

      def glob_replace
        parts = all_entries.map do |sij|
          sij.base.split('_')
        end.transpose.map(&:uniq)
        sijil = first_lmnt.swap_parts base: gen_base(parts)
        Glyphs[:sijil].compose sijil
      end

      # Public: Returns Array of numbers in num_list that iterate.
      def e_nums( num_list )
        sizes = num_list.collect(&:size).sort
        return [] if sizes.first != sizes.last
        num_list.transpose.collect do |row|
          enum = row.uniq.size.between?(2, row.size)
          enum ? row.first : nil
        end.compact
      end

      private

      def gen_base( parts )
        parts.map do |part|
          next part if part.size == 1
          next num_glob(part) if part.all?(/^\d+$/)
          sizes = part.map(&:size).uniq
          sizes.size == 1 ? '?' * sizes.first : '*'
        end.join('_')
      end

      def num_glob( part )
        char_cols = part.map(&:chars).transpose
        char_cols.each.with_object([]) do |chars, arr|
          chars = chars.map(&:to_i)
          arr << "[#{chars.min}-#{chars.max}]"
        end.join
      end
    end
  end
end
