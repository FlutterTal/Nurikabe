require 'gtk3'

module Gui

    class Accueil < Gtk::Window
        def Accueil.creer
            fenetre = new
            fenetre.set_title("Nurikabe")
            box = Gtk::Box.new(:horizontal, 4)
            fenetre.add(box)

            tutorial = Gtk::Button.new(:label => "Tutorial")
            tutorial.signal_connect("clicked") {puts "Accès au tutorial"}
            box.pack_start(tutorial, :expand => true, :fill => true, :padding => 0)

            aventure = Gtk::Button.new(:label => "Aventure")
            aventure.signal_connect("clicked") {puts "Accès à l'aventure"}
            box.pack_start(aventure, :expand => true, :fill => true, :padding => 0)

            arcade = Gtk::Button.new(:label => "Arcade")
            arcade.signal_connect("clicked") {puts "Accès au mode arcade"}
            box.pack_start(arcade, :expand => true, :fill => true, :padding => 0)

            options = Gtk::Button.new(:label => "Options")
            options.signal_connect("clicked") {puts "Accès aux options"}
            box.pack_start(options, :expand => true, :fill => true, :padding => 0)

            return fenetre
        end
    end

end