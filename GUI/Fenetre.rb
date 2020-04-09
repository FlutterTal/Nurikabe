require 'gtk3'

module Gui

    ##
    # Fenêtre principale de l'application
    class Fenetre < Gtk::Window
        
        ##
        # Crée une fenêtre principale.
        #
        # Paramètres :
        # [+app+]   Application (Nurikabe)
        def initialize(app)
            super()
            self.default_width = 800
            self.default_height = 600
            self.icon_name = "applications-games"
            self.titlebar = Gtk::HeaderBar.new.yield_self { |barre_titre|              
                barre_titre.title = "Nurikabe"
                barre_titre.show_close_button = true
                barre_titre.show
                barre_titre
            }
            self.signal_connect("destroy") { app.quit }
            self.show
        end
        
    end
    
end
