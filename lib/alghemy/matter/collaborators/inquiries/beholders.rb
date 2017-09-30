# Require beholder classes
%w[fflay slay view].each do |beholder|
  require_relative File.join('beholders', beholder)
end
