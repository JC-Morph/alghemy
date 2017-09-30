# Tome classes
%w[grimoire metamoire].each do |tome|
  require_relative File.join( 'tomes', tome )
end
