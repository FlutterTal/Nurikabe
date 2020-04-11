require_relative 'GCase.rb'

module Gui
    
    ##
    # Widget graphique représentant une CaseNumero.
    class GCaseNumero < GCase
        
        public_class_method :new
        
        ##
        # Crée un widget graphique représentant une CaseNumero.
        #
        # Paramètre :
        # [+c+] CaseNumero
        def initialize(c)
            super(c)
            self.label = c.numero
            self.style_context.add_class("case_numero")
        end
        
    end
    
end
