# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

alias ts="tailscale"
alias vpnon="sudo tailscale up --exit-node=t480-cachy"
alias vpnoff="sudo tailscale down"

# Exports & PATH
export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
[ -d ~/intelFPGA/20.1/modelsim_ase/bin ] && export PATH="$PATH:$HOME/intelFPGA/20.1/modelsim_ase/bin"
[ -d /usr/local/texlive/2025/bin/x86_64-linux ] && export PATH="/usr/local/texlive/2025/bin/x86_64-linux:$PATH"

# Oh My Zsh
if [ -d "$HOME/.oh-my-zsh" ]; then
    export ZSH="$HOME/.oh-my-zsh"
elif [ -d /usr/share/oh-my-zsh ]; then
    export ZSH="/usr/share/oh-my-zsh"
fi
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(git fzf zsh-autosuggestions zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# lazy-load conda
conda() {
    unset -f conda
    __conda_setup="$('/home/kevinjin/anaconda3/bin/conda' 'shell.zsh' 'hook' 2>/dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    else
        if [ -f "/home/kevinjin/anaconda3/etc/profile.d/conda.sh" ]; then
            \. "/home/kevinjin/anaconda3/etc/profile.d/conda.sh"
        else
            export PATH="/home/kevinjin/anaconda3/bin:$PATH"
        fi
    fi
    unset __conda_setup
    conda "$@"
}

# lazy-load nvm
export NVM_DIR="$HOME/.nvm"
_load_nvm() {
    unset -f _load_nvm nvm node npm npx gemini
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
}
nvm() { _load_nvm; nvm "$@"; }
node() { _load_nvm; node "$@"; }
npm() { _load_nvm; npm "$@"; }
npx() { _load_nvm; npx "$@"; }
gemini() { _load_nvm; gemini "$@"; }

# lazy-load ROS2
if [ -d ~/ros2_ws/src/mrover ]; then
    alias mrover="cd ~/ros2_ws/src/mrover && source ~/ros2_ws/src/mrover/venv/bin/activate && source ../../install/Debug/setup.zsh"
    alias base="ros2 launch mrover basestation.launch.py mode:=dev"
    alias sim="ros2 launch mrover simulator.launch.py"
    export ROS_DOMAIN_ID=5
fi
ros_env() {
    if [ -f /opt/ros/humble/setup.zsh ]; then
        source /opt/ros/humble/setup.zsh
        local ws_setup=~/ros2_ws/install/setup.zsh
        [ -f "$ws_setup" ] && source "$ws_setup"
    fi
    if command -v register-python-argcomplete3 &>/dev/null; then
        eval "$(register-python-argcomplete3 ros2)"
        eval "$(register-python-argcomplete3 colcon)"
    fi
}

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# opencode
export PATH=/home/kevinjin/.opencode/bin:$PATH
