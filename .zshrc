ZSH=~/.oh-my-zsh
ZSH_THEME='robbyrussell'

ZVM_VI_ESCAPE_BINDKEY=qq
ZVM_VI_HIGHLIGHT_BACKGROUND=#262626
ZVM_VI_HIGHLIGHT_FOREGROUND=#FFFFFF

plugins=(
  git
  sudo
  zsh-256color
  zsh-autosuggestions
  zsh-syntax-highlighting
  zsh-vi-mode
)

source $ZSH/oh-my-zsh.sh

if pacman -Qi yay &>/dev/null ; then
  aurhelper="yay"
elif pacman -Qi paru &>/dev/null ; then
  aurhelper="paru"
fi

function in {
  local pkg="$1"
  if pacman -Si "$pkg" &>/dev/null ; then
    sudo pacman -S "$pkg"
  else
    "$aurhelper" -S "$pkg"
  fi
}

# Aliases
alias l='eza --icons=auto' # long list
alias ls='eza --icons=auto' # short list
alias ll='eza -lha --icons=auto --sort=name --group-directories-first' # long list all
alias ld='eza -lhD --icons=auto' # long list dirs
alias un='$aurhelper -Rns' # uninstall package
alias up='$aurhelper -Syu' # update system/package/aur
alias pl='$aurhelper -Qs' # list installed package
alias pa='$aurhelper -Ss' # list availabe package
alias pc='$aurhelper -Sc' # remove unused cache
alias po='$aurhelper -Qtdq | $aurhelper -Rns -' # remove unused packages, also try > $aurhelper -Qqd | $aurhelper -Rsu --print -
alias open='xdg-open'
alias vim='nvim --listen /tmp/nvim'
alias nvim='nvim --listen /tmp/nvim'
alias c='clear'
alias rm='rm -rf'
alias m='mkdir -p'
alias t='touch'
alias cp='cp -r'
alias x='exit'

# Exports
export PATH=$HOME/.scripts:$PATH
export PATH="$HOME/.cargo/bin:$PATH"
export PATH=./node_modules/.bin:./vendor/bin:$PATH
export PATH=$PATH:/opt/android-sdk/platform-tools
export PATH="$HOME/.local/share/gem/ruby/3.3.0/bin:$PATH"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
