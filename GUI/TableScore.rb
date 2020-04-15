require 'gtk3'

module Gui

    ##
    # Widget graphique représentant le tableau de scores.
    class TableScore < Gtk::Table
        
        ##
        # Méthode permettant de créer le tableau de scores.
        def new
            super(6, 2, true)
            self.attach("Utilisateur", 0, 1, 0, 1)
            self.attach("Temps", 1, 2, 0, 1)
            self.show
        end
    end
    
end
