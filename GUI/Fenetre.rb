require 'gtk3'

module Gui

    ##
    # Fenêtre principale de l'application
    class Fenetre < Gtk::Window
        
        ##
        # Crée une fenêtre principale.
        def initialize
            super
            self.icon_name = "applications-games"
            barre_titre = Gtk::HeaderBar.new
            barre_titre.title = "Nurikabe"
            barre_titre.show_close_button = true
            barre_titre.show
            self.titlebar = barre_titre
            self.show
        end
        
    end
    
end
