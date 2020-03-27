require_relative 'Case.rb'

module Grille

    ##
    # La classe CaseNuméro correspond aux case contenant les numéros et ne pouvant être modifiée
    class CaseNumero < Case

        ##
        # Variables d'instances
        #   @numero
        #   


        attr_reader :numero
        private_class_method :new
        
        def CaseNumero.creer(num,l, c)
            new(num,l, c)
        end

        ##
        # Initialise la case avec un numéro et une position
        def initialize(num, l, c)
            super(l, c)
            @numero = num
        end

        def to_s()
            return self.numero
        end
    end
end