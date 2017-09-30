# Require Matter subclasses.
%w[image sound video].each do |affinity|
  require_relative File.join( 'affinities', affinity + '_classes' )
end
