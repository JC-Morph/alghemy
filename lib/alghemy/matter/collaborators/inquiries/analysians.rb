# Require Element analyser classes
%w[eye probe scry].each do |analysian|
  require_relative File.join( 'analysians', analysian )
end
