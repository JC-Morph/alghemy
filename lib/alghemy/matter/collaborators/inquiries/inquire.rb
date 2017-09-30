module Inquire
  def this( sijil )
    sijil = sijil.fenestrate if windows_process?
    Process.run(process, input: sijil)
  end

  def windows_process?
    false
  end

  def process
    moniker << sub_process
  end

  def moniker
    raise NotImplementedError
  end

  def sub_process
    input
  end

  def input
    ['"%{input}"']
  end
end
