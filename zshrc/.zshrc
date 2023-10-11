export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(zsh-syntax-highlighting zsh-autosuggestions vi-mode asdf ripgrep node fd httpie poetry)

source $ZSH/oh-my-zsh.sh

## User configuration

# Scripts
bindkey -s ^f "~/scripts/tmux-sessionizer\n"

# export MANPATH="/usr/local/man:$MANPATH"
# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# Vi-mode

VI_MODE_RESET_PROMPT_ON_MODE_CHANGE=true
MODE_INDICATOR="%F{white}+%f"
INSERT_MODE_INDICATOR="%F{red}+%f"

PROMPT="$PROMPT\$(vi_mode_prompt_info)"
RPROMPT="\$(vi_mode_prompt_info)$RPROMPT"

# defaults
VI_MODE_CURSOR_NORMAL=1
VI_MODE_CURSOR_VISUAL=1
VI_MODE_CURSOR_INSERT=1
VI_MODE_CURSOR_OPPEND=1

alias zc="nvim ~/.zshrc"
alias sni="sudo nala install" 
alias wmrc="cd ~/.config/bspwm/ && nvim ." 
alias conf="cd ~/.config && nvim ." 
alias nconf="cd ~/.config/nvim/ && nvim ." 
alias update="sudo nala update"
alias xampp="(cd /opt/lampp && sudo ./manager-linux-x64.run)"
alias ns="nala search"
alias n="nvim"
# alias vim="nvim"
alias l="exa -l"
alias la="exa -la"
alias cat="bat"
alias pbcopy="xclip -selection clipboard"
alias pbpaste="xclip -selection clipboard -o"

alias nvim-lazy="NVIM_APPNAME=LazyVim nvim"
alias nvim-kick="NVIM_APPNAME=Kickstart nvim"
alias nvim-chad="NVIM_APPNAME=NvChad nvim"
alias nvim-astro="NVIM_APPNAME=AstroNvim nvim"
alias nvim-lunar="NVIM_APPNAME=LunarVim nvim"

function nvims() {
  items=("default" "Kickstart" "LazyVim" "NvChad" "AstroNvim" "LunarVim")
  config=$(printf "%s\n" "${items[@]}" | fzf --prompt=" Neovim Config  " --height=50% --layout=reverse --border --exit-0)
  if [[ -z $config ]]; then
    echo "Nothing selected"
    return 0
  elif [[ $config == "default" ]]; then
    config=""
  fi
  NVIM_APPNAME=$config nvim $@
}
# export go path 
PATH="$PATH:/usr/local/go/bin"
PATH="$HOME/.cabal/bin:$HOME/.ghcup/bin:$PATH"

PATH=$PATH:/home/sushi/.spicetify

# Volta
VOLTA_HOME="$HOME/.volta"
PATH="$VOLTA_HOME/bin:$PATH"

# PNPM
PNPM_HOME="/home/sushi/.local/share/pnpm"
PATH="$PNPM_HOME:$PATH"

# Ruby
GEM_PATH="$HOME/.local/share/gem/ruby/3.0.0/bin"
PATH="$GEM_PATH:$PATH"

#brew
BREW="/home/linuxbrew/.linuxbrew/bin/"
BREW_PATH="$BREW:/home/linuxbrew/.linuxbrew/sbin/"
PATH="$BREW_PATH:$PATH"

#bun 
BUN_HOME="$HOME/.bun/bin"
PATH="$BUN_HOME:$PATH"

# EXPORT PATH
export PATH="$PATH:$HOME/.local/bin/"

# fzf Catpuccin Mocha
#export FZF_DEFAULT_OPTS=" \
#--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
#--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
#--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"
go_test() {
  go test $* | sed ''/PASS/s//$(printf "\033[32mPASS\033[0m")/'' | sed ''/SKIP/s//$(printf "\033[34mSKIP\033[0m")/'' | sed ''/FAIL/s//$(printf "\033[31mFAIL\033[0m")/'' | sed ''/FAIL/s//$(printf "\033[31mFAIL\033[0m")/'' | GREP_COLOR="01;33" egrep --color=always '\s*[a-zA-Z0-9\-_.]+[:][0-9]+[:]|^'
}

# export nvm 
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
[ -f "/home/sushi/.ghcup/env" ] && source "/home/sushi/.ghcup/env" # ghcup-env


# Load Angular CLI autocompletion.
source <(ng completion script)

# bun completions
[ -s "/home/sushi/.bun/_bun" ] && source "/home/sushi/.bun/_bun"




