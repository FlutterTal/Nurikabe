require_relative '../Grille/GrilleJouable.rb'

module Sauvegarde
    ##
    # Un élément de l'historique
    #
    # Il représente le changement d'état d'une case ainsi que la validité du nouvel état
    # Tous ses attributs sont en lecture seule
    class HistoriqueElement
        attr_reader :case_jeu, :etat_avant, :etat_apres, :erreur
        private_class_method :new

        ##
        # Crée un élément de l'historique
        #
        # Paramètres :
        # [+grille+] GrilleJouable
        # [+case_jeu+] CaseJouable
        # [+etat_avant+] CaseJouable::etatPossible
        # [+etat_apres+] CaseJouable::etatPossible
        def HistoriqueElement.creer(grille, case_jeu, etat_avant, etat_apres)
            new(grille, case_jeu, etat_avant, etat_apres)
        end

        ##
        # Initialise l'élément et vérifie la validité du nouvel état
        #
        # Paramètres :
        # [+grille+] GrilleJouable
        # [+case_jeu+] CaseJouable
        # [+etat_avant+] CaseJouable::etatPossible
        # [+etat_apres+] CaseJouable::etatPossible
        def initialize(grille, case_jeu, etat_avant, etat_apres)
            @case_jeu = case_jeu
            @etat_avant = etat_avant
            @etat_apres = etat_apres
            @erreur = !grille.verifCase(case_jeu, false)
        end


        def to_s
            return "\tcase: " + @case_jeu.to_s + "\tetat_avant: " + @etat_avant + "\tetat_apres: " + @etat_apres + "\terreur: " + @erreur.to_s
        end
    end
end
