# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

if [ -d "$HOME/.oh-my-zsh" ]; then
    export ZSH="$HOME/.oh-my-zsh"
elif [ -d /usr/share/oh-my-zsh ]; then
    export ZSH="/usr/share/oh-my-zsh"
fi

ZSH_THEME="powerlevel10k/powerlevel10k"


# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

plugins=(git fzf zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# end pnpm

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/kevinjin/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/kevinjin/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/kevinjin/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/kevinjin/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


if [ -d ~/ros2_ws/src/mrover ]; then
    alias mrover="cd ~/ros2_ws/src/mrover && source ~/ros2_ws/src/mrover/venv/bin/activate && source ../../install/Debug/setup.zsh"
    export ROS_DOMAIN_ID=5
fi

[ -d ~/intelFPGA/20.1/modelsim_ase/bin ] && export PATH=$PATH:~/intelFPGA/20.1/modelsim_ase/bin/


if [ -f /opt/ros/humble/setup.zsh ]; then
    ROS2_WS_PATH=~/ros2_ws
    source /opt/ros/humble/setup.zsh
    CATKIN_SETUP_PATH=${ROS2_WS_PATH}/install/setup.zsh
    if [ -f ${CATKIN_SETUP_PATH} ]; then
        source ${CATKIN_SETUP_PATH}
    fi
fi

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# ros2 completions
if command -v register-python-argcomplete3 &> /dev/null; then
    eval "$(register-python-argcomplete3 ros2)"
    eval "$(register-python-argcomplete3 colcon)"
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PATH="$HOME/.local/bin:$PATH"
[ -d /usr/local/texlive/2025/bin/x86_64-linux ] && export PATH="/usr/local/texlive/2025/bin/x86_64-linux:$PATH"
