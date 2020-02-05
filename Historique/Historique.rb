require_relative 'HistoriqueElement.rb'

class Historique
	
	def initialize
		@historique  = Array.new
		@index = -1
	end

	def sauvegarder(case, etat_avant, etat_apres)
		@historique.add(HistoriqueElement.Creer(case, etat_avant, etat_apres))
		@index += 1
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