# Rubric subclasses
%w[sock ffock spell ffell mrs].each do |rubric|
  require_relative File.join( 'rubrics', rubric )
end
