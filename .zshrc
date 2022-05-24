if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="/data/data/com.termux/files/home/.zsh/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
zstyle ':omz:update' frequency 12

HISTFILE=$HOME/.zsh/.zsh_history
plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh
export LANG=en_US.UTF-8
export EDITOR='vim'
export GPG_TTY=$TTY

# Aliases
alias c='clear'
alias x='exit'
alias open='xdg-open'
alias fzf='fzf --reverse --border=rounded --margin 5% --preview="cat {}" --preview-window=up,30% --prompt="❯ " --pointer="❯" --color="spinner:yellow,border:bright-white"'
alias rs='termux-reload-settings'
alias ts='test-screen'

[[ ! -f ~/.zsh/.p10k.zsh ]] || source ~/.zsh/.p10k.zsh
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH" #For yarn
