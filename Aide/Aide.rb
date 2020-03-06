require_relative 'StartingTechniques.rb'
require_relative 'BasicTechniques.rb'

class Aide

    # Méthode statique => Verification
    def Aide.detecter(grille, tabHach)
      StartingTechniques.case1(grille, tabHach)
      StartingTechniques.caseVide(grille, tabHach)
      StartingTechniques.caseDiag(grille, tabHach)
      BasicTechniques.caseVideEntoure(grille, tabHach)
      BasicTechniques.largeurMur(grille, tabHach)
    end

end
