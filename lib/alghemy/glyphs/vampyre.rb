require 'forwardable'
require 'alghemy/comrades'
require 'alghemy/methods'
require 'alghemy/vamp_clans'

module Alghemy
  module Glyphs
    class Vampyre
      extend Forwardable
      include Methods[:alget]
      include Methods[:write_to_file]
      delegate plot: :result
      attr_reader :sijil, :type, :result

      def self.list
        list = Comrades[:invoker].cast('sonic-annotator --list').split("\n")
        list - ['LibXtract compiled with ooura FFT']
      end

      def initialize( sijil )
        @sijil = sijil
        @type  = vampyre_type
        awaken_vampyre
      end

      def edit_rate( rate = 44100 )
        data  = lines
        index = data.index {|line| line[/vamp:plugin /] }.succ
        data.insert(index, "    vamp:sample_rate \"#{rate}\"^^xsd:int ;")
        convince_vampyre data
      end

      def edit_sizes( int, block_mul = 1 )
        data = lines
        %w(block step).each do |type|
          index    = data.index {|line| line[/vamp:#{type}_size/] }
          new_val  = int
          new_val *= block_mul if type == 'block'
          data[index].sub!(size_val(type), new_val.to_s)
        end
        convince_vampyre data
      end

      def edit_parameters( lyst )
        data = lines
        lyst.each do |key, val|
          index = data.index {|line| line[/#{parameter_identity % key}/] }
          data[index.succ].sub!(parameter_value, val.to_s)
        end
        convince_vampyre data
      end
      alias edit_params edit_parameters

      def parameters
        parameters = {}
        lines.each.with_index do |line, i|
          if line[/vamp:parameter /]
            param = line[/#{parameter_identity % '\w+'}/]
            parameters[param] = lines[i.succ][parameter_value]
          end
        end
        parameters
      end
      alias params parameters

      # Public: Sink fangs into a juicy sound file and suck out the features.
      # Returns clan knowledge resulting from the analysis inherent in the type
      # of the Vampyre.
      def bite( sound )
        process = ['sonic-annotator',
                   ['-t', vampyre_coffin],
                   sound,
                   '-w csv',
                   '--csv-stdout'].flatten
        data = `#{process * ' '}`
        out  = "#{File.basename(sound, '.*')}.csv"
        @result = vampyre_affiliation.new write_to_file(data, out)
      end

      def read
        lines.map(&:chomp)
      end

      private

      def vampyre_affiliation
        affiliations = Data[:vamp_affiliations]
        clans = affiliations.keys.select do |clan|
          affiliations[clan].include?(type[/[\w_-]+:[\w_-]+$/])
        end
        alget(clans.first || affiliations.keys.first)
      end

      # Internal: Write the initial file describing the vamp and it's
      # characteristics.
      def awaken_vampyre
        ritual = ['sonic-annotator -s', type, '>', vampyre_coffin]
        perform ritual
      end

      # Internal: Cast a commandline ritual, courtesy of our eternal Comrade,
      # the Invoker.
      def perform( ritual )
        Comrades[:invoker].cast ritual
      end

      def convince_vampyre( new_perspective )
        write_to_file(new_perspective, vampyre_coffin)
      end

      # Internal: The resting place of the latest Vampyre. At current we only
      # have one resident Vampyre at a time.
      def vampyre_coffin
        'vampyre.n3'
      end

      def lines
        File.readlines vampyre_coffin
      end

      def sizes
        {block: /vamp:block_size/, step: /vamp:step_size/}
      end

      def size_value( type )
        /(?<=#{type}_size \")\d+(?=\")/
      end

      def parameter_value
        /(?<=value \")[\d\.]+(?=\")/
      end

      def parameter_identity
        ['(?<=vamp:identifier \")', '%s', '(?=\")'].join
      end

      def vampyre_type
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
