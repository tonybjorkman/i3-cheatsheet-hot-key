ifeq ($(origin XDG_DATA_HOME), undefined)
	data_path="${HOME}/.local/share/i3cheats"
	echo "mkdir ${HOME}/.local/share/i3cheats"
	#data_path="tony"
	echo "out ${data_path}"
	echo "cp -r cheatsheets  ${HOME}/.local/share/i3cheats"
else
	echo "mkdir $(origin XDG_DATA_HOME)/i3cheats"
	echo "cp -r cheatsheets  $(origin XDG_DATA_HOME)/i3cheats"
	echo "XDG_DATA_HOME defined: $(origin XDG_DATA_HOME)"
endif

