class Case
  attr_reader :ligne, :colonne, :type
  attr_writer :type
  private_class_method :new

  def Case.creer(type, l, c)
	new(type, l,c)
  end

  def initialize(type, l, c)
	  @type, @ligne, @colonne = type, l, c
  end
end
