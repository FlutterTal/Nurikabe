class Case
    attr_reader :ligne, :colonne
    private_class_method :new

    def Case.creer(l, c)
        new(l,c)
    end

    def initialize(l, c)
        @ligne, @colonne = l, c
    end
end
