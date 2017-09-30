require_relative 'deepclone'

# Bestows a simple memory function to an Object,
# allowing a limited awareness of previous states
class Mems < Array
  extend Deepclone
  attr_reader :tran, :lvl

  # Initialise Mems as a deepclone of mems.
  # Preferred initialisation method
  def self.clonefreeze( mems )
    new(deepclone(mems))
  end

  # Recover an aspect of a memory,
  # with the option of disregarding specific affinities
  def inherit( asp, except = :Raw )
    mem = slice mem_index(except)
    return recall(asp, mem) unless asp.is_a?(Array)
    asp.each.with_object({}) do |a, hsh|
      hsh[a] = recall(a, mem)
    end
  end

  # Reverses remembered transmutations in reverse chronological order,
  # attempting to revert the Object to a previous state
  def revert( matter, levels = size )
    memories = self.class.deepclone self
    levels.times do
      @tran, @lvl = memories.shift
      revertran   = matter.revertran tran
      next if revertran.nil?
      puts "reverting #{tran}"
      revel(memories, matter)
      # reverse transmutation
      matter = matter.send(revertran, lvl)
    end
    matter
  end

  private

  # Find first mem which does not exhibit type `except`
  def mem_index( except )
    index do |mem|
      !type(mem).to_s[/#{except.to_s}/]
    end
  end

  # NOTE: STRUCTURE DEPENDENT METHODS
  # Recall type from mem
  def type( mem )
    mem[1][:extype][1]
  end

  # Recall aspect from mem
  def recall( asp, mem )
    asp == :method ? mem[0] : mem[1][asp]
  end

  # Reorder mem for passing to a Transmutant as a reversion
  def revel( memories, matter )
    lvl[:ents].reverse! if lvl[:ents]
    ext    = lvl.delete(:extype)[0]
    memrec = memories.empty? ? false : memories
    lvl.merge!(ext: ext, label: '(R)', memrec: memrec)
    tweak_space matter
  end

  # Yuv specific alterations to dimensions during sublimation
  # TODO: make a place for this where it makes sense
  def tweak_space( matter )
    return unless matter.sijil.ext == '.yuv' && tran == :sublimate
    x, y = lvl[:space].dims.collect {|n| n.odd? ? n.succ : n }
    lvl[:space] = [x, y]
  end
end
