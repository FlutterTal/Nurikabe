require 'gtk3'

win = Gtk::Window.new
hbox = Gtk::Box.new(:horizontal, 3)

btn_retour = Gtk::Button.new(:label => "Retour")
btn_annuler = Gtk::Button.new(:label => "Annuler")
btn_retablir = Gtk::Button.new(:label => "Rétablir")
btn_aide = Gtk::Button.new(:label => "Aide")
btn_valider = Gtk::Button.new(:label => "Valider")
btn_menu = Gtk::Button.new(:label => "Menu")

win.add(hbox)

# Position des boutons
hbox.pack_start(btn_retour, :expand => true, :fill => false, :padding =>2)
hbox.pack_start(btn_annuler, :expand => true, :fill => false, :padding =>2)
hbox.pack_start(btn_retablir, :expand => true, :fill => false, :padding =>2)
hbox.pack_start(btn_aide, :expand => true, :fill => false, :padding =>2)
hbox.pack_start(btn_valider, :expand => true, :fill => false, :padding =>2)
hbox.pack_start(btn_menu, :expand => true, :fill => false, :padding =>2)

# Ecouter bouton
#btn_XXXX.signal_connect("clicked") {puts "Retour"}

win.signal_connect("destroy"){Gtk.main_quit}
win.show_all

Gtk.main