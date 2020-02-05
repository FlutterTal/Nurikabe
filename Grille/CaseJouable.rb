require_relative 'Case.rb'

class CaseJouable < Case

  def CaseJouable.creer(etat, l, c)
    new(etat, l, c)
  end

  def initialize(etat,l,c)
    super(etat,l,c)
  end
end
