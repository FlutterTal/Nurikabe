require_relative 'HistoriqueElement.rb'

module Historique
	##
	# Un historique de partie
	#
	# Il contient une liste de HistoriqueElement
	class Historique
		private_class_method :new

		##
		# Ouvre un historique pour un utilisateur et une grille
		def Historique.Ouvrir(utilisateur, grille)
			new(utilisateur, grille)
		end

		##
		# Crée le fichier correspondant à l'historique de la partie ou ouvre celui déjà existant
		def initialize(utilisateur, grille)
			@fichier = File.new("Hist_#{utilisateur.nom}_#{grille.solution.numero}", "r+")
			if @fichier.empty? 
				@historique = Array.new
			else do
				@historique = Marshal.load(@fichier)
			end
			@index = 0
		end

		##
		# Ajoute un nouvel élément à l'historique
		#
		# Met à jour l'objet ET le fichier de sauvegarde
		def sauvegarder(cases, etat_avant, etat_apres)
			unless fin?
				@historique.slice!(@index+1..@historique.size)
			end
			# peut-être besoin de parenthèses
			suivant = HistoriqueElement.Creer(cases, etat_avant, etat_apres)
			#@fichier.truncate(0)
			Marshal.dump(@historique, @fichier)
			@fichier.fdatasync
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
			until fin?
				yield suivant
			end
			return self
		end
	end
end