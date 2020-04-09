require 'gtk3'

module Gui
    
    ##
    # Bouton de retour
    class BoutonRetour < Gtk::Button
        
        ##
        # Crée un bouton de retour.
        def initialize
            super(icon_name: 'draw-arrow-back')
            self.show
        end
        
    end
    
end
