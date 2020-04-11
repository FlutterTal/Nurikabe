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
            self.maj_etat

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
                self.maj_etat
            }
        end
        
        ##
        # Met à jour l'état du widget selon l'état de la case.
        def maj_etat
            case @case.etatCase
            when :NOIR then marquer_noire
            when :BLANC then marquer_blanche
            when :MARK then marquer_point
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
