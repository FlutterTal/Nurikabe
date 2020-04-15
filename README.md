# Nurikabe
Projet Génie Logiciel 2.

Groupe 1

## Pour travailler sur le dépôt

### Mise en place initiale

1. _À effectuer une seule fois par compte GitHub_ Forker
   https://github.com/anthonyamiard/Nurikabe (Bouton _Fork_ en haut à gauche).
2. _À effectuer une fois par machine_ Cloner votre fork (
   `git clone https://github.com/MON_PSEUDO/Nurikabe.git`, remplacer
   `MON_PSEUDO` par votre nom d'utilisateur).
3. Dans votre dossier de projet, exécuter
   `git remote add upstream https://github.com/anthonyamiard/Nurikabe.git`.

### Récupérer les nouveautés du dépôt global

Dans votre dossier de projet :
1. `git fetch upstream`
2. `git checkout master`
3. `git merge upstream/master`
4. `git push`

### Pour soumettre vos modifications

Après avoir réalisé tous vos commits, tous vos pushs sur votre dépôt local, et
vérifié que votre code est fonctionnel (ne fait pas planter le reste du
projet) :

1. Aller sur https://github.com/anthonyamiard/Nurikabe
2. Cliquer sur _New Pull Request_
3. Cliquer sur _compare accross forks_
4. Décrivez vos modifications et soumettez-les.

### Plus d'informations

* [Fork a repo - GitHub Help](https://help.github.com/en/github/getting-started-with-github/fork-a-repo)
* [Syncing a fork - GitHub Help](https://help.github.com/en/github/collaborating-with-issues-and-pull-requests/syncing-a-fork)

## Les programmes exécutables

* Application : `./Nurikabe.rb`
* Une grille de jeu interactive : `./GUI/DemoGrille.rb`
* Un sélecteur d'utilisateurs (fictifs) : `./GUI/DemoSelecteurUtilisateur.rb`
