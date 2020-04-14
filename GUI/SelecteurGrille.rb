require 'gtk3'
require_relative 'BoutonRetour.rb'
require_relative '../Grille/GrilleJouable.rb'

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
            #
            # Paramètres :
            # [+grille+]    Grille
            # [+app+]       Nurikabe
            def initialize(grille, app)
                super(:vertical)
                self.pack_start(Gtk::Button.new.tap { |bouton|
                    bouton.signal_connect("clicked") { app.grille(grille) }
                    bouton.add(Gtk::Label.new.tap { |label|
                        label.text = grille.solution.numero.to_s
                        label.show
                    })
                    bouton.width_request = 64
                    bouton.height_request = 64
                    bouton.show
                })
                self.pack_start(Gtk::Label.new.tap { |label|
                    label.text = "#{grille.solution.taille_ligne}" +
                        "x#{grille.solution.taille_colonne}"
                    label.show
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
            self.add_with_viewport(Gtk::FlowBox.new.tap { |box|
                Grille::GrilleJouable.listeGrilles(mode).each { |grille|
                    box.add(BoutonGrille.new(grille, app))
                }
                box.margin_top = 20
                box.margin_bottom = 20
                box.margin_left = 20
                box.margin_right = 20
                box.row_spacing = 20
                box.column_spacing = 20
                box.selection_mode = :none
                box.show
            })
            self.show
            @titlebar = Gtk::HeaderBar.new.tap { |barre|
                barre.title = "Nurikabe"
                barre.subtitle = "Grilles " + mode
                barre.show_close_button = true
                barre.pack_start(BoutonRetour.new.tap { |bouton|
                    bouton.signal_connect("clicked") { app.accueil }
                })
                barre.show
            }
        end
        
    end
    
end
