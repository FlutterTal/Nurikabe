module Grille

    ##
    # La classe grille permet la création de GrilleJouable et GrilleStatique
    class Grille

        ##
        # Variables d'instances
        #   @grille


        attr_accessor :grille

        def initialize()
            @grille = Array.new()
        end
    end
end