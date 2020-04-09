require_relative '../Grille/GrilleJouable.rb'
require_relative '../Utilisateur/Utilisateur.rb'

module Classement
    ##
    # La Classe Classement
    # Elle permet la création du classment des joueur pour une grille: @classement
    # Chaque classement de chaque grille est stocké dans un fichier qui lui est propre: @fichier
    class Classement

        ##
        # Variables d'instances
        #   @fichier
        #   @classement

        attr_reader :fichier
        attr_accessor :classement

        def Classement.Creer(uneGrille)
            new(uneGrille)
        end

        ##
        # Un classement est créé en même temps que le fichier dans lequel il sera stocké
        # C'est un simple tableau contenant le pseudo des joueurs et leur meilleur temps
        def initialize(uneGrille)
            fichier = File.open("Classement/Classement_Grille_#{uneGrille.numero}", 'a+')
            fichier.close

            @fichier = "Classement_Grille_#{uneGrille.numero}"
            @classement = Array.new()
        end

        ##
        # Permet d'ajouter un joueur au classement d'un grille en y inscrivant son pseudo et son temps
        def ajouterUtilisateur(unUtilisateur, unChrono)
            if self.utilisateurPresent(unUtilisateur) != nil
                self.supprimerUtilisateur(unUtilisateur)
            end

            tab = Array.new.push(unUtilisateur.nom).push(unChrono)
            self.classement.push(tab)


            self.classement.sort! do |a, b|
                a[1] <=> b[1]
            end

            self.sauvegarder()
        end

        ##
        # Retourne tous les utilisateur du classement
        def utilisateurPresent(unUtilisateur)
            self.classement.each{ |user|
                if user[0] == unUtilisateur.nom
                    return self.classement.index(user)
                end
            }
            return nil
        end

        ##
        # Supprime un utilisteur donné du classement
        def supprimerUtilisateur(unUtilisateur)
            self.classement.delete_at(self.utilisateurPresent(unUtilisateur))
        end

        ##
        # Sauvegarde l'état du classement dans un fichier
        def sauvegarder()
            Dir.chdir("/home/linux/Documents/Nurikabe/Classement")
            fichier = File.open(self.fichier, 'a+')
            Marshal.dump(self,fichier)
            fichier.close
        end

        ##
        # Permet de charger l'état du classement dans un nouvelle objet
        def self.chargerClassement(unFichier)
            fichier = File.open(unFichier, 'r+')
            return Marshal.load(fichier)
        end
    end
end