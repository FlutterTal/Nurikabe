require 'gtk3'
require_relative 'GGrille.rb'
require_relative 'BoutonRetour.rb'

module Gui
    
    ##
    # Interface de jeu contenant une GGrille.
    class InterfaceJeu < Gtk::Box
        
        ## Barre de titre associée à l'interface de jeu.
        attr_reader :titlebar
        
        ## Historique de la grille
        attr_reader :historique
        
        ##
        # Crée une interface de jeu pour la grille donnée.
        #
        # Paramètres :
        # [+app+]       Nurikabe
        # [+grille+]    GrilleJouable
        def initialize(app, grille)
            super(:vertical)
            
            gg = GGrille.new(grille, app.utilisateur)
            self.pack_start(gg)
            @historique = gg.historique
            
            @titlebar = Gtk::HeaderBar.new.tap { |barre|
                barre.title = "Nurikabe"
                barre.subtitle = "Niveau #{grille.solution.numero}"
                barre.show_close_button = true
                barre.pack_start(BoutonRetour.new.tap { |bouton|
                    bouton.signal_connect("clicked") {
                        case grille.solution.mode
                        when "Aventure" then app.aventure
                        when "Arcade" then app.aventure
                        else app.accueil
                        end
                    }
                })
                annuler = Gtk::Button.new(icon_name: 'edit-undo-symbolic')
                refaire = Gtk::Button.new(icon_name: 'edit-redo-symbolic')
                barre.pack_start(annuler.tap { |annuler|
                    annuler.signal_connect("clicked") {
                        @historique.precedent { |element|
                            element.case_jeu.etatCase = element.etat_avant
                        }
                        gg.update
                    }
                    annuler.sensitive = !@historique.debut?
                    annuler.show
                })
                barre.pack_start(refaire.tap { |refaire|
                    refaire.signal_connect("clicked") {
                        @historique.suivant { |element|
                            element.case_jeu.etatCase = element.etat_apres
                        }
                        gg.update
                    }
                    refaire.sensitive = !@historique.fin?
                    refaire.show
                })
                gg.on_update {
                    annuler.sensitive = !@historique.debut?
                    refaire.sensitive = !@historique.fin?
                }
                barre.pack_end(Gtk::MenuButton.new.tap { |bouton|
                    bouton.image = Gtk::Image.new(
                        icon_name: 'open-menu-symbolic')
                    bouton.show
                })
                barre.pack_end(
                    Gtk::Button.new(icon_name: 'checkmark').tap { |bouton|
                    bouton.show
                })
                barre.pack_end(
                    Gtk::Button.new(label: "Aide",
                                    icon_name: 'help-contextual').tap { |bouton|
                    bouton.show
                })
                barre.show
            }
            
            self.show
        end
        
    end
    
end
