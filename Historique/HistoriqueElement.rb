require_relative '../Erreur/Erreur.rb'

##
# Un élément de l'historique
#
# Il représente le changement d'état d'une case ainsi que la validité du nouvel état
# Tous ses attributs sont en lecture seule
class HistoriqueElement
    attr_reader :case, :etat_avant, :etat_apres, :erreur
    private_class_method :new

    ##
    # Crée un élément de l'historique
    #
    # Prend en paramètres une case, son ancien état et son nouvel état
    def HistoriqueElement.Creer(case, etat_avant, etat_apres)
        new(case, etat_avant, etat_apres)
    end

    ##
    # Initialise l'élément et vérifie la validité du nouvel état
    def initialize(case, etat_avant, etat_apres)
        @case = case
        @etat_avant = etat_avant
        @etat_apres = etat_apres
        # METTRE A JOUR PLUS TARD
        @erreur = Erreur.verif_case(case)
    end

end