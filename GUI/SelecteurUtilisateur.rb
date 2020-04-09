require 'gtk3'
require_relative '../Utilisateur/Utilisateur.rb'

module Gui
    
    ##
    # Fenêtre permettant de choisir un utilisateur ou d'en créer un.
    class SelecteurUtilisateur < Gtk::Dialog
        
        ##
        # Ligne du sélecteur d'utilisateur représentant un utilisateur.
        class Ligne < Gtk::Box
        
            ##
            # Nom de l'utilisateur concerné (String)
            attr_reader :nom
            
            ##
            # Crée une ligne qui accueillera les données de l'utilisateur.
            #
            # Paramètres :
            # [+nom+]   Nom de l'utilisateur (String)
            def initialize(nom)
                super(:horizontal)
                @nom = nom
                self.pack_start(Gtk::Image.new(
                    icon_name: 'user', size: :dialog).tap { |icone|
                    icone.pixel_size = 48
                    icone.margin_left = 4
                    icone.margin_right = 4
                    icone.margin_top = 4
                    icone.margin_bottom = 4
                    icone.show
                })
                self.pack_start(Gtk::Label.new.tap { |label|
                    label.margin_top = 4
                    label.margin_bottom = 4
                    label.margin_right = 4
                    label.markup = "<b>#{nom}</b>"
                    label.show
                })
                self.show
            end
            
        end
        
        ##
        # Boîte de dialogue permettant de créer un nouvel utilisateur.
        class NouvelUtilisateurDialogue < Gtk::Dialog
        
            ##
            # Identifiant de l'action _Annuler_ (Integer)
            ANNULER = 0
            
            ##
            # Identifiant de l'action _Créer un utilisateur_ (Integer)
            CREER = 1
            
            ##
            # Crée une nouvelle boîte de dialogue permettant de créer un
            # utilisateur.
            #
            # Paramètres :
            # [+parent+]    Fenêtre parente à la boîte de dialogue
            # [+app+]       Application (Nurikabe)
            def initialize(parent, app)
                super(title: "Nouvel utilisateur", parent: parent,
                      flags: Gtk::DialogFlags::USE_HEADER_BAR |
                      Gtk::DialogFlags::MODAL |
                      Gtk::DialogFlags::DESTROY_WITH_PARENT)
                champs = Gtk::Entry.new.tap { |champs|
                    champs.signal_connect("activate") {
                        self.signal_emit("response", CREER)
                    }
                    champs.show
                }
                self.content_area.add(
                    Gtk::Box.new(:horizontal).tap { |box|
                    box.expand = true
                    box.pack_start(
                        Gtk::Image.new(icon_name: 'user',
                                       size: :dialog).tap { |icone|
                        icone.pixel_size = 64
                        icone.margin_left = 4
                        icone.margin_right = 4
                        icone.margin_top = 4
                        icone.margin_bottom = 4
                        icone.show
                    })
                    box.add(Gtk::Box.new(:vertical).tap { |box2|
                        box2.expand = true
                        box2.pack_start(Gtk::Label.new(
                            "Nom d'utilisateur :").tap { |label|
                            label.xalign = 0
                            label.show
                        })
                        box2.pack_start(champs)
                        box2.show
                    })
                    box.show
                })
                self.add_button("Annuler", ANNULER)
                self.add_button("Créer un utilisateur", CREER)
                self.signal_connect("response") { |dialogue, action|
                    case action
                    when CREER then
                        unless(champs.text.empty?) then
                            app.utilisateur = Utilisateur::Utilisateur.Creer(
                                champs.text)
                            app.utilisateur.sauvegarde
                            app.accueil
                            dialogue.close
                            parent.close
                        end
                    when ANNULER then
                        dialogue.close
                    end
                }
                self.show
            end
            
        end
        
        ##
        # Crée la fenêtre du sélecteur d'utilisateur.
        #
        # Paramètres :
        # [+parent+]        Fenêtre parente au sélecteur d'utilisateur
        # [+app+]           Application (Nurikabe)
        def initialize(parent, app = nil)
            super(parent: parent, flags: Gtk::DialogFlags::MODAL |
                  Gtk::DialogFlags::DESTROY_WITH_PARENT)
            self.title = "Sélectionnez un utilisateur"
            self.default_width = 600
            self.default_height = 400
            self.content_area.add(Gtk::Box.new(:vertical).tap { |box|
                box.pack_start(Gtk::ScrolledWindow.new.tap { |sw|
                    sw.add_with_viewport(Gtk::ListBox.new.tap { |liste|
                        @liste = liste
                        @liste.selection_mode = :single
                        @liste.signal_connect("row-activated") { |liste, ligne|
                            app.utilisateur = Utilisateur::Utilisateur.
                                chargerUtilisateur(ligne.children[0]) if(app)
                            app.accueil
                            self.close
                        }
                        Utilisateur::Utilisateur.comptesUtilisateurs.
                            each { |nom|
                            @liste.insert(Ligne.new(nom), -1)
                        }
                        @liste.show
                    })
                    sw.expand = true
                    sw.show
                }, {fill: true})
                box.pack_end(Gtk::Button.new(
                    label: "Nouvel utilisateur").tap { |bouton|
                    bouton.signal_connect("clicked") {
                        NouvelUtilisateurDialogue.new(self, app)
                    }
                    bouton.show
                })
                box.expand = true
                box.show
            })
            self.signal_connect("destroy") {
                if(app.nil?) then
                    Gtk.main_quit
                elsif(app.utilisateur.nil?) then
                    app.quit
                end
            }
            self.show
        end
        
    end
    
end
        
