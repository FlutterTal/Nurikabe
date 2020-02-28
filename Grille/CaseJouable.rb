require_relative 'Case.rb'

=begin
require_relative '../Historique/Historique.rb' 
=end

class CaseJouable < Case
    attr_accessor :etatCase
    private_class_method :new
    
    @@etatPossible = {:NOIR => 'N', :BLANC => 'B', :MARK => 'M'}

    def CaseJouable.creer(etat, l, c)
        new(etat, l, c)
    end

    def initialize(etat,l,c)
        super(l,c)
        @etatCase = @@etatPossible.key(etat)
    end

    def to_s
        return @@etatPossible[self.etatCase]
    end

    def restorCase()
        self.etatCase = @@etatPossible.key('B')
    end

    '''
    def changementEtat(unEtat, historique)
        etatAvant = self.etatCase
        historique.sauvegarder(self, etatAvant, unEtat)
        self.etatCase = unEtat

        return self
    end
    '''
end
