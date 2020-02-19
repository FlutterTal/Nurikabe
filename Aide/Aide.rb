require_relative 'StartingTechniques.rb'

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
    end

end
