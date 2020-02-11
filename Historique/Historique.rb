require_relative 'HistoriqueElement.rb'

class Historique
	private_class_method :new

	def Ouvrir(utilisateur, grille)
		new(utilisateur, grille)
	end

	def initialize(utilisateur, grille)
		@fichier = File.new("Hist_#{utilisateur}_#{grille}")
		if @fichier.empty? do
			@historique = Array.new
		else
			@historique = Marshal.load(@fichier)
		end
		@index = -1
	end

	def sauvegarder(case, etat_avant, etat_apres)
		@index += 1
		unless fin? do
			@historique.slice!(@index..)
		end
		@historique[@index] = HistoriqueElement.Creer(case, etat_avant, etat_apres)
		Marshal.dump(@historique, @fichier)
		@fichier.fdatasync
		return self
	end

	def precedent
		@index -= 1
		return @historique[@index]
	end

	def suivant
		@index += 1
		return @historique[@index]
	end

	def fin?
		return @index == @historique.size
	end
end