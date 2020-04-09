#!/usr/bin/env ruby

require 'gtk3'
require_relative 'Accueil.rb'

Gtk.init if Gtk.respond_to? :init
fenetre = Gtk::Window.new
fenetre.signal_connect("destroy") {Gtk.main_quit}
fenetre.add(Gui::Accueil.new)
fenetre.show
Gtk.main
