require_relative 'GrilleStatique.rb'
require_relative 'Grille.rb'
require_relative 'CaseNumero.rb'
require_relative 'CaseJouable.rb'

require_relative '../Utilisateur/Utilisateur.rb'
require_relative '../Sauvegarde/Historique.rb'
require_relative '../Classement/Classement.rb'

module Grille

    ##
    # La classe GrilleJouable correspond à la grille que le joueur pourra compléter 
    #
    # Elle est constituée d'une grille de cases: @grille, et de sa grille solution : @solution
    # Elle contient aussi le classement des joueurs l'ayant terminée: @classement
    class GrilleJouable < Grille

        ##
        # Variables d'instances
        #   @grille
        #   @solution
        #   @classement
        #   @erreur
        #   @locErreur


        attr_reader :erreur, :locErreur, :grille, :solution, :classement, :terminee
        private_class_method :new

        def GrilleJouable.creer(unNumero, mode)
            new(unNumero, mode)
        end

        ##
        # La Grille Jouable est créée à l'aide de la grille solution en changeant l'état de toutes ses cases non numérique en "BLANC"
        # Initialisation du tableau contenant de futurs erreurs,
        def initialize(unNumero, mode)
            @solution = GrilleStatique.creer(unNumero, mode)
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

            @locErreur = []
            @erreur = 0
            @classement = Classement::Classement.Creer(@solution)

            @terminee = false
            
        end

        ##
        # Donne le nombre d'erreur dans une grille et leurs position
        def verifErreur()
            @locErreur = []
            self.grille.grille.each{ |ligne|
                ligne.each{ |cases|
                    if !self.verifCase(cases, false) 
                        @locErreur.push([cases.ligne,cases.colonne])
                    end
                }
                @erreur = @locErreur.length
            }
        end

        ##
        # Vérifie si une case est correct ou non par rapport à la solution.
        #
        # Si +verif_blanches+ est à +true+ les cases blanches sont vérifiées,
        # sinon +true+ est renvoyé.
        def verifCase(uneCase, verif_blanches)
            if uneCase.kind_of? CaseJouable then
                case uneCase.etatCase
                when :NOIR then
                    return @solution.grilleS.grille[uneCase.ligne][uneCase.colonne].etatCase == :NOIR
                when :MARK then
                    return @solution.grilleS.grille[uneCase.ligne][uneCase.colonne].etatCase == :BLANC
                when :BLANC then
                    if verif_blanches then
                        return @solution.grilleS.grille[uneCase.ligne][uneCase.colonne].etatCase == :BLANC
                    else
                        return true
                    end
                end
            else
                return true
            end
        end

        ##
        # Réinitialise la grille avec que des cases blanches
        def reinitialiserGrille()
            @grille.grille.each { |ligne|
                ligne.each{ |cases|
                    if cases.class != CaseNumero
                        cases.restorCase()
                    end
                }
            }
        end

        ##
        # Charge une grille d'un utilisateur à l'aide de l'historique
        # ATTENTION : NON TESTE
        def chargerGrille(unUtilisateur)
            Sauvegarde::Historique.Ouvrir(unUtilisateur, self.grille).replay{ |c| 
                self.grille.grille.case[c.ligne][c.colonne].etatCase = c.etat_apres}
        end

        ##
        # Vérifie si la grille est terminée ou non
        def grilleTerminee?
            @terminee = @grille.grille.all? { |ligne|
                ligne.all? { |c| verifCase(c, true) }
            }
            return self.terminee
        end

        ##
        # Ajoute les crédits de la grille terminée à l'utilisateur
        def donnePoint(unUtilisateur)
            unUtilisateur.modifCredit(5)
            return self
        end

        ##
        # Va ajouter les grilles terminé en fonction du mode dans le fichier de l'utilisateur
        def grilleTerminee(unUtilisateur)
            if self.grilleTerminee?
                if self.solution.mode == "Arcade"
                    unUtilisateur.grilleArcade.push(self.solution.numero)
                    self.classement.ajouterUtilisateur(unUtilisateur, unChrono)
                else   
                    unUtilisateur.aventure = self.solution.numero
                end
            end
        end

        def self.listeGrilles(mode)

            liste=Array.new()
            
            15.times { |i| grille = GrilleJouable.creer(i+1, mode)
                liste.push(grille)
            }
            return liste
        end
    end
end
