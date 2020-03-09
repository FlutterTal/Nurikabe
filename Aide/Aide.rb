require_relative 'StartingTechniques.rb'
require_relative 'BasicTechniques.rb'

##
# Aide pour l'utilisateur
#
# Permet de gerer les differents niveaux d'aides
class Aide
  # Variables d'instances
  # @caseC => Case en question
  # @chaine => Description de l'aide

  attr_reader :caseC, :chaine

  ##
  # Permet de créer un objet de type aide
  #
  # Paramètres :
  # [+caseC+] Case courante sur laquelle est associé une aide
	# [+chaine+] Chaine décrivant l'aide
  def Aide.creer(caseC, chaine) 
    new(caseC, chaine)
  end

  ##
  # Permet d'initialiser un objet de type aide
  #
  # Paramètres :
  # [+caseC+] Case courante sur laquelle est associé une aide
	# [+chaine+] Chaine décrivant l'aide
  def initialize(caseC, chaine)
    @caseC, @chaine = caseC, chaine
  end

  ##
  # Permet d'appliquer les aides sur la grille
  #
  # Paramètres :
  # [+grille+] Case courante sur laquelle est associé une aide
	# [+tab+] Tableau contenant les aides (pour la grille du joueur courant)
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
