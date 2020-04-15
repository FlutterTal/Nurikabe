require 'gtk3'

module Gui

    ##
    # Widget graphique représentant une Case.
    #
    # Classe de base des classes GCaseJouable et GCaseNumero.
    class GCase < Gtk::Button
        
        # @procs => Array de Proc

        ## Taille d'un côté d'une case (Integer)
        TAILLE = 64
        
        ## Case représentée par le widget
        attr_reader :case
        
        private_class_method :new
        
        ##
        # Initialise un widget graphique représentant une case.
        #
        # Paramètre :
        # [+c+] Case
        def initialize(c)
            super()
            @procs = []
            @case = c
            self.width_request = TAILLE
            self.height_request = TAILLE
            self.style_context.add_class("case")
            self.show
        end
        
        ##
        # Met à jour la case (ne change rien par défaut).
        def update
            return self
        end
        
        ##
        # Le bloc donné sera exécuté lorsque la case sera mise à jour.
        #
        # Les blocs n'ont aucun paramètre.
        def on_update(&bloc)
            @procs << bloc
            return self
        end
        
        ##
        # Détermine si la case a une erreur.
        #
        # Paramètres :
        # [+bool+]  Booléen
        def erreur=(bool)
            return self
        end
        
        ##
        # Met la case en surbrillance si +bool+ est à +true+, enlève l'effet
        # sinon.
        def aide=(bool)
            if(bool) then
                self.style_context.add_class("case_indice")
            else
                self.style_context.remove_class("case_indice")
            end
            return self
        end
        
        protected
        
        ##
        # Exécute tous les blocs inscrits.
        def notifier
            @procs.each { |pr| pr.call }
            return self
        end

    end

end
