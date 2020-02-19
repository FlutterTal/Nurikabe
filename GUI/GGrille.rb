require 'gtk3'
require_relative '../Grille/CaseJouable.rb'
require_relative '../Grille/CaseNumero.rb'
require_relative 'GCaseJouable.rb'
require_relative 'GCaseNumero.rb'

module Gui
    
    ##
    # Widget graphique représentant une GrilleJouable.
    class GGrille < Gtk::Grid
      
        private_class_method :new
        
        ##
        # Crée un widget graphique représentant la grille donnée.
        #
        # Paramètres :
        # [+grille+]  Grille
        def GGrille.creer(grille)
            g = new
            grille.grille.grille.each do |ligne|
                ligne.each do |c|
                    gc = nil
                    if(c.kind_of? CaseJouable)
                    then
                        gc = GCaseJouable.creer(c)
                    elsif(c.kind_of? CaseNumero) then
                        gc = GCaseNumero.creer(c)
                    else
                        raise "Classe invalide pour la case #{c.class}"
                    end
                    g.attach(gc, c.colonne, c.ligne, 1, 1)
                end
            end
            return g
        end
        
        ##
        # Initialise une grille.
        def initialize
            super
            self.show
        end
        
    end

end
