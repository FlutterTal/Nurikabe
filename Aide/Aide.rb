require_relative 'StartingTechniques.rb'
require_relative 'BasicTechniques.rb'

class Aide
  # Variables d'instances
  # @caseC => Case en question
  # @chaine => Description de l'aide

  # Méthode de classe
  def Aide.creer(caseC, chaine) 
    new(caseC, chaine)
  end

  def initialize(caseC, chaine)
    @caseC, @chaine = caseC, chaine
  end

  # Métode de classe
  def Aide.detecter(grille, tab)
    StartingTechniques.case1(grille, tab)
    StartingTechniques.caseVide(grille, tab)
    StartingTechniques.caseDiag(grille, tab)
    BasicTechniques.caseVideEntoure(grille, tab)
    BasicTechniques.largeurMur(grille, tab)
  end

  def to_s()
    return @chaine
  end

end
