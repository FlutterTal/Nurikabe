require 'gtk3'
require_relative 'BoutonRetour.rb'

module Gui
    
    ##
    # Affichage de la liste des grilles disponibles pour un mode de jeu donné
    # sous forme de grille.
    class SelecteurGrille < Gtk::ScrolledWindow
    
        ##
        # Bouton de sélection d'une grille.
        class BoutonGrille < Gtk::Box
            
            ##
            # Crée un bouton pour la grille donnée.
            def initialize(numero)
                super(:vertical)
                self.pack_start(Gtk::Button.new.yield_self { |bouton|
                    bouton.add(Gtk::Label.new.yield_self { |label|
                        label.text = numero.to_s
                        label.show
                        label
                    })
                    bouton.width_request = 64
                    bouton.height_request = 64
                    bouton.show
                    bouton
                })
                self.pack_start(Gtk::Label.new.yield_self { |label|
                    label.text = "6x7"
                    label.show
                    label
                })
                self.show
            end
            
        end
        
        ## Barre de titre à utiliser avec cette box.
        attr_reader :titlebar
        
        ##
        # Crée le sélecteur de grille pour un mode de jeu donné.
        #
        # Paramètre :
        # [+app+]   Application (Nurikabe)
        # [+mode+]  Mode de jeu (String)
        def initialize(app, mode)
            super()
            self.add(Gtk::FlowBox.new.yield_self { |box|
                1.upto(5) { |i| box.add(BoutonGrille.new(i)) }
#                 box.selection_mode = :none
                box.show
                box
            })
            self.show
            @titlebar = Gtk::HeaderBar.new.yield_self { |barre|
                barre.title = "Grilles " + mode
                barre.subtitle = app.utilisateur.nom
                barre.show_close_button = true
                barre.pack_start(BoutonRetour.new.yield_self { |bouton|
                    bouton.signal_connect("clicked") { app.accueil }
                    bouton
                })
                barre.show
                barre
            }
        end
        
    end
    
end
