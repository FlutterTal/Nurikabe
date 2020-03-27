require 'gtk3'

# A tester
def genererGrille()
    nbNiveau = 20

    tableauButton = Array.new(nbNiveau)

    1.upto(nbNiveau) { |i|
        tableauButton[i] = Button.new()
        tableauButton[i].margin = 1
        tableauButton[i].set_size_request(30,30)
    }

end