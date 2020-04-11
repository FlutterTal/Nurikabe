require 'gtk3'

module Gui

    ##
    # Widget graphique représentant une Case.
    #
    # Classe de base des classes GCaseJouable et GCaseNumero.
    class GCase < Gtk::Button

        ## Taille d'un côté d'une case (Integer)
        TAILLE = 64
        
        ## Case représentée par le widget
        attr_reader :case
        
        private_class_method :new
        
        ##
        # Initialise un widget graphique représentant une case.
        #
        # Paramètre :
        # [+c+] Case
        def initialize(c)
            super()
            @case = c
            self.width_request = TAILLE
            self.height_request = TAILLE
            self.style_context.add_class("case")
            self.show
        end

    end

end
