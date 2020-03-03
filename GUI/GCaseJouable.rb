require_relative 'GCase.rb'
require_relative '../Grille/CaseJouable.rb'

module Gui

    ##
    # Widget graphique représentant une CaseJouable.
    class GCaseJouable < GCase
        
        ##
        # Crée un widget graphique représentant une CaseJouable.
        #
        # Paramètre :
        # [+c+] CaseJouable
        def GCaseJouable.creer(c)
            gc = new
            gc.case = c
            gc.maj_etat
            
            gc.signal_connect("clicked") do |gc|
                case gc.case.etatCase
                when :BLANC then gc.case.etatCase = :NOIR
                when :NOIR then gc.case.etatCase = :MARK
                when :MARK then gc.case.etatCase = :BLANC
                else raise "État de la case (#{gc.case.ligne}, " +
                        "#{gc.case.colonne}) inconnu : #{gc.case}"
                end
                gc.maj_etat
            end
                
            return gc
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
            # self.label = 'X'
            self.style_context.add_class("case_noire")
        end
        
        # Marque la case comme blanche
        def marquer_blanche
            self.label = ''
            self.style_context.remove_class("case_noire")
        end
        
        # Marque la case comme marquée
        def marquer_point
            self.label = '·'
            self.style_context.remove_class("case_noire")

        end
        
    end
    
end
