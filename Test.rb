require_relative 'Grille/GrilleJouable.rb'
require_relative 'Grille/GrilleStatique.rb'

class Test
  grille = GrilleJouable.creer(1, "test.txt")
  print grille
end
