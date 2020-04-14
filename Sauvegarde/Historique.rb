require_relative 'HistoriqueElement.rb'

module Sauvegarde
    ##
    # Un historique de partie
    #
    # Il contient une liste de HistoriqueElement
    class Historique
        private_class_method :new

        ##
        # Ouvre un historique pour un utilisateur et une grille
        #
        # Paramètres :
        # [+utilisateur+] Utilisateur
        # [+grille+] GrilleJouable
        def Historique.ouvrir(utilisateur, grille)
            new(utilisateur, grille)
        end

        ##
        # Crée le fichier correspondant à l'historique de la partie ou ouvre celui déjà existant
        #
        # Paramètres :
        # [+utilisateur+] Utilisateur
        # [+grille+] GrilleJouable
        def initialize(utilisateur, grille)
            @grille = grille
            nom = "Hist_#{utilisateur.nom}_#{grille.solution.numero}"
            if File.exist?(nom)
                @fichier = File.new(nom, "r+")
                @historique = Marshal.load(@fichier)
            else
                @fichier = File.new(nom, "w")
                @historique = Array.new
            end
            @index = 0
        end

        ##
        # Ajoute un nouvel élément à l'historique
        #
        # Met à jour l'objet ET le fichier de sauvegarde
        #
        # Paramètres :
        # [+case_jeu+] CaseJouable
        # [+etat_avant+] CaseJouable::etatPossible
        # [+etat_apres+] CaseJouable::etatPossible
        def sauvegarder(case_jeu, etat_avant, etat_apres)
            unless fin?
                @historique.slice!(@index..@historique.size)
                @index = @historique.size
            end
            @historique[@index] = HistoriqueElement.creer(@grille, case_jeu, etat_avant, etat_apres)
            @index += 1
            @fichier.pwrite(Marshal.dump(@historique),0)
            return self
        end

        ##
        # Ferme le fichier
        #
        # Nécessite de le réouvrir pour l'utiliser à nouveau
        def fermer
            unless fin?
                @historique.slice!(@index..@historique.size)
                @index = @historique.size
            end
            @fichier.pwrite(Marshal.dump(@historique),0)
            @fichier.close
        end

        ##
        # Renvoie l'élément précédant l'élément courant
        #
        # Bloc optionel
        def precedent
            @index -= 1
            yield @historique[@index] if block_given?
            return @historique[@index]
        end

        ##
        # Renvoie l'élément suivant l'élément courant
        #
        # Bloc optionel
        def suivant
            @index += 1
            yield @historique[@index - 1] if block_given?
            return @historique[@index - 1]
        end

        ##
        # Vrai si l'élément courant est le dernier de l'historique
        def fin?
            return @index == @historique.size
        end

        ##
        # vrai si l'historique est vide
        def debut?
            return @index == 0
        end

        ##
        # Execute le bloc du premier au dernier coup
        #
        # Donne en paramètre de bloc des HistoriqueElement
        def replay
            @index = 0
            until self.fin?
                yield @historique[@index]
                @index += 1
            end
            return self
        end

        def to_s
            res = "path: " + @fichier.path + "\nnb_coups: " + @historique.size.to_s + "\nCoups: "
            @historique.each { |e|
                res += "\n" + e.to_s
            }
            res += "\n"
            return res
        end
    end
end
