module Utilisateur

  class Utilisateur
    private_class_method :new
    attr_reader :nom, :grilleAventure, :grilleArcade
    attr_accessor :credit
  
    def Utilisateur.Creer(nom)
      new(nom)
    end

    def initialize(nom)
      Dir.chdir("/home/linux/Documents/Nurikabe/Utilisateur")
      fichier = File.open("#{nom}",'a+')

      @nom = nom
      @credit = 0
      @aventure = nil
      @grilleArcade = Array.new()

      fichier.close
    end

    def self.verifNom(nom)
      return File.exist?(nom)
    end

    def self.supprimerUtilisateur(nom)
      File.delete(nom)
    end

    def self.comptesUtilisateurs()
      Dir.chdir("/home/linux/Documents/Nurikabe/Utilisateur")
      return Dir.glob("*[^.rb]").sort
    end

    def sauvegarde
      Dir.chdir("/home/linux/Documents/Nurikabe/Utilisateur")
      fichier = File.open("#{self.nom}",'w')

      Marshal.dump(self, fichier)
      fichier.close
    end

    def self.chargerUtilisateur(unUtilisateur)
      Dir.chdir("/home/linux/Documents/Nurikabe/Utilisateur")
      fichier = File.open("#{unUtilisateur.nom}", 'r')

      return Marshal.load(fichier)
    end

  # WAIT CLASSEMENT
    def tempsMoyen()
      @niveauTermine = 0
      for n in (0..Grille.lenght)
        if(@nom == Grille.utilisateur)
          tempsMoyen += Grille.temps
          @niveauTermine += 1
        end
      end
      return @tempsMoyen/@niveauTermine
    end

    def to_s()
      "Pseudo : #{self.nom}Crédit :#{self.credit}\n"
    end

  end
end