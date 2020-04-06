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

            self.pack_start(Gtk::Button.new.yield_self { |bouton|
                bouton.add(Gtk::Label.new.yield_self { |label|
                    label.set_markup("<b>Tutoriel</b>")
                    label.show
                    label
                })
                bouton.signal_connect("clicked") { app.tutoriel }
                bouton.show
                bouton
            }, :expand => true, :fill => true, :padding => 0)

            self.pack_start(Gtk::Button.new.yield_self { |bouton|
                bouton.add(Gtk::Label.new.yield_self { |label|
                    label.set_markup("<b>Aventure</b>")
                    label.show
                    label
                })
                bouton.signal_connect("clicked") { app.aventure }
                bouton.show
                bouton
            }, :expand => true, :fill => true, :padding => 0)

            self.pack_start(Gtk::Button.new.yield_self { |bouton|
                bouton.add(Gtk::Label.new.yield_self { |label|
                    label.set_markup("<b>Arcade</b>")
                    label.show
                    label
                })
                bouton.signal_connect("clicked") { app.arcade }
                bouton.show
                bouton
            }, :expand => true, :fill => true, :padding => 0)

            self.pack_start(Gtk::Button.new.yield_self { |bouton|
                bouton.add(Gtk::Label.new.yield_self { |label|
                    label.set_markup("<b>Options</b>")
                    label.show
                    label
                })
                bouton.signal_connect("clicked") { app.options }
                bouton.show
                bouton
            }, :expand => true, :fill => true, :padding => 0)
            
            self.show
            
            @titlebar = Gtk::HeaderBar.new.yield_self { |barre|
                barre.title = "Nurikabe"
                barre.subtitle = app.utilisateur.nom if(app.utilisateur)
                barre.show_close_button = true
                barre.pack_start(BoutonRetour.new.yield_self { |bouton|
                    bouton.sensitive = false
                    bouton
                })
                barre.show
                barre
            }
        end
    end

end
