=begin
Surrounded square
Since these squares are surrounded by walls horizontally and vertically they cannot belong to an island and must therefore be shaded to be part of a wall
=end
  def BasicTechniques.caseVideEntoure(grille)
    taille_colonne = grille.solution().taille_colonne()
    taille_ligne = grille.solution().taille_ligne()
    tabJeu = grille.grille().grille() # Array

    # Analyse ascendante droite
    (1..(taille_colonne - 1)).reverse_each { |i| # Parcours ligne
      (0..(taille_ligne - 2)).each { |j| # Parcours colonne
        if (tabJeu[i][j].class == CaseJouable) && (tabJeu[i-1][j].class == CaseJouable) && (tabJeu[i][j+1].class == CaseJouable)
          if (tabJeu[i][j].etatCase() == :BLANC) && (tabJeu[i-1][j].etatCase() == :NOIR) && (tabJeu[i][j+1].etatCase() == :NOIR)
            puts "Surrounded square (AD)"
          end
        end
      }
    }

    # Analyse ascendante gauche
    (1..(taille_colonne - 1)).reverse_each { |i| # Parcours ligne
      (1..(taille_ligne - 1)).reverse_each { |j| # Parcours colonne
        if (tabJeu[i][j].class == CaseJouable) && (tabJeu[i-1][j].class == CaseJouable) && (tabJeu[i][j-1].class == CaseJouable)
          if (tabJeu[i][j].etatCase() == :BLANC) && (tabJeu[i-1][j].etatCase() == :NOIR) && (tabJeu[i][j-1].etatCase() == :NOIR)
            puts "Surrounded square (AG)"
          end
        end
      }
    }

    # Analyse descendante droite
    (0..(taille_colonne - 2)).each { |i| # Parcours ligne
      (0..(taille_ligne - 2)).each { |j| # Parcours colonne
        if (tabJeu[i][j].class == CaseJouable) && (tabJeu[i+1][j].class == CaseJouable) && (tabJeu[i][j+1].class == CaseJouable)
          if (tabJeu[i][j].etatCase() == :BLANC) && (tabJeu[i+1][j].etatCase() == :NOIR) && (tabJeu[i][j+1].etatCase() == :NOIR)
            puts "Surrounded square (DD)"
          end
        end
      }
    }

    # Analyse descendante gauche
    (0..(taille_colonne - 2)).each { |i| # Parcours ligne
      (1..(taille_ligne - 1)).reverse_each { |j| # Parcours colonne
        if (tabJeu[i][j].class == CaseJouable) && (tabJeu[i+1][j].class == CaseJouable) && (tabJeu[i][j-1].class == CaseJouable)
          if (tabJeu[i][j].etatCase() == :BLANC) && (tabJeu[i+1][j].etatCase() == :NOIR) && (tabJeu[i][j-1].etatCase() == :NOIR)
            puts "Surrounded square (DG)"
          end
        end
      }
    }

  end
