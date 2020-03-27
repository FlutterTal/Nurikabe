#!/usr/bin/env ruby

require 'gtk3'
require_relative 'Accueil.rb'

Gtk.init if Gtk.respond_to? :init
fenetre = Gui::Accueil.creer
fenetre.signal_connect("destroy") {Gtk.main_quit}
Gtk.main
