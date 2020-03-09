class Case
    attr_reader :ligne, :colonne
    attr_reader :aide
    private_class_method :new

    def Case.creer(l, c)
        new(l,c)
    end

    def initialize(l, c)
        @ligne, @colonne = l, c
        @aide = false
    end
end
