# Require Inquiry classes
%w[analysians beholders].each do |inquiry|
  require_relative File.join('inquiries', inquiry)
end
