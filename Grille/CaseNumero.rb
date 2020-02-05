require_relative 'Case.rb'

class CaseNumero < Case

  def CaseNumero.creer(num, l, c)
    new(num, l, c)
  end

  def initialize(num, l, c)
    super(num, l, c)
  end

  def to_s()
    return @numero
  end
end
