require_relative 'GrilleStatique.rb'
require_relative 'Grille.rb'

require_relative '../Utilisateur/Utilisateur.rb'
require_relative '../Sauvegarde/Historique.rb'

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

    # Donne le nombre d'erreur dans une grille et leurs position
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

    # Vérifie si une case est correct ou non par rapport à la solution
    def verifCase(uneCase)
        if uneCase.class == CaseJouable && uneCase.etatCase != self.solution.grilleS.grille[uneCase.ligne][uneCase.colonne].etatCase
            return false
        else   
            return true
        end
    end

    # réinitialise la grille avec que des cases blanches
    def reinitialiserGrille()
        @grille.grille.each { |ligne|
            ligne.each{ |cases|
                if cases.class != CaseNumero
                    cases.restorCase()
                end
            }
        }
    end

    # Charge une grille d'un utilisateur à l'aide de l'historique
    # ATTENTION : NON TESTE
    def chargerGrille(unUtilisateur)
        Historique.Ouvrir(unUtilisateur, self.grille).replay{ |c| 
            self.grille.grille.case[c.ligne][c.colonne].etatCase = c.etat_apres}
    end

    # Vérifie si une grille est terminée ou non
    def grilleTerminee?
        return self.erreur == 0
    end

    # Ajoute les crédits de la grille terminée à l'utilisateur
    def donnePoint(unUtilisateur)
        unUtilisateur.modifCredit(5)
        return self
    end

    # Va ajouter les grilles terminé en fonction du mode dans le fichier de l'utilisateur
    def grilleTerminee(unUtilisateur)
        #if self.grilleTerminee?
        #    if self.solution.mode == "Arcade"
                unUtilisateur.grilleArcade.push(self.solution.numero)

                fichier = File.open("Grille_#{self.solution.numero}", 'a+')

                if !File.zero?(fichier)
                    classement = Marshal.load(fichier)
                else
                    classement = Array.new
                end

                classement.push(Array.new("Boujour", "5"))
                Marshal.dump(classement, fichier)
                fichier.close
            #else   
                #unUtilisateur.aventure = self.solution.numero
        #end
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