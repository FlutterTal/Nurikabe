require_relative 'Case.rb'
require_relative 'CaseNumero.rb'
require_relative 'CaseJouable.rb'
require_relative 'Grille'

class GrilleStatique < Grille
    attr_reader :taille_ligne, :taille_colonne, :numero, :grilleS
    private_class_method :new

    def GrilleStatique.creer(unNumero)
        new(unNumero)
    end

    def initialize(unNumero)
        @grilleS = Grille.new
        ligneGrille = Array.new

        @numero = unNumero
        fichierGrille = File.new("Grilles.txt", "r")
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

    def case_plateau(l,c)
        return self.grilleS.grille[l][c]
    end

    def to_s()
        str = ""
        @grilleS.grille.each { |ligne|
            ligne.each{ |cases| str += cases.to_s}
            str +="\n"
        }
        return str + "\n"
    end
end
