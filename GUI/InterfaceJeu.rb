require 'gtk3'
require_relative 'GGrille.rb'
require_relative 'BoutonRetour.rb'
require_relative '../Aide/Aide.rb'

module Gui
    
    ##
    # Interface de jeu contenant une GGrille.
    class InterfaceJeu < Gtk::Box
    
        ##
        # Message affiché quand le joueur manque de crédit.
        class MessageCredit < Gtk::InfoBar
            
            ##
            # Crée un message alertant le joueur qu'il manque de crédit.
            #
            # Paramètres :
            # [+parent+]    Parent
            def initialize(parent)
                super()
                self.content_area.add(Gtk::Label.new.tap { |label|
                    label.markup = "<b>Pas assez de crédit</b>"
                    label.show
                })
                self.show_close_button = true
                self.signal_connect("response") { parent.remove(self) }
                self.message_type = Gtk::MessageType::ERROR
                self.show
            end
            
        end
    
        # @infobar  => Barre d'info actuelle
        
        ## Barre de titre associée à l'interface de jeu.
        attr_reader :titlebar
        
        ## Historique de la grille
        attr_reader :historique
        
        ## Coût d'une vérification
        CREDIT_VERIF = 2
        
        ## Coût d'une aide
        CREDIT_AIDE = 4
        
        ## Gain d'une victoire
        CREDIT_VICTOIRE = 10
        
        ##
        # Crée une interface de jeu pour la grille donnée.
        #
        # Paramètres :
        # [+app+]       Nurikabe
        # [+grille+]    GrilleJouable
        def initialize(app, grille)
            super(:vertical)
            @grille = grille
            @app = app
            
            gg = GGrille.new(grille, app.utilisateur)
            gg.valign = Gtk::Align::CENTER
            gg.halign = Gtk::Align::CENTER
            self.pack_end(gg)
            @historique = gg.historique
            
            @titlebar = Gtk::HeaderBar.new.tap { |barre|
                barre.title = "Nurikabe"
                barre.show_close_button = true
                barre.pack_start(BoutonRetour.new.tap { |bouton|
                    bouton.signal_connect("clicked") {
                        case grille.solution.mode
                        when "Aventure" then app.aventure
                        when "Arcade" then app.aventure
                        else app.accueil
                        end
                    }
                })
                annuler = Gtk::Button.new(icon_name: 'edit-undo-symbolic')
                refaire = Gtk::Button.new(icon_name: 'edit-redo-symbolic')
                barre.pack_start(annuler.tap { |annuler|
                    annuler.signal_connect("clicked") {
                        @historique.precedent { |element|
                            grille.grille.grille[element.case_jeu.ligne
                                ][element.case_jeu.colonne].etatCase =
                                element.etat_avant
                        }
                        gg.update
                    }
                    annuler.sensitive = !@historique.debut?
                    annuler.show
                })
                barre.pack_start(refaire.tap { |refaire|
                    refaire.signal_connect("clicked") {
                        @historique.suivant { |element|
                            grille.grille.grille[element.case_jeu.ligne
                                ][element.case_jeu.colonne].etatCase =
                                element.etat_apres
                        }
                        gg.update
                    }
                    refaire.sensitive = !@historique.fin?
                    refaire.show
                })
                barre.pack_end(Gtk::MenuButton.new.tap { |bouton|
                    bouton.image = Gtk::Image.new(
                        icon_name: 'open-menu-symbolic')
                    bouton.show
                })
                verifier = Gtk::Button.new(icon_name: 'checkmark')
                barre.pack_end(verifier.tap { |verifier|
                    verifier.signal_connect("clicked") {
                        if(app.utilisateur.credit < CREDIT_VERIF) then
                            infobar(MessageCredit.new(self))
                        else
                            infobar(Gtk::InfoBar.new.tap { |info|
                                info.content_area.add(
                                    Gtk::Label.new.tap { |label|
                                    if(grille.erreur == 0) then
                                        label.markup = "<b>Aucune erreur</b>"
                                    else
                                        label.markup = "<b>#{grille.erreur} " +
                                            "erreur" +
                                            (grille.erreur > 1 ? 's' : '') +
                                            "</b>"
                                    end
                                    label.show
                                })
                                if(grille.erreur == 1) then
                                    info.add_button("Afficher la case", 1)
                                elsif(grille.erreur > 1) then
                                    info.add_button("Afficher les cases", 1)
                                end
                                info.show_close_button = true
                                info.signal_connect("response") { |info, rep|
                                    if(rep == 1) then
                                        if(app.utilisateur.credit <
                                            CREDIT_VERIF) then
                                            infobar(MessageCredit.new(self))
                                        else
                                            gg.erreurs = grille.locErreur
                                            app.utilisateur.credit -=
                                                CREDIT_VERIF
                                            update_titlebar()
                                        end
                                    end
                                    @infobar = nil
                                    self.remove(info)
                                }
                                info.show
                            })
                            app.utilisateur.credit -= CREDIT_VERIF
                            update_titlebar()
                        end
                    }
                    verifier.show
                })
                aide_btn = Gtk::Button.new(label: "Aide",
                                           icon_name: 'help-contextual')
                barre.pack_end(aide_btn.tap { |aide_btn|
                    aide_btn.always_show_image = true
                    aide_btn.signal_connect("clicked") { |aide_btn|
                            aide_btn.sensitive = false
                            aide_tab = []
                            Aide.detecter(grille, aide_tab)
                        if(aide_tab.length == 0) then
                            infobar(Gtk::InfoBar.new.tap { |info|
                                info.content_area.add(
                                    Gtk::Label.new.tap { |label|
                                    label.markup = "<b>Aucune situation " +
                                        "détectée</b>"
                                    label.show
                                })
                                info.show_close_button = true
                                info.signal_connect("response") {
                                    @infobar = nil
                                    self.remove(info)
                                    aide_btn.sensitive = true
                                }
                                info.show
                            })
                        else
                            if(app.utilisateur.credit < CREDIT_AIDE) then
                                infobar(MessageCredit.new(self))
                                aide_btn.sensitive = true
                            else
                                aide = aide_tab[rand(aide_tab.length)]
                                gg.aide(aide.caseC.ligne, aide.caseC.colonne)
                                infobar(Gtk::InfoBar.new.tap { |info|
                                    label = Gtk::Label.new
                                    info.content_area.add(label.tap { |label|
                                        label.markup = "<b>Une aide " +
                                            "disponnible</b>"
                                        label.show
                                    })
                                    info.show_close_button = true
                                    info.add_button("Détails", 1)
                                    info.signal_connect("response") {|info, rep|
                                        case rep
                                        when 1 then
                                            if(app.utilisateur.credit <
                                                CREDIT_AIDE) then
                                                infobar(MessageCredit.new(self))
                                                gg.aide(-1, -1)
                                            else
                                                label.markup = "<b>Une aide " +
                                                    "disponnible</b>\n" +
                                                    aide.chaine
                                                app.utilisateur.credit -=
                                                    CREDIT_AIDE
                                                update_titlebar()
                                            end
                                        when Gtk::ResponseType::CLOSE then
                                            @infobar = nil
                                            self.remove(info)
                                            gg.aide(-1, -1)
                                            aide_btn.sensitive = true
                                        end
                                    }
                                    info.show
                                })
                                app.utilisateur.credit -= CREDIT_AIDE
                                update_titlebar()
                            end
                        end
                    }
                    aide_btn.show
                })
                
                boite_terminee_affichee = false
                
                gg.on_update {
                    grille.verifErreur
                    if(grille.grilleTerminee?) then
                        gg.desactiver
                        annuler.sensitive = false
                        refaire.sensitive = false
                        aide_btn.sensitive = false
                        verifier.sensitive = false
                        unless(boite_terminee_affichee) then
                            Gtk::MessageDialog.new(
                                title: "Gagné",
                                parent: app.fenetre,
                                flags: Gtk::DialogFlags::USE_HEADER_BAR |
                                Gtk::DialogFlags::MODAL |
                                Gtk::DialogFlags::DESTROY_WITH_PARENT,
                                message: "Vous avez terminé la grille"
                            ).tap { |boite|
                                boite.signal_connect("response") {
                                    boite.close
                                }
                                boite.show
                            }
                            boite_terminee_affichee = true
                        end
                    else
                        annuler.sensitive = !@historique.debut?
                        refaire.sensitive = !@historique.fin?
                    end
                }
                
                
                barre.show
            }
            update_titlebar()
            
            @historique.replay { |element|
                grille.grille.grille[element.case_jeu.ligne
                    ][element.case_jeu.colonne].etatCase = element.etat_apres
            }
            gg.update
            
            self.show
        end
        
        private
        
        # Change la barre d'info
        def infobar(barre)
            if(@infobar) then
                @infobar.signal_emit("response", Gtk::ResponseType::CLOSE)
            end
            @infobar = barre
            self.pack_start(barre)
        end
        
        # Met à jour la barre de titre
        def update_titlebar
            @titlebar.subtitle = "Niveau #{@grille.solution.numero} · " +
                "Crédit : #{@app.utilisateur.credit}"
            return self
        end
        
    end
    
end
