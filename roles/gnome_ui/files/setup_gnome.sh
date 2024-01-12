#!/bin/bash

# TODO: Light terminal background
# TODO: OS power setting from balanced to performance
# TODO: Remove personal icons from desktop
# TODO: Turn off Bluetooth
# TODO: Turn on night light mode

# Terminal
TERM_PROFILE_ID="b1dcc9dd-5262-4d8d-a863-c897e6d979b9"
dconf write /org/gnome/terminal/legacy/profiles:/:$TERM_PROFILE_ID/use-theme-colors "false"
dconf write /org/gnome/terminal/legacy/profiles:/:$TERM_PROFILE_ID/use-theme-transparency "false"
dconf write /org/gnome/terminal/legacy/profiles:/:$TERM_PROFILE_ID/use-transparent-background "true"
dconf write /org/gnome/terminal/legacy/profiles:/:$TERM_PROFILE_ID/background-transparency-percent "6"
dconf write /org/gnome/terminal/legacy/profiles:/:$TERM_PROFILE_ID/cell-height-scale "1.23"
dconf write /org/gnome/terminal/legacy/profiles:/:$TERM_PROFILE_ID/default-size-columns "100"
dconf write /org/gnome/terminal/legacy/profiles:/:$TERM_PROFILE_ID/default-size-rows "30"
dconf write /org/gnome/terminal/legacy/profiles:/:$TERM_PROFILE_ID/scrollback-lines "100000"
dconf write /org/gnome/terminal/legacy/profiles:/:$TERM_PROFILE_ID/foreground-color "'rgb(46,52,54)'"
dconf write /org/gnome/terminal/legacy/profiles:/:$TERM_PROFILE_ID/foreground-color "'rgb(211,215,207)'"

# Folder view
dconf write /org/gnome/nautilus/preferences/default-folder-viewer "'list-view'"
dconf write /org/gnome/nautilus/list-view/use-tree-view "true"
dconf write /org/gnome/nautilus/list-view/default-visible-columns "['name', 'size', 'type', 'owner', 'group', 'permissions', 'date_modified', 'starred']"
dconf write /org/gnome/nautilus/preferences/show-hidden-files "true"
dconf write /org/gnome/file-roller/file-selector/show-hidden "true"

# Login Screen
dconf write /org/gnome/login-screen/banner-message-enable "true"
dconf write /org/gnome/login-screen/banner-message-text "''"
dconf write /com/ubuntu/login-screen/background-color "'rgb(0,0,0)'"
dconf write /org/gnome/login-screen/fallback-logo "''"
dconf write /org/gnome/login-screen/logo "''"
dconf write /com/ubuntu/login-screen/background-picture-uri "''"

# Desktop
dconf write /org/gnome/desktop/interface/color-scheme "'prefer-dark'"
dconf write /org/gnome/desktop/interface/gtk-theme "'Yaru-blue-dark'"
dconf write /org/gnome/desktop/interface/icon-theme "'Yaru-blue'"
dconf write /org/gnome/eog/view/use-background-color "true"
dconf write /org/gnome/eog/view/background-color "'rgb(0,0,0)'"
dconf write /org/gnome/desktop/background/primary-color "'#000000'"
dconf write /org/gnome/desktop/background/picture-uri "''"             # <---- 'PATH/' for picture
dconf write /org/gnome/desktop/background/picture-uri-dark "''"        # <---- 'PATH/' for picture

dconf write /org/gnome/desktop/background/picture-options "'zoom'"  # centered, scaled, stretched, spanned
dconf write /org/gnome/desktop/background/show-desktop-icons "false"
dconf write /org/gnome/shell/extensions/dash-to-dock/dash-max-icon-size "25"
dconf write /org/gnome/desktop/interface/clock-format "'12h'"
dconf write /org/gnome/desktop/interface/clock-show-seconds "true"
dconf write /org/gnome/desktop/interface/clock-show-weekday "true"

# Gedit
dconf write /org/gnome/gedit/preferences/editor/scheme "'Yaru-dark'"

# Keyboard
dconf write /org/gnome/desktop/peripherals/keyboard/repeat-interval "10"
dconf write /org/gnome/desktop/peripherals/keyboard/delay "225"

# Mouse
dconf write /org/gnome/desktop/interface/cursor-size "50"

# Favorite Apps Icons
dconf write /org/gnome/shell/favorite-apps "['firefox_firefox.desktop', 'org.gnome.Nautilus.desktop', 'org.gnome.Terminal.desktop', 'gnome-control-center.desktop', 'org.gnome.gedit.desktop']"

# Login / Shutdown
dconf write /org/gnome/gnome-session/logout-prompt "false"
dconf write /org/gnome/desktop/screensaver/lock-enabled "false"
