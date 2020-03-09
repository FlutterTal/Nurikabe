require 'gtk3'

module Gui

    ##
    # Widget graphique représentant le tableau de scores.
    class TableScore < Gtk::Table
        
        ##
        # Méthode permettant de créer le tableau de scores.
        def TableScore.creer
            table = new(6, 2, true)
            table.attach("Utilisateur", 0, 1, 0, 1)
            table.attach("Temps", 1, 2, 0, 1)
            table.show
            return table
        end
    end
    
end