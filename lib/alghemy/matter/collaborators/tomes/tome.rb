require_relative 'tome/ear'
require_relative 'tome/gnumbers'

# Superclass for collections of sijils
class Tome < Array
  include Gnumbers
  alias _collect collect

  def to_s
    join(' ')
  end

  # Ensure collected Tome returns Tome
  def collect( &block )
    self.class.new _collect(&block)
  end

  # Iterate through Tome, invoking a Rubric to create new Matter
  def invoke( algput, rubric )
    Ear.listen algput.dir
    send('each_' + algput.enum.to_s) do |input|
      input  = input.ffglob if ffroup(rubric.class, algput.enum)
      output = input.swap_parts algput.parts
      io = {input: input.to_s, output: output}
      rubric.intone io
    end
    Ear.amputate
  end

  def each_group_sijil( &block )
    group_sijils = each_group.collect {|grim| grim.globvert }
    group_sijils = Scribe.transcribe group_sijils
    block_given? ? group_sijils.each_lmnt(&block) : group_sijils.to_enum
  end

  # Abstract a Sijil that matches all of Tome
  def globvert
    glob_replace( first_lmnt, numbers )
  end

  # Return depth of 2-dimensional Elements,
  # e.g Elements made of two or more split Element.
  def dims
    dims = gnums(numbers).compact.size
    dims > 1 ? dims : nil
  end

  private

  def numbers
    list = self[0..-(size / 2)].to_a.flatten
    num_list list
  end

  def ffroup( rubriclass, enum )
    rubriclass == Ffock && enum == :group_sijil
  end
end
