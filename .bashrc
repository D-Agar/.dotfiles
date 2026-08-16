#### HISTORY ####
# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# Avoid duplicate entries and commands starting with space
HISTCONTROL=ignoreboth:erasedups
HISTIGNORE="ls:cd:cd -:pwd:exit:date:* --help"

# Timestamp each history entry
HISTTIMEFORMAT="%F %T "

#### TERMINAL/WINDOW APPEARANCE ####
# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
  debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
xterm-color | *-256color) color_prompt=yes ;;
esac

#### If Starship is enabled, PS1 can be commented out ####

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls --color=auto'
  #alias dir='dir --color=auto'
  #alias vdir='vdir --color=auto'

  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  else
    echo "Warning: bash-completion not found" >&2
  fi
fi

#### PATH ####
# Only add to PATH if not already present
[[ ":$PATH:" != *":/opt/nvim-linux-x86_64/bin:"* ]] && export PATH="$PATH:/opt/nvim-linux-x86_64/bin"

#### ALIASES ####
alias update-kitty='curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin'

function update-nvim() {
  curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz &&
    sudo rm -rf /opt/nvim-linux-x86_64 &&
    sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz &&
    rm nvim-linux-x86_64.tar.gz
}

function update-yazi() {
  wget -q https://github.com/sxyazi/yazi/releases/latest/download/yazi-x86_64-unknown-linux-gnu.zip &&
    rm -rf ~/.local/yazi/ ~/.local/bin/yazi &&
    unzip -q yazi-x86_64-unknown-linux-gnu.zip -d ~/.local/ &&
    mv ~/.local/yazi-x86_64-unknown-linux-gnu/ ~/.local/yazi &&
    ln -s ~/.local/yazi/yazi ~/.local/bin &&
    rm -rf yazi-x86_64-unknown-linux-gnu.zip ~/.local/yazi-x86_64-unknown-linux-gnu/
}
function y() {
  local tmp cwd
  tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
  command yazi "$@" --cwd-file="$tmp"
  IFS= read -r -d '' cwd <"$tmp"
  [ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd" || builtin true
  command rm -f -- "$tmp"
}

# Configuration Customisation
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# Kitty Commands
alias icat="kitten icat"

# Useful general commands
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias ls='ls -lah --color=auto --group-directories-first'

# Navigation commands
alias ..='cd .. && ls'         # Go up one level and list contents
alias ...='cd ../.. && ls'     # Go up two levels and list
alias ....='cd ../../.. && ls' # Go up three levels

# Safer removal
alias rm='rm -I --preserve-root'

# Keep my files
alias cp='cp -i'
alias mv='mv -i'

# Create parent directories
alias mkdir='mkdir -p'

# Update system
alias update='sudo dnf update -y && sudo dnf upgrade -y'

# Random commands
# Add an "alert" alias for long running commands.
# Use like so: sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Stupid GlobalProtect
alias globalprotect-kill="sudo pkill -9 -fi globalprotect"

#### SOFTWARE SETUP ####
source $HOME/.env

# LazyGit
alias lg='lazygit'

# Neovim
alias vim='nvim'
export EDITOR="nvim"
export VISUAL="$EDITOR"

# R development
# required for V8 package
export DOWNLOAD_STATIC_LIBV8=1

# ROS2 Development - improved
# if [[ -n "${ROS_DISTRO}" ]]; then
#   source /opt/ros/humble/setup.bash || echo "Warning: ROS setup not found"
#   source /usr/share/colcon_argcomplete/hook/colcon-argcomplete.bash || echo "Warning: colcon argcomplete not found"
#   alias setup='source install/local_setup.bash'
# fi

# ONNX Runtime
# if [ -d "/opt/onnxruntime" ]; then
#   export ONNXRUNTIME_DIR="/opt/onnxruntime" &&
#     export LD_LIBRARY_PATH="$ONNXRUNTIME_DIR/lib:$LD_LIBRARY_PATH"
# fi

# Startship prompt
eval "$(starship init bash)"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/daniel/miniconda3/bin/conda' 'shell.bash' 'hook' 2>/dev/null)"
if [ $? -eq 0 ]; then
  eval "$__conda_setup"
else
  if [ -f "/home/daniel/miniconda3/etc/profile.d/conda.sh" ]; then
    . "/home/daniel/miniconda3/etc/profile.d/conda.sh"
  else
    export PATH="/home/daniel/miniconda3/bin:$PATH"
  fi
fi
unset __conda_setup
# <<< conda initialize <<<

# . "$HOME/.cargo/env"
# source /usr/local/src/alacritty/extra/completions/alacritty.bash

export PATH="${HOME}/bin/:$HOME/.local/bin:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

# >>> Added by Spyder >>>
alias spyder=/home/daniel/.local/spyder-6/envs/spyder-runtime/bin/spyder
alias uninstall-spyder=/home/daniel/.local/spyder-6/uninstall-spyder.sh
# <<< Added by Spyder <<<
