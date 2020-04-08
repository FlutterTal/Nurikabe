require 'gtk3'
require_relative 'BoutonRetour.rb'

module Gui
    
    ##
    # Affichage de la liste des grilles disponibles pour un mode de jeu donné
    # sous forme de grille.
    class SelecteurGrille < Gtk::Box
        
        ## Barre de titre à utiliser avec cette box.
        attr_reader :titlebar
        
        ##
        # Crée le sélecteur de grille pour un mode de jeu donné.
        #
        # Paramètre :
        # [+app+]   Application (Nurikabe)
        # [+mode+]  Mode de jeu (String)
        def initialize(app, mode)
            super(:vertical, 10)
            self.pack_start(Gtk::Grid.new.yield_self { |grille|
                grille.show
                grille
            })
            self.show
            @titlebar = Gtk::Titlebar.new.yield_self { |barre|
                barre.title = "Grilles " + mode
                barre.subtitle = app.utilisateur.nom
                barre.show_close_button = true
                barre.pack_start(BoutonRetour.new.yield_self{ |bouton|
                    bouton.signal_connect("clicked") { app.accueil }
                    bouton
                })
                barre.show
                barre
            }
        end
        
    end
    
end
