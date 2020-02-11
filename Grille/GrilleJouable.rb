require_relative 'GrilleStatique.rb'
require_relative 'Grille.rb'

class GrilleJouable < Grille
    attr_reader :erreur, :locErreur, :grille, :solution
    private_class_method :new

    def GrilleJouable.creer(unNumero, unFichier)
        new(unNumero, unFichier)
    end

    def initialize(unNumero, unFichier)
        @solution = GrilleStatique.creer(unNumero, unFichier)
        @grille = Grille.new()
        ligneGrille = Array.new()
    
        @solution.grilleS.grille.each { |ligne|
            ligne.each{ |cases|
                if cases.class != CaseNumero
                    ligneGrille.push(CaseJouable.creer("B",@grille.grille.length,ligneGrille.length))
                else
                    ligneGrille.push(CaseNumero.creer(cases.numero,@grille.grille.length,ligneGrille.length))
                end   
            }
            @grille.grille.push(Array.new(ligneGrille))
            ligneGrille.clear
        }

        @erreur = 0
        @locErreur = Array.new()
    end

    def verifErreur()
        @solution.taille_ligne.times do |l|
            @solution.taille_colonne.times do |c|
                if @solution.grilleS.grille[l][c].class == CaseJouable && @solution.grilleS.grille[l][c].etatCase != self.grille.grille[l][c].etatCase
                    @erreur += 1
                    @locErreur.push([l,c])
                end
            end
        end
    end

    def reinitialiserGrille()
        @grille.grille.each { |ligne|
            ligne.each{ |cases|
                if cases.class != CaseNumero
                    cases.restorCase()
                end
            }
        }
    end

    def grilleTerminee
        return self.erreur == 0
    end

    def to_s()
        str = ""
        @grille.grille.each { |ligne|
            ligne.each{ |cases| str += cases.to_s}
            str += "\n"
        }
        return str + "\n"
    end
end