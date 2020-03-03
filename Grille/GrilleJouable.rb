require_relative 'GrilleStatique.rb'
require_relative 'Grille.rb'

require_relative '../Utilisateur/Utilisateur.rb'
=begin
require_relative '../Historique/Historique.rb'
=end

class GrilleJouable < Grille
    attr_reader :erreur, :locErreur, :grille, :solution
    private_class_method :new

    def GrilleJouable.creer(unNumero)
        new(unNumero)
    end

    def initialize(unNumero)
        @solution = GrilleStatique.creer(unNumero)
        @grille = Grille.new()
        ligneGrille = Array.new()
        
        @solution.grilleS.grille.each { |ligne|
            ligne.each{ |cases|
                if cases.class != CaseNumero
                    ligneGrille.push(CaseJouable.creer("B",@grille.grille.length,ligneGrille.length))
                else
                    ligneGrille.push(cases)
                end   
            }
            @grille.grille.push(Array.new(ligneGrille))
            ligneGrille.clear
        }

        @erreur = 0
        @locErreur = Array.new()
    end

    def verifErreur()
        self.grille.grille.each{ |ligne|
            ligne.each{ |cases|
                if !self.verifCase(cases) 
                    @erreur += 1
                    @locErreur.push([cases.ligne,cases.colonne])
                end
            }
        }
    end

    def verifCase(uneCase)
        if uneCase.class == CaseJouable && uneCase.etatCase != self.solution.grilleS.grille[uneCase.ligne][uneCase.colonne].etatCase
            return false
        else   
            return true
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

=begin
A TESTER
    def chargerGrille(unUtilisateur)
        Historique.Ouvrir(unUtilisateur, self.grille).replay{ |c| self.grille.grille.case[c.ligne][[c.colonne].etatCase = c.etat_apres}       
    end
=end

    def grilleTerminee
        return self.erreur == 0
    end
=begin
    def donnePoint(unUtilisateur)
        unUtilisateur.credit += 5
        return self
    end
=end
    def to_s()
        str = ""
        @grille.grille.each { |ligne|
            ligne.each{ |cases| str += cases.to_s}
            str += "\n"
        }
        return str + "\n"
    end
end