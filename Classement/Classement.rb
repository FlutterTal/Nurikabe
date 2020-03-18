require_relative '../Grille/GrilleJouable.rb'
require_relative '../Utilisateur/Utilisateur.rb'

class Classement
    attr_reader :fichier
    attr_accessor :classement

    def Classement.Creer(uneGrille)
        new(uneGrille)
    end

    def initialize(uneGrille)
        Dir.chdir("/home/linux/Documents/Nurikabe/Classement")
        fichier = File.open("Classement_Grille_#{uneGrille.numero}", 'a+')
        fichier.close

        @fichier = "Classement_Grille_#{uneGrille.numero}"
        @classement = Array.new()
    end

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

    def utilisateurPresent(unUtilisateur)
        self.classement.each{ |user|
            if user[0] == unUtilisateur.nom
                return self.classement.index(user)
            end      
        }
        return nil
    end

    def supprimerUtilisateur(unUtilisateur)
        self.classement.delete_at(self.utilisateurPresent(unUtilisateur))
    end

    def sauvegarder()
        Dir.chdir("/home/linux/Documents/Nurikabe/Classement")
        fichier = File.open(self.fichier, 'a+')
        Marshal.dump(self,fichier)
        fichier.close
    end

    def self.chargerClassement(unFichier)
        fichier = File.open(unFichier, 'r+')
        return Marshal.load(fichier)
    end

    def afficher()
        self.to_s
    end

    def to_s
        return self.classement
    end
end