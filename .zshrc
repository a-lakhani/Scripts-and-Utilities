# Left prompt shows username and current working directory, showing up to 3 parent directories
PROMPT='%B%F{231}%n%f %F{226}%3~ > %f%b'
# Right prompt shows current time in 12 hour AM/PM format
RPROMPT='%F{226}%t%f'
# Set what are supposed to be global variables
source /etc/environment

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd
unsetopt extendedglob
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle ':completion:*' auto-description 'specify %d'
zstyle ':completion:*' completer _oldlist _expand _complete _ignored _match _correct _approximate
zstyle ':completion:*' completions 1
zstyle ':completion:*' expand suffix
zstyle ':completion:*' file-sort name
zstyle ':completion:*' format '%d'
zstyle ':completion:*' glob 1
zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z} r:|[._-]=** r:|=**' '+l:|=* r:|=*'
zstyle ':completion:*' max-errors 2
zstyle ':completion:*' menu select=long
zstyle ':completion:*' preserve-prefix '//[^/]##/'
zstyle ':completion:*' prompt 'Corrected with %e error(s)'
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %l%s
zstyle ':completion:*' substitute 1
zstyle :compinstall filename '/home/alakhani/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# ADDED BY ADEEL
# Turn off all beeps
unsetopt BEEP
# Only turn off autocomplete beeps
# unsetopt LIST_BEEP

# change location of .zcompdump
compinit -d ~/.zsh/.zcompdump

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/alakhani/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/alakhani/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/alakhani/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/alakhani/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# Had issue with zsh recognizing delete key as delete key on Arch 
# .inputrc may need to be modified with different syntax for bash
# bindkey "\E[3~" delete-char

