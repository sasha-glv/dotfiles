function __ch_p_dir {
	target=$(cat ~/.dotfiles/.projects | fzf)
	if [ ! -z $target ]; then
		cd $target 
	else
		return 1
	fi
	if [[ -z $LBUFFER ]]; then
		zle reset-prompt
		return 1
	fi
	c=$(__fsel)
	if [[ -z $c ]]; then
		zle reset-prompt
		return 1
	fi
	LBUFFER="${LBUFFER} ${c}"
	zle accept-line
}

zle -N __ch_p_dir
bindkey '^W' __ch_p_dir

function set_title_precmd(){
    echo -ne "\033]0; $(basename "$PWD") \007"
}

function set_title_preexec() {
  printf "\e]2;%s\a" "$1"
}



