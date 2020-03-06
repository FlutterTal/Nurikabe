require 'gtk3'

module Gui

    ##
    # Widget graphique représentant une Case.
    class GCase < Gtk::Button
    
        ## Taille d'un côté d'une case
        TAILLE = 64
        
        ## Case représentée par le widget
        attr_accessor :case
        
        private_class_method :new
        
        ##
        # Initialise un widget graphique représentant une case.
        def initialize
            super
            self.width_request = TAILLE
            self.height_request = TAILLE
            self.style_context.add_class("case")
            self.show
        end
    
    end

end
