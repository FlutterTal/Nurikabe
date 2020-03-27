#!/usr/bin/env ruby

require 'gtk3'
require_relative 'Grille/GrilleJouable.rb'
require_relative 'GUI/GGrille.rb'

##
# Application
class Nurikabe < Gtk::Application
    
    ##
    # Crée une nouvelle application.
    def initialize
        super("org.projet.Nurikabe", :flags_none)
        provider = Gtk::CssProvider.new
        provider.load(path: "GUI/grille.css")
        Gtk::StyleContext.add_provider_for_screen(
            Gdk::Display.default.default_screen,
            provider,
            20000)
        self.signal_connect("activate") {
            fenetre = Gtk::Window.new
            fenetre.set_title("Nurikabe")
            fenetre.signal_connect("destroy") { Gtk.main_quit }
            fenetre.set_window_position(Gtk::WindowPosition::CENTER)
            fenetre.add(Gui::GGrille.creer(GrilleJouable.creer(1)))
            fenetre.show
        }
    end
    
end

Nurikabe.new.run
Gtk.main
