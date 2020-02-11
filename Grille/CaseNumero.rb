require_relative 'Case.rb'

class CaseNumero < Case
    attr_reader :numero
    private_class_method :new
    
    def CaseNumero.creer(num,l, c)
        new(num,l, c)
    end

    def initialize(num, l, c)
        super(l, c)
        @numero = num
    end

    def to_s()
        return self.numero
    end
end
