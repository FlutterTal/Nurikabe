require_relative 'GrilleJouable.rb'
require_relative 'GrilleStatique.rb'

class Test
  grille = GrilleStatique.creer(1, "../test.txt")
  print grille
end
