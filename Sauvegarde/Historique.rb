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
		def Historique.Ouvrir(utilisateur, grille)
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
			@historique[@index] = HistoriqueElement.Creer(@grille, case_jeu, etat_avant, etat_apres)
			@index += 1
			@fichier.pwrite(Marshal.dump(@historique),0)
			return self
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
			yield @historique[@index] if block_given?
			return @historique[@index]
		end

		##
		# Vrai si l'élément courant est le dernier de l'historique
		def fin?
			return @index == @historique.size
		end

		##
		# Execute le bloc de l'élément actuel à la fin
		#
		# Donne en paramètre de bloc des HistoriqueElement
		def replay
			@index -= 1
			until fin?
				yield suivant
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