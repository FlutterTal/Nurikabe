require_relative 'GCase.rb'

module Gui
    
    ##
    # Widget graphique représentant une CaseNumero.
    class GCaseNumero < GCase
        
        ##
        # Crée un widget graphique représentant une CaseNumero.
        #
        # Paramètre :
        # [+c+] CaseNumero
        def GCaseNumero.creer(c)
            gc = new
            gc.case = c
            gc.label = c.numero
            gc.style_context.add_class("case_numero")
            return gc
        end
        
    end
    
end
