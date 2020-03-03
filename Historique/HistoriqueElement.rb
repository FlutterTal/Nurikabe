require_relative '../Grille/GrilleJouable.rb'

module Historique
    ##
    # Un élément de l'historique
    #
    # Il représente le changement d'état d'une case ainsi que la validité du nouvel état
    # Tous ses attributs sont en lecture seule
    class HistoriqueElement
        attr_reader :cases, :etat_avant, :etat_apres, :erreur
        private_class_method :new

        ##
        # Crée un élément de l'historique
        #
        # Prend en paramètres une case, son ancien état et son nouvel état
        def HistoriqueElement.Creer(cases, etat_avant, etat_apres)
            new(cases, etat_avant, etat_apres)
        end

        ##
        # Initialise l'élément et vérifie la validité du nouvel état
        def initialize(cases, etat_avant, etat_apres)
            @cases = cases
            @etat_avant = etat_avant
            @etat_apres = etat_apres
            @erreur = verifCase(cases)
        end

    end
end