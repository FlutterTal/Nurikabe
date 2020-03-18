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
            box = Gtk::Box.new(:vertical, 10)
            fenetre.add(box)
            box.show

            tutorial = Gtk::Button.new
            ltutorial = Gtk::Label.new
            ltutorial.set_markup("<b>Tutorial</b>")
            tutorial.add(ltutorial)
            ltutorial.show
            tutorial.signal_connect("clicked") {puts "Accès au tutorial"}
            box.pack_start(tutorial, :expand => true, :fill => true, :padding => 0)
            tutorial.show

            aventure = Gtk::Button.new
            laventure = Gtk::Label.new
            laventure.set_markup("<b>Aventure</b>\n" +
                                "<span weight=\"light\" style=\"italic\">Niveau #number\tCrédits : 5</span>")
            aventure.add(laventure)
            laventure.show
            aventure.signal_connect("clicked") {puts "Accès à l'aventure"}
            box.pack_start(aventure, :expand => true, :fill => true, :padding => 0)
            aventure.show

            arcade = Gtk::Button.new
            larcade = Gtk::Label.new
            larcade.set_markup("<b>Arcade</b>\n" +
                              "<span weight=\"light\" style=\"italic\">#number terminés\tMoyenne : #temps</span>")
            arcade.add(larcade)
            larcade.show
            arcade.signal_connect("clicked") {puts "Accès au mode arcade"}
            box.pack_start(arcade, :expand => true, :fill => true, :padding => 0)
            arcade.show

            options = Gtk::Button.new
            loptions = Gtk::Label.new
            loptions.set_markup("<b>Options</b>")
            options.add(loptions)
            loptions.show
            options.signal_connect("clicked") {puts "Accès aux options"}
            box.pack_start(options, :expand => true, :fill => true, :padding => 0)
            options.show

            fenetre.show

            return fenetre
        end
    end

end