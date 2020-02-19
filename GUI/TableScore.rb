require 'gtk3'

module Gui

    class TableScore < Gtk::Table
        def TableScore.creer
            table = new(6, 2, true)
            table.attach("Utilisateur", 0, 1, 0, 1)
            table.attach("Temps", 1, 2, 0, 1)
            return table
        end
    end
    
end