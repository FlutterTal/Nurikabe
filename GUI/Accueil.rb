require 'gtk3'
require_relative 'BoutonRetour.rb'

module Gui

    ##
    # Widget graphique représentant l'écran d'accueil.
    class Accueil < Gtk::Box
        
        ## Barre de titre à utiliser avec cette box.
        attr_reader :titlebar
        
        ##
        # Méthode permettant de créer l'écran d'accueil.
        #
        # Paramètres :
        # [+app+]   Application (Nurikabe)
        def initialize(app)
            super(:vertical, 10)
            
            self.pack_start(Gtk::Button.new.tap { |bouton|
                bouton.add(Gtk::Label.new.tap { |label|
                    label.set_markup("<b>Tutoriel</b>")
                    label.show
                })
                bouton.margin_top = 100
                bouton.margin_bottom = 10
                bouton.margin_left = 100
                bouton.margin_right = 100
                bouton.signal_connect("clicked") { app.tutoriel }
                bouton.show
            }, :expand => true, :fill => true, :padding => 0)

            self.pack_start(Gtk::Button.new.tap { |bouton|
                bouton.add(Gtk::Label.new.tap { |label|
                    label.set_markup("<b>Aventure</b>")
                    label.show
                })
                bouton.margin_top = 10
                bouton.margin_bottom = 10
                bouton.margin_left = 100
                bouton.margin_right = 100
                bouton.signal_connect("clicked") { app.aventure }
                bouton.show
            }, :expand => true, :fill => true, :padding => 0)

            self.pack_start(Gtk::Button.new.tap { |bouton|
                bouton.add(Gtk::Label.new.tap { |label|
                    label.set_markup("<b>Arcade</b>")
                    label.show
                })
                bouton.margin_top = 10
                bouton.margin_bottom = 10
                bouton.margin_left = 100
                bouton.margin_right = 100
                bouton.signal_connect("clicked") { app.arcade }
                bouton.show
            }, :expand => true, :fill => true, :padding => 0)

            self.pack_start(Gtk::Button.new.tap { |bouton|
                bouton.add(Gtk::Label.new.tap { |label|
                    label.set_markup("<b>Options</b>")
                    label.show
                })
                bouton.margin_top = 10
                bouton.margin_bottom = 100
                bouton.margin_left = 100
                bouton.margin_right = 100
                bouton.signal_connect("clicked") { app.options }
                bouton.show
            }, :expand => true, :fill => true, :padding => 0)
            
            self.show
            
            @titlebar = Gtk::HeaderBar.new.tap { |barre|
                barre.title = "Nurikabe"
                barre.subtitle = app.utilisateur.nom if(app.utilisateur)
                barre.show_close_button = true
                barre.pack_start(BoutonRetour.new.tap { |bouton|
                    bouton.sensitive = false
                })
                barre.show
            }
        end
    end

end
