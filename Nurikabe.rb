#!/usr/bin/env ruby

require 'gtk3'
require_relative 'Grille/GrilleJouable.rb'
require_relative 'GUI/Fenetre.rb'
require_relative 'GUI/SelecteurUtilisateur.rb'
require_relative 'GUI/Accueil.rb'
require_relative 'GUI/SelecteurGrille.rb'
require_relative 'GUI/InterfaceJeu.rb'

##
# Application
#
# Classe singleton (voir Nurikabe::app).
class Nurikabe < Gtk::Application

    # Application
    @@app = nil
    
    # @fenetre          => Fenêtre principale de l'application
    # @grille_actuelle  => GrilleJouable actuelle
    # @historique       => Historique de la grille actuelle

    ##
    # Retourne l'application.
    #
    # Crée l'application si elle n'existe pas.
    def Nurikabe.app
        @@app = new if(@app.nil?)
        return @@app
    end
        
    private_class_method :new
    
    ## Utilisateur courant
    attr_reader :utilisateur
    
    ##
    # Crée une nouvelle application.
    #
    # Méthode privée, utiliser Nurikabe::app pour créer l'application.
    def initialize
        Dir.mkdir("UtilisateurJeu") unless(Dir.exist? "UtilisateurJeu")
        super("org.projet.Nurikabe", :flags_none)
        provider = Gtk::CssProvider.new
        provider.load(path: "GUI/grille.css")
        Gtk::StyleContext.add_provider_for_screen(
            Gdk::Display.default.default_screen,
            provider,
            20000)
        self.signal_connect("activate") {
            @fenetre = Gui::Fenetre.new(self)
            self.accueil
            selecteur = Gui::SelecteurUtilisateur.new(@fenetre, self)
            self.add_window(@fenetre)
        }
    end
    
    ##
    # Définit l'utilisateur courant.
    #
    # Ne peut être utilisé qu'une fois.
    #
    # Paramètres :
    # [+utilisateur+]   Utilisateur courant
    def utilisateur=(utilisateur)
        @utilisateur = utilisateur if(@utilisateur.nil?)
    end
    
    ##
    # Affiche l'accueil
    def accueil
        grille_deconnecter()
        accueil = Gui::Accueil.new(self)
        @fenetre.remove(@fenetre.child) if(@fenetre.child)
        @fenetre.child = accueil
        @fenetre.titlebar = accueil.titlebar
        return self
    end
    
    ##
    # Affiche la section _Tutoriel_.
    def tutoriel
        grille_deconnecter()
        puts "Tutoriel"
    end
    
    ##
    # Affiche la liste des grilles aventures.
    def aventure
        grille_deconnecter()
        return selecteur_grilles("Aventure")
    end
    
    ##
    # Affiche la liste des grilles arcades.
    def arcade
        grille_deconnecter()
        return selecteur_grilles("Arcade")
    end
    
    ##
    # Affiche les options.
    def options
        grille_deconnecter()
        puts "Options"
    end
    
    ##
    # Affiche une grille de jeu.
    #
    # Paramètres :
    # [+grille+]    \Grille de jeu (GrilleJouable)
    def grille(grille)
        grille_deconnecter()
        @grille_actuelle = grille
        interface = Gui::InterfaceJeu.new(self, grille)
        @historique = interface.historique
        @fenetre.remove(@fenetre.child) if(@fenetre.child)
        @fenetre.child = interface
        @fenetre.titlebar = interface.titlebar
    end
    
    ##
    # Sauvegarde la grille actuelle et met +grille_actuelle+ à +nil+.
    def grille_deconnecter
        if(@grille_actuelle) then
            @historique.fermer
            @historique = nil
            @grille_actuelle = nil
        end
    end
    
    private
    
    # Affiche la liste des grilles du mode donné
    def selecteur_grilles(mode)
        selecteur = Gui::SelecteurGrille.new(self, mode)
        @fenetre.remove(@fenetre.child) if(@fenetre.child)
        @fenetre.child = selecteur
        @fenetre.titlebar = selecteur.titlebar
        return self
    end
    
end

Nurikabe.app.run
