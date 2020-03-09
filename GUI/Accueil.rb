require 'gtk3'

module Gui

    ##
    # Widget graphique représentant l'écran d'accueil.
    class Accueil < Gtk::Window
        
        ##
        # Méthode permettant de créer l'écran d'accueil.
        def Accueil.creer
            fenetre = new
            fenetre.set_title("Nurikabe")
            box = Gtk::Box.new(:horizontal, 4)
            fenetre.add(box)
            box.show

            tutorial = Gtk::Button.new(:label => "Tutorial")
            tutorial.signal_connect("clicked") {puts "Accès au tutorial"}
            box.pack_start(tutorial, :expand => true, :fill => true, :padding => 0)
            tutorial.show

            aventure = Gtk::Button.new(:label => "Aventure")
            aventure.signal_connect("clicked") {puts "Accès à l'aventure"}
            box.pack_start(aventure, :expand => true, :fill => true, :padding => 0)
            aventure.show

            arcade = Gtk::Button.new(:label => "Arcade")
            arcade.signal_connect("clicked") {puts "Accès au mode arcade"}
            box.pack_start(arcade, :expand => true, :fill => true, :padding => 0)
            arcade.show

            options = Gtk::Button.new(:label => "Options")
            options.signal_connect("clicked") {puts "Accès aux options"}
            box.pack_start(options, :expand => true, :fill => true, :padding => 0)
            options.show

            fenetre.show

            return fenetre
        end
    end

end