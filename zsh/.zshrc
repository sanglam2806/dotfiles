# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export PATH=/opt/homebrew/bin:$PATH
export PATH=/Users/lamsang/Document/Dev/tool/flutter/bin:$PATH
source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Zig version controll tool
export PATH=/Users/lamsang/.zvm/bin:$PATH
export PATH=/Users/lamsang/.zvm/self:$PATH

plugins=(git)

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Alias for easier
alias v=nvim
alias ov='cd ~/dotfiles/'

# tmux source file
alias stm='tmux source-file ~/.tmux.conf \;'

# open vim setting

alias os='nvim ~/.zshrc'
op() {
  local dir=~/Document/Dev/"$1"
  if [ -d "$dir" ]; then
    cd "$dir" && echo "went to the ~/Document/Dev/$1 folder" || return 1
  else
    echo "Could not find the directory: $1"
    return 1
  fi
}
alias ss='source ~/.zshrc'
alias cps='cp ~/.zshrc ~/.config/nvim/.zshrc'
alias oh='cd ~/ && echo "Went back home"'

# setting Lgtm
alias git='lgtm'
alias gts='lgtm status'

# setting fzf
source <(fzf --zsh)
alias f=fzf
# preview with bat
alias fp='fzf --preview="bat --color=always {}"'
# open neovim with select file by tab
alias fv='nvim ${fzf -m --preivew="bat --color=always {}"'

alias ll='ls -ls'

# jenv manages JAVA_HOME/PATH dynamically; switch with `jenv global <version>` or `jenv local <version>`
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"


# bun completions
[ -s "/Users/lamsang/.bun/_bun" ] && source "/Users/lamsang/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

. "$HOME/.local/bin/env"
