require 'gtk3'

module Gui

    ##
    # Page d'options, contenant un bouton de suppression du compte.
    class Options < Gtk::Box
    
        ## Barre de titre associée à cette page
        attr_reader :titlebar
        
        ##
        # Crée la page d'option.
        #
        # Paramètres :
        # [+app+]   Nurikabe
        def initialize(app)
            super(:vertical)
            
            self.valign = Gtk::Align::CENTER
            self.halign = Gtk::Align::CENTER
            
            @titlebar = Gtk::HeaderBar.new.tap { |barre|
                barre.title = "Nurikabe"
                barre.subtitle = app.utilisateur.nom
                barre.show_close_button = true
                barre.pack_start(BoutonRetour.new.tap { |bouton|
                    bouton.signal_connect("clicked") { app.accueil }
                })
                barre.show
            }
            self.pack_start(
                Gtk::Button.new(label: "Supprimer le compte").tap { |bouton|
                bouton.signal_connect("clicked") {
                    Gtk::Dialog.new(title: "Confirmation",
                                    parent: app.fenetre,
                                    flags: Gtk::DialogFlags::USE_HEADER_BAR |
                                    Gtk::DialogFlags::MODAL |
                                    Gtk::DialogFlags::DESTROY_WITH_PARENT
                    ).tap { |boite|
                        boite.content_area.add(Gtk::Label.new.tap { |label|
                            label.markup = "<b>Êtes-vous sûr de vouloir " +
                                "supprimer votre compte ?</b>"
                            label.show
                        })
                        boite.add_button("Supprimer", 1)
                        boite.add_button("Annuler", Gtk::ResponseType::CLOSE)
                        boite.signal_connect("response") { |boite, rep|
                            case rep
                            when 1 then
                                File.unlink("UtilisateurJeu/" +
                                            app.utilisateur.nom)
                                app.quit
                            when Gtk::ResponseType::CLOSE
                                boite.close
                            end
                        }
                        boite.show
                    }
                }
                bouton.show
            })
            self.show
        end
        
    end
    
end
