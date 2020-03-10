require 'gtk3'

module Gui
    
    ##
    # Fenêtre permettant de choisir un utilisateur ou d'en créer un.
    class SelecteurUtilisateur < Gtk::Window
        
        ##
        # Ligne du sélecteur d'utilisateur représentant un utilisateur.
        class Ligne < Gtk::Box
            
            ##
            # Label où sont écrites les informations (Gtk::Label)
            attr_reader :label
            
            ##
            # Utilisateur concerné
            attr_accessor :utilisateur
            
            private_class_method :new
            
            ##
            # Crée une ligne pour l'utilisateur donné.
            #
            # Paramètres :
            # [+utilisateur+]   Utilisateur
            def Ligne.creer(utilisateur)
                ligne = new
                ligne.label.markup = "<b>#{utilisateur.nom}</b>\n" + 
                        "<span weight=\"light\" style=\"italic\"> Crédit : " +
                        "#{utilisateur.credit}</span>"
                ligne.utilisateur = utilisateur
                return ligne
            end
            
            ##
            # Crée une ligne qui accueillera les données de l'utilisateur.
            #
            # Méthode privée, utiliser Gui::SelecteurUtilisateur::Ligne.creer.
            def initialize
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
                @label.show
                self.pack_start(@label)
                self.show
            end
            
        end
        
        ##
        # Gtk::ListBox contenant les Gtk::SelecteurUtilisateur::Ligne
        attr_reader :liste
        
        private_class_method :new
        
        ##
        # Crée un sélecteur d'utilisateurs.
        #
        # Paramètres :
        # [+utilisateurs+]  Utilisateurs à ajouter (Array de Utilisateur)
        def SelecteurUtilisateur.creer(utilisateurs)
            selecteur = new
            utilisateurs.each { |u| selecteur.liste.insert(Ligne.creer(u), -1) }
            return selecteur
        end
        
        ##
        # Crée la fenêtre du sélecteur d'utilisateur.
        #
        # Méthode privée, utiliser Gui::SelecteurUtilisateur.creer.
        def initialize
            super
            self.default_width = 400
            self.default_height = 300
            box = Gtk::Box.new(:vertical)
            scrolled_window = Gtk::ScrolledWindow.new
            @liste = Gtk::ListBox.new
            @liste.selection_mode = :single
            @liste.signal_connect("row-activated") { |liste, ligne|
                puts "Utilisateur #{ligne.children[0].utilisateur} sélectionné"
            }
            @liste.show
            scrolled_window.add_with_viewport(@liste)
            scrolled_window.expand = true
            scrolled_window.propagate_natural_height = true
            scrolled_window.show
            box.pack_start(scrolled_window)
            bouton = Gtk::Button.new(label: "Nouvel utilisateur")
            bouton.show
            box.pack_end(bouton)
            box.show
            self.add(box)
            self.show
        end
        
    end
    
end
        
