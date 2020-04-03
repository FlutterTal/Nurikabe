require_relative 'Case.rb'
require_relative '../Sauvegarde/Historique.rb' 

module Grille

    ##
    # La Classe CaseJouable 
    # Elle correspond aux cases qui ne contiennent pas un numéro mais un etat: @etatCase, 
    # correspondant à leurs états possible quel le joueur choisira : @@etatPossible = {:NOIR => 'N', :BLANC => 'B', :MARK => 'M'}
    class CaseJouable < Case

        ##
        # Variables d'instances
        #   @etatCase
        #   
        # Variable de classe
        #   @etatPossible

        attr_accessor :etatCase
        private_class_method :new
        
        @@etatPossible = {:NOIR => 'N', :BLANC => 'B', :MARK => 'M'}

        def CaseJouable.creer(etat, l, c)
            new(etat, l, c)
        end

        ##
        # Initialise la case avec un numéro, une position et un etat
        def initialize(etat,l,c)
            super(l,c)
            @etatCase = @@etatPossible.key(etat)
        end

        ##
        # Restaure la case en état BLANC
        def restorCase()
            self.etatCase = @@etatPossible.key('B')
        end

        ##
        # Change l'état d'une case présente dans l'historique des coups
        def changementEtat(unEtat, historique)
            etatAvant = self.etatCase
            historique.sauvegarder(self, etatAvant, unEtat)
            self.etatCase = unEtat

            return self
        end

    end
end 
