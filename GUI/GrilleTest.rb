require 'gtk3'
require_relative 'GGrille.rb'
require_relative '../Grille/GrilleJouable.rb'

module Gui
    
    ##
    # Application de test pour Gui::GGrille.
    #
    # Représente une fenêtre contenant une Gui::GGrille.
    class GGrilleTest < Gtk::Window
        
        private_class_method :new
        
        ##
        # Crée une fenêtre contenant une Gui::Grille représentant la Grille
        # donnée.
        #
        # Paramètres :
        # [+grille+]  Grille
        def GGrilleTest.creer(grille)
            f = new
            
            f.set_title("Nurikabe")
            
            f.signal_connect("destroy") { Gtk.main_quit }
            
            f.set_window_position(Gtk::WindowPosition::CENTER)
            
            f.add(GGrille.creer(grille))
            
            f.show
            
            return f
        end
        
    end
  
end

Gtk.init if Gtk.respond_to?(:init)
    fenetre = Gui::GGrilleTest.creer(GrilleJouable.creer(1))
Gtk.main
