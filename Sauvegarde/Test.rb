require_relative '../Grille/GrilleStatique.rb'
require_relative '../Utilisateur/Utilisateur.rb'
require_relative './Historique.rb'
require_relative './Sauvegarde.rb'
require_relative './HistoriqueElement.rb'


g = GrilleJouable.creer(1)
u = Utilisateur.creer()
Hist = Sauvegarde::Historique.Ouvrir(u, g)
Hist.sauvegarder(g.solution.case_plateau(1, 2), 'B','N')
Hist.sauvegarder(g.solution.case_plateau(1, 3), 'B','M')
Hist.precedent
Hist.sauvegarder(g.solution.case_plateau(2, 2), 'B','M')
Hist.sauvegarder(g.solution.case_plateau(2, 2), 'M','B')

print Hist.to_s
Hist2 = Sauvegarde::Historique.Ouvrir(u, g)
print Hist2.to_s