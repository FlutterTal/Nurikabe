require 'gtk3'

module Gui

    class TableScore < Gtk::Table
        def initialize
            super(6, 2, true)
            attach("Utilisateur", 0, 1, 0, 1)
            attach("Temps", 1, 2, 0, 1)
        end
    end
    
end