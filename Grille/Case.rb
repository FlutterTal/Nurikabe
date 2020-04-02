module Grille

    ##
    # La Classe Case
    # Elle permet la création de cases qui seront soit de la classe CaseNuméro ou CaseJouable
    # Elle continet sa position: @ligne, @colonne et la présence d'une aide: @aide
    class Case

                ##
        # Variables d'instances
        #   @ligne
        #   @colonne
        #   @aide


        attr_reader :ligne, :colonne
        attr_reader :aide
        private_class_method :new

        def Case.creer(l, c)
            new(l,c)
        end

        def initialize(l, c)
            @ligne, @colonne = l, c
            @aide = false
        end
    end
end