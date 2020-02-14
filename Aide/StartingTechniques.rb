class StartingTechniques

=begin
Island of 1
Since this is an island with a single square we can surround it with walls
by shading the horizontally and vertically adjacent squares.
=end
    def StartingTechniques.case1(grille)
      grille.grille().grille().each { |ligne|
          ligne.each { |cases|
            if((cases.class() == CaseNumero) && (cases.numero().to_i() == 1))
              puts "Contient 1"
            end
          }
      }
    end

=begin
Clues separated by one square
According to Nurikabe rules, all clues must be partitioned from each other with walls.
Therefore when two clues are in the same row or column and separated by one square, the square in between must be a wall.
=end
    def StartingTechniques.caseVide(grille)
      taille_colonne = grille.solution().taille_colonne()
      taille_ligne = grille.solution().taille_ligne()
      tabJeu = grille.grille().grille() # Array

      # Analyse horizontale
      tabJeu.each { |tab|
          for i in (0..(taille_ligne - 3))
            if (tab[i].class == CaseNumero) && (tab[i+1].class == CaseJouable) && (tab[i+2].class == CaseNumero)
              puts "Case vide horizontale"
            end
          end
      }

      # Analyse verticale
      for i in (0..taille_ligne) # Parcours colonne
        for j in (0..(taille_colonne - 3)) # Parcours ligne
          if (tabJeu[j][i].class == CaseNumero) && (tabJeu[j+1][i].class == CaseJouable) && (tabJeu[j+2][i].class == CaseNumero)
            puts "Case vide verticale"
          end
        end
      end

    end

=begin
Diagonally adjacent clues
Similar to the example above, when two clues are diagonally adjacent
then each of the squares touching both clues must be part of a wall.
=end
    def StartingTechniques.caseDiag(grille)
      taille_colonne = grille.solution().taille_colonne()
      taille_ligne = grille.solution().taille_ligne()
      tabJeu = grille.grille().grille() # Array

      for i in (0..(taille_colonne - 2)) # Parcours ligne
        for j in (0..(taille_ligne - 2)) # Parcours colonne
          if (tabJeu[i][j].class == CaseNumero) && (tabJeu[i+1][j+1].class == CaseNumero) && (tabJeu[i+1][j].class == CaseJouable) && (tabJeu[i][j+1].class == CaseJouable)
            puts "Case diagonale \\"
          end
          if (tabJeu[i][j].class == CaseJouable) && (tabJeu[i+1][j+1].class == CaseJouable) && (tabJeu[i+1][j].class == CaseNumero) && (tabJeu[i][j+1].class == CaseNumero)
            puts "Case diagonale /"
          end
        end
      end

    end

  end
