#!/usr/bin/env ruby

require 'gtk3'
require_relative 'SelecteurUtilisateur.rb'

##
# Fausse classe Utilisateur utilisée pour la démo.
class DemoUtilisateur
    
    ##
    # Nom de l'utilisateur (String)
    attr_reader :nom
    
    ##
    # Crédit de l'utilisateur (Integer)
    attr_reader :credit
    
    ##
    # Crée un faux utilisateur de nom et de crédit donnés.
    #
    # Paramètres :
    # [+nom+]       Nom de l'utilisateur (String)
    # [+credit+]    Crédit de l'utilisateur (Integer)
    def initialize(nom, credit)
        @nom, @credit = nom, credit
    end
    
end

Gtk.init if Gtk.respond_to? :init
utilisateurs = []
1.upto(8) { |i| 
    utilisateurs << DemoUtilisateur.new("Utilisateur #{i}", 10 * i)
}
selecteur = Gui::SelecteurUtilisateur.creer(utilisateurs)
selecteur.signal_connect("destroy") { Gtk.main_quit }
Gtk.main
