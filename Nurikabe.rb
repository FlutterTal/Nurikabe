#!/usr/bin/env ruby

require 'gtk3'
require_relative 'Grille/GrilleJouable.rb'
require_relative 'GUI/Fenetre.rb'

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
            fenetre = Gui::Fenetre.new
            fenetre.signal_connect("destroy") { self.quit }
            self.add_window(fenetre)
        }
    end
    
end

Nurikabe.new.run
