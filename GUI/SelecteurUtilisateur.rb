require 'gtk3'

module Gui
    
    ##
    # Fenêtre permettant de choisir un utilisateur ou d'en créer un.
    class SelecteurUtilisateur < Gtk::Dialog
        
        ##
        # Ligne du sélecteur d'utilisateur représentant un utilisateur.
        class Ligne < Gtk::Box
        
            ##
            # Utilisateur concerné
            attr_reader :utilisateur
            
            ##
            # Crée une ligne qui accueillera les données de l'utilisateur.
            #
            # Paramètres :
            # [+utilisateur+]   Utilisateur
            def initialize(utilisateur)
                super(:horizontal)
                icone = Gtk::Image.new(icon_name: 'user', size: :dialog)
                icone.pixel_size = 48
                icone.margin_left = 4
                icone.margin_right = 4
                icone.margin_top = 4
                icone.margin_bottom = 4
                icone.show
                self.pack_start(icone)
                @label = Gtk::Label.new
                @label.margin_top = 4
                @label.margin_bottom = 4
                @label.margin_right = 4
                @label.markup = "<b>#{utilisateur.nom}</b>\n" + 
                        "<span weight=\"light\" style=\"italic\"> Crédit : " +
                        "#{utilisateur.credit}</span>"
                @label.show
                @utilisateur = utilisateur
                self.pack_start(@label)
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
            def initialize(parent)
                super(parent: parent)
                box_principale = Gtk::Box.new(:horizontal)
                box_principale.expand = true
                icone = Gtk::Image.new(icon_name: 'user', size: :dialog)
                icone.pixel_size = 64
                icone.margin_left = 4
                icone.margin_right = 4
                icone.margin_top = 4
                icone.margin_bottom = 4
                icone.show
                box_principale.pack_start(icone)
                box_secondaire = Gtk::Box.new(:vertical)
                box_secondaire.expand = true
                label = Gtk::Label.new("Nom d'utilisateur :")
                label.xalign = 0
                label.show
                box_secondaire.pack_start(label)
                champs = Gtk::Entry.new
                champs.show
                box_secondaire.pack_start(champs)
                box_secondaire.show
                box_principale.add(box_secondaire)
                box_principale.show
                self.content_area.add(box_principale)
                self.add_button("Annuler", ANNULER)
                self.add_button("Créer un utilisateur", CREER)
                self.signal_connect("response") { |dialogue, action|
                    case action
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
        # [+utilisateurs+]  Utilisateurs à ajouter (Array de Utilisateur)
        # [+app+]           Application (Nurikabe)
        def initialize(parent, utilisateurs, app = nil)
            super(parent: parent)
            self.title = "Sélectionnez un utilisateur"
            self.default_width = 600
            self.default_height = 400
            box = Gtk::Box.new(:vertical)
            scrolled_window = Gtk::ScrolledWindow.new
            @liste = Gtk::ListBox.new
            @liste.selection_mode = :single
            @liste.signal_connect("row-activated") { |liste, ligne|
                puts "Utilisateur #{ligne.children[0].utilisateur} sélectionné"
                self.close
            }
            utilisateurs.each { |u| @liste.insert(Ligne.new(u), -1) }
            @liste.show
            scrolled_window.add_with_viewport(@liste)
            scrolled_window.expand = true
            scrolled_window.show
            box.pack_start(scrolled_window, {fill: true})
            nouvel_utilisateur = Gtk::Button.new(label: "Nouvel utilisateur")
            nouvel_utilisateur.signal_connect("clicked") { |bouton|
                NouvelUtilisateurDialogue.new(self)
            }
            nouvel_utilisateur.show
            box.pack_end(nouvel_utilisateur)
            box.expand = true
            box.show
            self.content_area.add(box)
            self.signal_connect("destroy") {
                if(app.nil?) then
                    Gtk.main_quit
                else
                    app.quit
                end
            }
            self.show
        end
        
    end
    
end
        
