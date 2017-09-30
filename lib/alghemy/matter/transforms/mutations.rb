require_relative 'mute_get'
# Require Mutation classes
%w[append mutate].each do |mutation|
  require_relative File.join('transmutations', mutation)
end

# Mutate method module
module Mutable
  include MuteGet

  def mutate( lyst = {} )
    mutation = mute_get __callee__
    mutation.new(self, lyst).implement
  end
  # Define method calls
  mutations = %i[append]
  mutations.each do |mutation|
    alias_method mutation, :mutate
  end
end
