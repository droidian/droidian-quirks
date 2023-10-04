#!/bin/sh

# some gnome apps depend on these
export XDG_CURRENT_DESKTOP=Phosh:GNOME
export XDG_SESSION_DESKTOP=phosh
export XDG_MENU_PREFIX="gnome-"

# make qt apps more gnome/gtk like
export QT_QPA_PLATFORMTHEME='gnome'
export QT_STYLE_OVERRIDE=adwaita
