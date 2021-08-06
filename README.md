
# i3 window manager auto cheatsheet hot key

# Requirements:
i3 window manager
Install xfce4-terminal, used for the popup.

In i3 config:

\#cheat sheet window
for\_window [instance="xfce4-terminal" title="Cheatsheet for.\*"] floating enable, move position center, resize grow left 100, resize grow up 105

# Limitations:
Need to use Gnome-terminal for detection of the process which runs in bash. Lets say to get vim-shortcuts to get triggered when in vim and pressing the shortcut-key.
