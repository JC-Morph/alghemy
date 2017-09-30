# Require Transmutant classes
%w[mutations transpositions].each do |transform|
  require_relative File.join('transforms', transform)
end
