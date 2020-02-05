require_relative 'GrilleStatique.rb'

class GrilleJouable < GrilleStatique
  private_class_method :new

  def GrilleJouable.creer(unNumero, unFichier)
    new(unNumero, unFichier)
  end

  def initialize(unNumero, unFichier)
    @solution = GrilleStatique.creer(unNumero, unFichier)
    super(unNumero, unFichier)

    @grille.each { |ligne|
      ligne.each{ |cases|
        if cases.class != CaseNumero
          cases.type = "V"
        end
      }
    }
  end

  def to_s()
    str = ""
    @grille.each { |ligne|
      ligne.each{ |cases| str += cases.type}
      str += "\n"
    }
    return str + "\n"
  end
end
