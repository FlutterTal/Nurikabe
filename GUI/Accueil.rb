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
            
            self.valign = Gtk::Align::CENTER
            self.halign = Gtk::Align::CENTER
            
#             self.pack_start(Gtk::Button.new.tap { |bouton|
#                 bouton.add(Gtk::Label.new.tap { |label|
#                     label.set_markup("<b>Tutoriel</b>")
#                     label.show
#                 })
#                 bouton.height_request = 64
#                 bouton.width_request = 400
#                 bouton.margin_bottom = 10
#                 bouton.signal_connect("clicked") { app.tutoriel }
#                 bouton.show
#             }, :expand => true, :fill => true, :padding => 0)

            self.pack_start(Gtk::Button.new.tap { |bouton|
                bouton.add(Gtk::Label.new.tap { |label|
                    chaine = "<b>Aventure</b>"
                    if(app.utilisateur) then
                        chaine += "\nNiveau #{app.utilisateur.aventure + 1}" +
                            " · Crédit : #{app.utilisateur.credit}"
                    end
                    label.markup = chaine
                    label.justify = Gtk::Justification::CENTER
                    label.show
                })
                bouton.margin_bottom = 10
                bouton.height_request = 64
                bouton.width_request = 400
                bouton.signal_connect("clicked") { app.aventure }
                bouton.show
            }, :expand => true, :fill => true, :padding => 0)

            self.pack_start(Gtk::Button.new.tap { |bouton|
                bouton.add(Gtk::Label.new.tap { |label|
                    chaine = "<b>Arcade</b>"
                    if(app.utilisateur) then
                        chaine += "\n#{app.utilisateur.grilleArcade.length}"
                        chaine += " niveau"
                        if(app.utilisateur.grilleArcade.length > 1) then
                            chaine += "s"
                        end
                        chaine += " terminé"
                        if(app.utilisateur.grilleArcade.length > 1) then
                            chaine += "s"
                        end
                    end
                    label.markup = chaine
                    label.justify = Gtk::Justification::CENTER
                    label.show
                })
                bouton.margin_bottom = 10
                bouton.height_request = 64
                bouton.width_request = 400
                bouton.signal_connect("clicked") { app.arcade }
                bouton.show
            }, :expand => true, :fill => true, :padding => 0)

            self.pack_start(Gtk::Button.new.tap { |bouton|
                bouton.add(Gtk::Label.new.tap { |label|
                    label.set_markup("<b>Options</b>")
                    label.show
                })
                bouton.signal_connect("clicked") { app.options }
                bouton.show
                bouton.height_request = 64
                bouton.width_request = 400
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
