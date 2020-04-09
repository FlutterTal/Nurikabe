require_relative 'Case.rb'
require_relative 'CaseNumero.rb'
require_relative 'CaseJouable.rb'
require_relative 'Grille'

module Grille
    
    ##
    # La grilleStatique correspond à la grille Solution 
    #
    # Elle est constituée d'une grille de cases: @grilleS
    # Elle correspond à un numéro et un mode : @numero, @mode
    class GrilleStatique < Grille

        ##
        # Variables d'instances
        #   @grilleS
        #   @numero
        #   @mode
        #   @taille_ligne
        #   @taille_colonne


        attr_reader :taille_ligne, :taille_colonne, :numero, :grilleS, :mode

        def GrilleStatique.creer(unNumero, mode)
            new(unNumero, mode)
        end

        ##
        # La GrilleStatique est créée en fonction de son numéro qui correspond à une ligne d'un fichier contenant l'état de ses cases
        def initialize(unNumero, mode)
            @mode = mode
            @grilleS = Grille.new
            ligneGrille = Array.new

            @numero = unNumero
            
            fichierGrille = File.open("Grilles/#{@mode}", 'r')
            ligneFichier = fichierGrille.readlines[@numero-1]
            fichierGrille.close

            grille = ligneFichier.split(';')
            @taille_ligne = grille[0].to_i
            @taille_colonne = grille[1].to_i
            grille.shift
            grille.shift


            grille.each { |ligne|
                newLingne = ligne.split(//).each { |item|
                if(item.to_i != 0)   
                    ligneGrille.push(CaseNumero.creer(item,@grilleS.grille.length,ligneGrille.length))
                elsif(item == 'B' || item == 'N')
                    ligneGrille.push(CaseJouable.creer(item,@grilleS.grille.length,ligneGrille.length))
                end
                }
                @grilleS.grille.push(Array.new(ligneGrille))
                ligneGrille.clear
            }
        end
    
        ##
        # Retourne la case de la ligne l et de la colonne c
        def case_plateau(l,c)
            return self.grilleS.grille[l][c]
        end
    end
end