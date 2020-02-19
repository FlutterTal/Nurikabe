require_relative 'Grille/GrilleJouable.rb'
require_relative 'Grille/GrilleStatique.rb'
require_relative 'Aide/Aide.rb'

class Test
  grille = GrilleJouable.creer(1, "test.txt")
  print grille
  #Aide.detecter(grille)
end
