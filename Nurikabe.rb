#!/usr/bin/env ruby

require 'gtk3'
require_relative 'Grille/GrilleJouable.rb'
require_relative 'GUI/Fenetre.rb'
require_relative 'GUI/SelecteurUtilisateur.rb'

##
# Application
#
# Classe singleton (voir Nurikabe::app).
class Nurikabe < Gtk::Application

    # Application
    @@app = nil

    ##
    # Retourne l'application.
    #
    # Crée l'application si elle n'existe pas.
    def Nurikabe.app
        @@app = new if(@app.nil?)
        return @@app
    end
        
    private_class_method :new
    
    ##
    # Crée une nouvelle application.
    #
    # Méthode privée, utiliser Nurikabe::app pour créer l'application.
    def initialize
        super("org.projet.Nurikabe", :flags_none)
        provider = Gtk::CssProvider.new
        provider.load(path: "GUI/grille.css")
        Gtk::StyleContext.add_provider_for_screen(
            Gdk::Display.default.default_screen,
            provider,
            20000)
        self.signal_connect("activate") {
            fenetre = Gui::Fenetre.new
            fenetre.signal_connect("destroy") { self.quit }
            selecteur = Gui::SelecteurUtilisateur.new(fenetre, [], self)
            self.add_window(fenetre)
        }
    end
    
end

Nurikabe.app.run
