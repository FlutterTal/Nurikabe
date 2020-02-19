class Utilisateur
  private_class_method :new
  attr_reader :nom ,:credit
 
  def Utilisateur.creer(credit)
    new(credit)
  end

  def initialize(credit)
    puts("Saisir votre pseudo")
    @nom = gets
    @credit = 0
    @fichier = 'BDD_User.txt'
    fichierUtilisateur = File.open('BDD_User.txt','a+')
    fichierUtilisateur.puts("#{@nom}#{@credit}")
    fichierUtilisateur.close
  end

  def supprimerUtilisateur()
    tabUser = File.open('BDD_User.txt', 'r').readlines
    fichierUtilisateur = File.open('BDD_User.txt','w')
    i = 0
    while i<= tabUser.size
      if("#{@nom}"==tabUser[i])
        i=i+2
      end
      fichierUtilisateur.puts(tabUser[i],tabUser[i+1])
      i = i+2
    end
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
      while i<= tabUser.size
        if(nom==tabUser[i])
          return 1
        end
        i = i+2
      end
    end
    fichierUtilisateur.close
    return 0
  end

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
