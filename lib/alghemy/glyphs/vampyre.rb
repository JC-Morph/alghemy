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
      alias lay_to_rest write_to_file
      delegate plot: :result
      attr_reader :type, :result

      def self.list
        list = Comrades[:invoker].cast('sonic-annotator --list').split("\n")
        list - ['LibXtract compiled with ooura FFT']
      end

      def self.rouse_from( coffin )
        name = File.basename(coffin, '.*').gsub('~', ':')
        new(name).vampyre_affiliation.new coffin
      end

      def initialize( sijil = 'spec' )
        @type  = vampyre_type sijil
        awaken_vampyre
      end

      def read
        lines.map(&:chomp)
      end

      # Public: Sink fangs into a juicy sound file and suck out the features.
      # Returns clan knowledge resulting from the analysis inherent in the type
      # of the Vampyre.
      def bite( sound, portions = nil, parameters = {} )
        serve_portions(sound, portions)
        edit_parameters parameters
        ritual = scribe_awakening_ritual sound
        vamp   = perform ritual
        coffin = "#{type.split(':')[-2..].join('~')}.csv"
        @result = vampyre_affiliation.new lay_to_rest(vamp, coffin)
      end

      def scribe_awakening_ritual( sound )
        [
          'sonic-annotator',
          ['-t', vampyre_coffin],
          sound.sijil.to_s,
          '-w csv',
          '--csv-stdout'
        ]
      end

      def serve_portions( sound, portions )
        return unless portions
        clan = vampyre_affiliation
        block_mul = clan == VampClans[:ample] ? 1 : 2
        edit_sizes(sound.span / portions, block_mul)
      end

      def vampyre_affiliation
        affiliations = Data[:vamp_affiliations]
        clans = affiliations.keys.select do |clan|
          affiliations[clan].include?(type[/[\w_-]+:[\w_-]+$/])
        end
        alget(clans.first || affiliations.keys.first)
      end

      def edit( var, block_mul = 1 )
        data = lines
        send(__callee__[/(?<=edit)\w+$/], var, data)
        convince_vampyre data
      end
      alias edit_parameters edit
      alias edit_rate       edit
      alias edit_samples    edit

      def _parameters( lyst, data )
        lyst.each do |key, val|
          index = data.index {|line| line[/#{parameter_identity % key}/] }
          data[index.succ].sub!(parameter_value, val.to_s)
        end
      end

      def _rate( rate, data )
        index = data.index {|line| line[/vamp:sample_rate/] }
        return data[index].sub!(rate_value, rate.to_s) if index

        index = data.index {|line| line[/vamp:plugin /] }.succ
        data.insert(index, "    vamp:sample_rate \"#{rate}\"^^xsd:int ;")
      end

      def _samples( samples, data )
        %w[step window].each do |type|
          index = data.index {|line| line[/#{type}samples/] }
          data[index].sub!(samples_value(type), samples.to_s)
        end
      end

      def edit_sizes( size, block_mul = 1 )
        data = lines
        %w[block step].each do |type|
          index = data.index {|line| line[/vamp:#{type}_size/] }
          new_size = type == 'block' ? size * block_mul : size
          data[index].sub!(size_value(type), new_size.to_s)
        end
        convince_vampyre data
      end

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

      private

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
        File.join(alget(:ROOT), 'vampyre.n3')
      end

      def lines
        File.readlines vampyre_coffin
      end

      def parameter_identity
        ['(?<=vamp:identifier \")', '%s', '(?=\")'].join
      end

      def parameter_value
        /(?<=value \")[\w\.]+(?=\")/
      end

      def rate_value
        value_wrap 'vamp:sample_rate'
      end

      def size_value( type )
        value_wrap "#{type}_size"
      end

      def samples_value( type )
        value_wrap "#{type}samples"
      end

      def value_wrap( ident )
        /(?<=#{ident} \")\d+(?=\")/
      end

      def vampyre_type( sijil )
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
