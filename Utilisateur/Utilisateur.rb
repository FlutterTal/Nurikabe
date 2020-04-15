module Utilisateur

	  ##
	  # La classe Utilisateur correspond à la gestion des utilisateurs créés
	  class Utilisateur

			##
			# Variables d'instances
			#	@fichier
			#	@nom
			#	@credit
			#	@aventure
			#	@grilleArcade

			private_class_method :new
			attr_reader :nom, :grilleArcade
			attr_accessor :credit, :aventure, :grilleArcadeEnCours
		  
			def Utilisateur.Creer(nom)
			  	new(nom)
			end

			##
    		# L'utilisateur est créé à partir de son nom est un fichier est créé pour lui afin de sauvegarder son avancement et son crédit
			def initialize(nom)
				fichier = File.open("UtilisateurJeu/#{nom}",'a+')

				@nom = nom
				@credit = 0
				@aventure = 0
				@grilleArcade = Array.new()
				@grilleArcadeEnCours = Array.new()

				fichier.close
			end

			##
    		# Retourn vrai si un utilisateur à déjà le nom
			def self.verifNom(nom)
			  	return File.exist?(nom)
			end

			##
    		# Supprime un utilisateur
			def self.supprimerUtilisateur(nom)
			  	File.delete(nom)
			end

			##
    		# Compte le nombre d'utilisateur enrengistrés
			def self.comptesUtilisateurs()
				return Dir.glob("UtilisateurJeu/*[^.rb]").sort.map { |chemin|
					chemin.gsub(/^UtilisateurJeu\//, "")
				}
			end

			##
    		# Permet de sauvegarder dans le fichier de l'utilisateur
			def sauvegarde
				fichier = File.open("UtilisateurJeu/#{self.nom}",'w')

				Marshal.dump(self, fichier)
				fichier.close
			end

			##
    		# Permet de charger l'avancement de l'utilisateur à partir de son fichier
			def self.chargerUtilisateur(unUtilisateur)
				fichier = File.open("UtilisateurJeu/#{unUtilisateur.nom}", 'r')

				return Marshal.load(fichier)
			end

	  end
end
