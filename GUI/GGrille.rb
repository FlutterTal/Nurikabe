require 'gtk3'
require_relative '../Grille/CaseJouable.rb'
require_relative '../Grille/CaseNumero.rb'
require_relative 'GCaseJouable.rb'
require_relative 'GCaseNumero.rb'

module Gui
    
    ##
    # Widget graphique représentant une GrilleJouable.
    class GGrille < Gtk::Grid
        
        ##
        # Crée un widget graphique représentant la grille donnée.
        #
        # Paramètres :
        # [+grille+]  Grille
        def initialize(grille)
            super()
            self.style_context.add_class("grille")
            grille.grille.grille.each { |ligne|
                ligne.each { |c|
                    gc = nil
                    if(c.kind_of? Grille::CaseJouable) then
                        gc = GCaseJouable.creer(c)
                    elsif(c.kind_of? Grille::CaseNumero) then
                        gc = GCaseNumero.creer(c)
                    else
                        raise "Classe invalide pour la case #{c.class}"
                    end
                    self.attach(gc, c.colonne, c.ligne, 1, 1)
                }
            }
            self.show
        end
        
    end

end
