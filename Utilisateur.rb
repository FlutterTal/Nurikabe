class Utilisateur
  private_class_method :new
  attr_reader :nom ,:credit
 
  def Utilisateur.creer()
    new()
  end

  def initialize()
    loop{
    puts("Saisir votre nom")
    @nom = gets
    @credit = 0
    break if(!verifNom(@nom))
    puts("Nom déjà pris")
    }
    fichierUtilisateur = File.open(@nom,'w')
    fichierUtilisateur.puts("#{@nom}#{@credit}")
    fichierUtilisateur.close
  end

  def verifNom(nom)
    return File.exist?(nom)
  end

  def supprimerUtilisateur()
    File.delete(@nom)
  end

  def modifCredit(nom,montant)
    donnees = ''
    fichierUtilisateur = File.open(nom, 'r')
    fichierUtilisateur.each {|ligne|
    if fichierUtilisateur.lineno == 2
        ligne = ligne + montant.to_s
    end
 
    donnees += ligne
    }
 
    fichierUtilisateur.close
 
    fichierUtilisateur = File.open(nom, 'w+')
    fichierUtilisateur.write(donnees)
    fichierUtilisateur.close
  end

  #Permet de charger le nom d'un utilisateur ayant déjà été créé
  def charger(nom)
    tabUser = File.open('BDD_User.txt', 'r').readlines
    fichierUtilisateur = File.open("BDD_User.txt", "r")
    i = 0
    if (tabUser.size==0)
      return -1
    else
      while (i<= tabUser.size)
        if(nom==tabUser[i])
          return 1
        end
        i = i+2
      end
    end
    fichierUtilisateur.close
    return 0
  end

# WAIT CLASSEMENT
  def tempsMoyen()
    @niveauTermine = 0
    for n in (0..Grille.lenght)
      if(@nom == Grille.utilisateur)
        tempsMoyen += Grille.temps
        @niveauTermine += 1
      end
    end
    return @tempsMoyen/@niveauTermine
  end

  def nombreGrilles()

  end

  def to_s()
    "Pseudo : #{self.nom}Crédit :#{self.credit}\n"
  end

end
