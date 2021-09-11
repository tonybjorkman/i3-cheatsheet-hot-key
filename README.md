# i3 window manager auto cheatsheet hot key

# Requirements:
i3 window manager
Install xfce4-terminal, used for the popup.
gnome-terminal is required to figure out which process is running inside the terminal.
without gnome-terminal the script still works but then it will only be able to present a cheatsheet for the
terminal and not for the process running inside.

# Installation
run the install.sh - it will move cheatsheets to XDG data folder and move config to XDG config.

install gnome-terminal and xfce4-terminal if needed 

In i3 config add:

    #cheat sheet window
    for_window [instance="xfce4-terminal" title="Cheatsheet for.*"] floating enable, move position center, resize grow left 100, resize grow up 105
    bindsym $mod+F12 exec --no-startup-id ~/.config/i3/i3cheatsheet-btn/cheatsheet-toggle.sh

# Limitations:
Need to use Gnome-terminal for detection of the process which runs in bash. Lets say to get vim-shortcuts to get triggered when in vim and pressing the shortcut-key.
