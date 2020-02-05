require_relative 'Case.rb'
require_relative 'CaseNumero.rb'
require_relative 'CaseJouable.rb'

class GrilleStatique
  attr_reader :taille, :numero, :fichier, :grille
  private_class_method :new

  def GrilleStatique.creer(unNumero, unFichier)
    new(unNumero, unFichier)
  end

  def initialize(unNumero, unFichier)
    @grille = Array.new
    ligneGrille = Array.new

    @numero, @fichier = unNumero, unFichier
    fichierGrille = File.new(fichier, "r")
    ligneFichier = fichierGrille.readlines[@numero-1]
    fichierGrille.close

    grille = ligneFichier.split(';')
    @taille = grille[0].to_i
    ligneGrille.shift

    grille.each{ |l|
      ligne = l.split(//).each { |item|
        if(item.to_i != 0)
          ligneGrille.push(CaseNumero.creer(item,@grille.length,ligneGrille.length))
        else
          ligneGrille.push(CaseJouable.creer(item,@grille.length,ligneGrille.length))
        end
      }
      @grille.push(Array.new(ligneGrille))
      ligneGrille.clear
    }
  end

  def case_plateau(l,c)
      return self.grille[l][c]
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
