require_relative 'Case.rb'

class CaseJouable < Case
    attr_accessor :etatCase
    private_class_method :new
    
    @@etatPossible = {:NOIR => 'N', :BLANC => 'B', :MARK => 'M'}

    module Etat
        NOIR = 'N'
        BLANC = 'B'
        MARK = 'M'
    end

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
end
