# Require collaborative classes
%w[evoke inquiries scribe sijil space].each do |collaborator|
  require_relative File.join( 'collaborators', collaborator )
end
