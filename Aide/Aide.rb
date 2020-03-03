require_relative 'StartingTechniques.rb'
require_relative 'BasicTechniques.rb'
require_relative 'AdvancedTechniques.rb'

class Aide

    # Instancier si erreur detecter
    def initialize(c, technique)
      @case = c
      @technique = technique # Chaine de caractete
    end

    def update_credit()

    end

    # Méthode statique => Verification
    def Aide.detecter(grille)
      StartingTechniques.case1(grille)
      StartingTechniques.caseVide(grille)
      StartingTechniques.caseDiag(grille)
      BasicTechniques.caseVideEntoure(grille)
      BasicTechniques.largeurMur(grille)
    end

end
