#!/bin/bash

# Get information about the currently focused window to know which cheatsheet to open/create.
cheatsheetdir=$(dirname $0)"/cheatsheets"
mkdir -p -- "$cheatsheetdir"
winid=$(xprop -root | awk '/_NET_ACTIVE_WINDOW\(WINDOW)/ {print $NF}' | xargs printf "%#010x\n")
winclass=$(xprop -id $winid | awk '/WM_CLASS/ {print $NF}')
niceclass=${winclass//\"/}
wm_name=$(xprop -id $winid | awk -vFPAT='("[^"]+")' '/WM_NAME\(STRING)/ {print $NF}')
nicewm_name=${wm_name//\"/}
terminalPID=$(xprop -id $winid | awk '/_NET_WM_PID/ {print $NF}')

# Debug 
debugfile="debug.txt"
#echo 'winid:'$winid >> $debugfile
#echo "First root, then winid below:=====" >> $debugfile
#xprop -root >> $debugfile
#xprop -id $winid >> $debugfile
#echo 'winclass:'$niceclass >> $debugfile

# 3 scenarios: 	Gnome-terminal in focus so get running process if any.
#	 	Cheatsheet window already in focus so shut it down.
#		Any other window selected, open cheatsheet window.
if [ $niceclass == "Gnome-terminal" ] && [[ $nicewm_name != "Cheatsheet for"* ]] 
then
    # Hot key pressed when in Gnome terminal, get the process running in it
    #echo 'winPID:'$terminalPID >> $debugfile
     # get inx of window for this PID
    termInx=$(wmctrl -l -p | grep $terminalPID | awk '/'"$winid"'/ {print NR}')
    #echo 'term inx:'$termInx >> $debugfile
     # Take the childprocess of that inx and PID
    shell_process=$(pstree -p $terminalPID | awk -F '-' '{print $NF}' | awk -F '(' 'NR=='"$termInx"' {print $1}')
    #echo 'found process:'$shell_process >> $debugfile
    cheatsheet_path=$cheatsheetdir/$shell_process.txt
    touch $cheatsheet_path
    xfce4-terminal -T 'Cheatsheet for '$shell_process -x vim $cheatsheet_path
elif [[ $nicewm_name == "Cheatsheet for "* ]]
then
    # Hot key pressed when Cheatsheet window was in focus, toggle cheatsheet off
    #echo "Cheatsheet already open. will kill it" >> $debugfile
    #echo "nicewm_name="$nicewm_name >> $debugfile
    xprop -root >> $debugfile
    xprop -id $winid >> $debugfile
    kill $terminalPID
else
    # Default case, Hot key pressed when any "non-special" window was in focus. Open it's cheatsheet.
    #echo "Neither cheatsheet or terminal as active" >> $debugfile
    #echo "nicewm_name="$nicewm_name >> $debugfile
    cheatsheet_path=$cheatsheetdir/$niceclass.txt
    touch $cheatsheet_path
    xfce4-terminal -T 'Cheatsheet for '$niceclass -x vim $cheatsheet_path
fi

