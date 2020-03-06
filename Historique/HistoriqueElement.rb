require_relative '../Grille/GrilleJouable.rb'

module Historique
    ##
    # Un élément de l'historique
    #
    # Il représente le changement d'état d'une case ainsi que la validité du nouvel état
    # Tous ses attributs sont en lecture seule
    class HHistoriqueElement
        attr_reader :case_jeu, :etat_avant, :etat_apres, :erreur
        private_class_method :new

        ##
        # Crée un élément de l'historique
        #
        # Paramètres :
		# [+case_jeu+] CaseJouable
		# [+etat_avant+] CaseJouable::etatPossible 
		# [+etat_apres+] CaseJouable::etatPossible
        def HistoriqueElement.Creer(case_jeu, etat_avant, etat_apres)
            new(case_jeu, etat_avant, etat_apres)
        end

        ##
        # Initialise l'élément et vérifie la validité du nouvel état
        #
        # Paramètres :
		# [+case_jeu+] CaseJouable
		# [+etat_avant+] CaseJouable::etatPossible 
		# [+etat_apres+] CaseJouable::etatPossible
        def initialize(case_jeu, etat_avant, etat_apres)
            @case_jeu = case_jeu
            @etat_avant = etat_avant
            @etat_apres = etat_apres
            @erreur = GrilleJouable.verifCase(case_jeu)
        end

    end
end