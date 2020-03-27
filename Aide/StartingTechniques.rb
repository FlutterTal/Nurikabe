##
# Techniques d'aides de démarrage
#

class StartingTechniques

##
# Technique sur les cases "1"
#
# Island of 1
# Since this is an island with a single square we can surround it with walls
# by shading the horizontally and vertically adjacent squares.
#
# Paramètres :
# [+grille+] Case courante sur laquelle est associé une aide
# [+tab+] Tableau contenant les aides (pour la grille du joueur courant)
    def StartingTechniques.case1(grille, tab)
      tabJeu = grille.grille().grille() # Array

      tabJeu.each { |ligne|
          ligne.each { |cases|
            if((cases.class() == CaseNumero) && (cases.numero().to_i() == 1))
              tab.push(Aide.creer(cases, "Contient 1"))
            end
          }
      }
    end

##
# Technique sur les cases vides séparant 2 autres cases numéros
#
# Clues separated by one square
# According to Nurikabe rules, all clues must be partitioned from each other with walls.
# Therefore when two clues are in the same row or column and separated by one square, the square in between must be a wall.
#
# Paramètres :
# [+grille+] Case courante sur laquelle est associé une aide
# [+tab+] Tableau contenant les aides (pour la grille du joueur courant)
    def StartingTechniques.caseVide(grille, tab)
      taille_colonne = grille.solution().taille_colonne()
      taille_ligne = grille.solution().taille_ligne()
      tabJeu = grille.grille().grille() # Array

      # Analyse horizontale
      tabJeu.each { |tab|
          for i in (0..(taille_ligne - 3))
            if (tab[i].class == CaseNumero) && (tab[i+1].class == CaseJouable) && (tab[i+2].class == CaseNumero)
              tab.push(Aide.creer(tabJeu[i][j], "Case vide horizontale"))
            end
          end
      }

      # Analyse verticale
      for i in (0..taille_ligne) # Parcours colonne
        for j in (0..(taille_colonne - 3)) # Parcours ligne
          if (tabJeu[j][i].class == CaseNumero) && (tabJeu[j+1][i].class == CaseJouable) && (tabJeu[j+2][i].class == CaseNumero)
            tab.push(Aide.creer(tabJeu[i][j], "Case vide verticale"))
          end
        end
      end

    end

##
# Technique sur les cases diagonales
#
# Diagonally adjacent clues
# Similar to the example above, when two clues are diagonally adjacent
# then each of the squares touching both clues must be part of a wall.
#
# Paramètres :
# [+grille+] Case courante sur laquelle est associé une aide
# [+tab+] Tableau contenant les aides (pour la grille du joueur courant)
    def StartingTechniques.caseDiag(grille, tab)
      taille_colonne = grille.solution().taille_colonne()
      taille_ligne = grille.solution().taille_ligne()
      tabJeu = grille.grille().grille() # Array

      for i in (0..(taille_colonne - 2)) # Parcours ligne
        for j in (0..(taille_ligne - 2)) # Parcours colonne
          if (tabJeu[i][j].class == CaseNumero) && (tabJeu[i+1][j+1].class == CaseNumero) && (tabJeu[i+1][j].class == CaseJouable) && (tabJeu[i][j+1].class == CaseJouable)
            tab.push(Aide.creer(tabJeu[i][j], "Case diagonale \\"))
          end
          if (tabJeu[i][j].class == CaseJouable) && (tabJeu[i+1][j+1].class == CaseJouable) && (tabJeu[i+1][j].class == CaseNumero) && (tabJeu[i][j+1].class == CaseNumero)
            tab.push(Aide.creer(tabJeu[i][j], "Case diagonale /"))
          end
        end
      end

    end

  end
