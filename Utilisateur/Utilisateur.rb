class Utilisateur
  attr_reader :nom, :credit, :progression, :niveau, :niveauTermine ,:temps, :fichier
  private_class_method :new

  def Utilisateur.creer()
    new(nom,credit,fichier)
  end


  def initialize(nom,credit,fichier)
    puts("Saisir votre pseudo")
    @nom = gets
    @credit = 0
    @fichier = 'BDD_User.txt'

    fichierUtilisateur = File.new(fichier,'w+')
    fichierUtilisateur.write(@nom+";"+@credit)
    fichierUtilisateur.close
  end

  def supprimer()

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

  def to_s()
    "Pseudo : #{self.nom}Crédit :#{self.credit}\n"
  end

end
