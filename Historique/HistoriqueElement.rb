require_relative '../Erreur/Erreur.rb'

class HistoriqueElement
    attr_reader :case, :etat_avant, :etat_apres, :erreur
    private_class_method :new

    def HistoriqueElement.Creer(case, etat_avant, etat_apres)
        new(case, etat_avant, etat_apres)
    end

    def initialize(case, etat_avant, etat_apres)
        @case = case
        @etat_avant = etat_avant
        @etat_apres = etat_apres
        @erreur = Erreur.verif_case(case)
    end

end