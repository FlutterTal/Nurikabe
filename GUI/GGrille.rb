require 'gtk3'
require_relative '../Grille/CaseJouable.rb'
require_relative '../Grille/CaseNumero.rb'
require_relative '../Sauvegarde/Historique.rb'
require_relative 'GCaseJouable.rb'
require_relative 'GCaseNumero.rb'

module Gui
    
    ##
    # Widget graphique représentant une GrilleJouable.
    class GGrille < Gtk::Grid
    
        ## Historique de la grille
        attr_reader :historique
        
        ##
        # Crée un widget graphique représentant la grille donnée pour
        # l'utilisateur donné. L'historique est ouvert automatiquement.
        #
        # Paramètres :
        # [+grille+]        Grille
        # [+utilisateur+]   Utilisateur
        def initialize(grille, utilisateur = nil)
            super()
            if(utilisateur) then
                @historique = Sauvegarde::Historique.ouvrir(utilisateur, grille)
            else
                @historique = nil
            end
            self.style_context.add_class("grille")
            grille.grille.grille.each { |ligne|
                ligne.each { |c|
                    gc = nil
                    if(c.kind_of? Grille::CaseJouable) then
                        gc = GCaseJouable.new(c, @historique)
                    elsif(c.kind_of? Grille::CaseNumero) then
                        gc = GCaseNumero.new(c)
                    else
                        raise "Classe invalide pour la case #{c.class}"
                    end
                    self.attach(gc, c.colonne, c.ligne, 1, 1)
                }
            }
            self.show
        end
        
        ##
        # Met à jour les cases de la grille.
        def update
            self.each { |c| c.update }
            return self
        end
        
        ##
        # Le bloc donné sera exécuté lorsque la grille sera mise à jour.
        #
        # Les blocs n'ont aucun paramètre.
        def on_update(&bloc)
            self.each { |c| c.on_update(&bloc) }
            return self
        end
        
        ##
        # Désactive toutes les cases.
        def desactiver
            self.each { |c| c.sensitive = false }
            return self
        end
        
        ##
        # Affiche les erreurs données.
        #
        # Paramètres :
        # [+erreurs+]   Array de [ligne, colonne]
        def erreurs=(erreurs)
            self.each { |c|
                c.erreur = erreurs.include? [c.case.ligne, c.case.colonne]
            }
            return self
        end
        
        ##
        # Met en surbrillance la case de coordonnées données.
        #
        # Paramètres :
        # [+x+] Coordonnée horizontale
        # [+y+] Coordonnée verticale
        def aide(x, y)
            self.each { |c|
                c.aide = c.case.ligne == x && c.case.colonne == y
            }
            return self
        end
        
    end

end
