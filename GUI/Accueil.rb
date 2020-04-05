require 'gtk3'

module Gui

    ##
    # Widget graphique représentant l'écran d'accueil.
    class Accueil < Gtk::Box
        
        ##
        # Méthode permettant de créer l'écran d'accueil.
        def initialize
            super(:vertical, 10)

            self.pack_start(Gtk::Button.new.yield_self { |bouton|
                bouton.add(Gtk::Label.new.yield_self { |label|
                    label.set_markup("<b>Tutoriel</b>")
                    label.show
                    label
                })
                bouton.show
                bouton
            }, :expand => true, :fill => true, :padding => 0)

            self.pack_start(Gtk::Button.new.yield_self { |bouton|
                bouton.add(Gtk::Label.new.yield_self { |label|
                    label.set_markup("<b>Aventure</b>")
                    label.show
                    label
                })
                bouton.show
                bouton
            }, :expand => true, :fill => true, :padding => 0)

            self.pack_start(Gtk::Button.new.yield_self { |bouton|
                bouton.add(Gtk::Label.new.yield_self { |label|
                    label.set_markup("<b>Arcade</b>")
                    label.show
                    label
                })
                bouton.show
                bouton
            }, :expand => true, :fill => true, :padding => 0)

            self.pack_start(Gtk::Button.new.yield_self { |bouton|
                bouton.add(Gtk::Label.new.yield_self { |label|
                    label.set_markup("<b>Options</b>")
                    label.show
                    label
                })
                bouton.show
                bouton
            }, :expand => true, :fill => true, :padding => 0)
            
            self.show
        end
    end

end
