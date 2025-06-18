require 'forwardable'
require 'alghemy/methods'
require 'alghemy/vamp_clans'

module Alghemy
  module Glyphs
    class Skeleton
      extend Forwardable
      include Methods[:alget]
      include Methods[:write_to_file]
      delegate plot: :result
      attr_reader :sijil, :id, :result

      def self.list
        list = `sonic-annotator --list`.split("\n")
        list - ['LibXtract compiled with ooura FFT']
      end

      def initialize( sijil )
        @sijil = sijil
        @id    = skeleton_id
        write_skeleton
      end

      def edit_rate( rate = 44100 )
        data  = lines
        index = data.index {|line| line[/vamp:plugin /] }.succ
        data.insert(index, "    vamp:sample_rate \"#{rate}\"^^xsd:int ;")
        revise_skeleton data
      end

      def edit_sizes( int, block_mul = 1 )
        data = lines
        %w(block step).each do |type|
          index    = data.index {|line| line[/vamp:#{type}_size/] }
          new_val  = int
          new_val *= block_mul if type == 'block'
          data[index].sub!(size_val(type), new_val.to_s)
        end
        revise_skeleton data
      end

      def edit_params( lyst )
        data = lines
        lyst.each do |k, v|
          index = data.index {|line| line[/#{param_id % k}/] }
          data[index.succ].sub!( param_val, v.to_s )
        end
        revise_skeleton data
      end

      def params
        params = {}
        lines.each.with_index do |line, i|
          if line[/vamp:parameter /]
            param         = line[/#{param_id % '\w+'}/]
            params[param] = lines[i.succ][param_val]
          end
        end
        params
      end

      def analyse( sound )
        process = ['sonic-annotator',
                   ['-t', skeleton_file],
                   sound,
                   '-w csv',
                   '--csv-stdout'].flatten
        data    = `#{process * ' '}`
        out     = "#{File.basename(sound, '.*')}.csv"
        @result = alget(vamp_affiliation).new write_to_file(data, out)
      end

      def read
        lines.map(&:chomp)
      end

      private

      def vamp_affiliation
        affiliations = Data[:vamp_affiliations]
        affiliations.keys.select do |type|
          affiliations[type].include?(id[/[\w_-]+:[\w_-]+$/])
        end.first || affiliations.keys.first
      end

      def write_skeleton
        process = ['sonic-annotator -s', id, '>']
        `#{process * ' '} #{skeleton_file}`
      end

      def revise_skeleton( data )
        write_to_file(data, skeleton_file)
      end

      def skeleton_file
        'vamp_def.n3'
      end

      def lines
        File.readlines skeleton_file
      end

      def sizes
        {block: /vamp:block_size/, step: /vamp:step_size/}
      end

      def size_val( type )
        /(?<=#{type}_size \")\d+(?=\")/
      end

      def param_val
        /(?<=value \")[\d\.]+(?=\")/
      end

      def param_id
        ['(?<=vamp:identifier \")', '%s', '(?=\")'].join
      end

      def skeleton_id
        list  = self.class.list
        found = list.select {|vamp| vamp[/#{sijil}/] }
        if found.size > 1
          puts "More than one match found; select index:\n\n"
          found.each.with_index {|vamp, i| puts "#{i}:\t" + vamp }
          index = gets.chomp.to_i
          found = [found[index]]
        end
        found.first
      end
    end
  end
end
