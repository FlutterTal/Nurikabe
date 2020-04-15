require_relative 'GCase.rb'
require_relative '../Grille/CaseJouable.rb'

module Gui

    ##
    # Widget graphique représentant une CaseJouable.
    class GCaseJouable < GCase
    
        public_class_method :new
        
        ##
        # Crée un widget graphique représentant une CaseJouable.
        #
        # Paramètre :
        # [+c+] CaseJouable
        # [+historique+]    Historique
        def initialize(c, historique)
            super(c)
            self.update

            self.signal_connect("clicked") {
                case @case.etatCase
                when :BLANC then
                    if(historique) then
                        @case.changementEtat(:NOIR, historique)
                    else
                        @case.etatCase = :NOIR
                    end
                when :NOIR then
                    if(historique) then
                        @case.changementEtat(:MARK, historique)
                    else
                        @case.etatCase = :MARK
                    end
                when :MARK then
                    if(historique) then
                        @case.changementEtat(:BLANC, historique)
                    else
                        @case.etatCase = :BLANC
                    end
                else raise "État de la case (#{@case.ligne}, " +
                        "#{@case.colonne}) inconnu : #{@case}"
                end
                self.update
            }
        end
        
        ##
        # Met à jour l'état du widget selon l'état de la case.
        def update
            case @case.etatCase
            when :NOIR then marquer_noire
            when :BLANC then marquer_blanche
            when :MARK then marquer_point
            end
            self.style_context.remove_class("case_erreur")
            notifier()
            return self
        end
        
        ##
        # Détermine s'il faut afficher les erreurs, ou non.
        #
        # Paramètres :
        # [+bool+]  Booléen
        def afficher_erreurs=(bool)
            super(bool)
            self.update()
            return self
        end
        
        ##
        # Détermine si la case a une erreur.
        #
        # Paramètres :
        # [+bool+]  Booléen
        def erreur=(bool)
            if(bool) then
                self.style_context.add_class("case_erreur")
            else
                self.style_context.remove_class("case_erreur")
            end
            return self
        end
        
        private
        
        # Marque la case comme noire
        def marquer_noire
            self.label = ''
            self.style_context.add_class("case_noire")
            self.style_context.remove_class("case_marquee")
        end
        
        # Marque la case comme blanche
        def marquer_blanche
            self.label = ''
            self.style_context.remove_class("case_noire")
            self.style_context.remove_class("case_marquee")
        end
        
        # Marque la case comme marquée
        def marquer_point
            self.label = '▪'
            self.style_context.remove_class("case_noire")
            self.style_context.add_class("case_marquee")

        end
        
    end
    
end
