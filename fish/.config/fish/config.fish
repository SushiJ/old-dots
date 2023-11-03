set fish_greeting ""
set -gx COLORTERM truecolor

set -g theme_color_scheme Dracula
set -g fish_prompt_pwd_dir_length 1
set -g theme_display_user no
set -g theme_hide_hostname yes
set -g theme_hostname never
set -gx EDITOR "nvim"

# Aliases

if type -q exa
  alias ls "exa -l -g --icons"
  alias la "ls -a"
end

alias zc="nvim ~/.zshrc"
alias sni="sudo nala install"
alias wmrc="cd ~/.config/bspwm/ && nvim ."
alias conf="cd ~/.config && nvim ."
alias nconf="cd ~/.config/nvim/ && nvim ."
alias update="sudo nala update"
alias ns="nala search"
alias cat="bat"
alias pbcopy="xclip -selection clipboard"
alias pbpaste="xclip -selection clipboard -o"
alias dots="cd ~/.dotfiles"

# ASDF
set -gx ASDF "$HOME/.asdf"
source ~/.asdf/asdf.fish

# Go
set -gx GO "/usr/local/go"

# Pnpm
set -gx PNPM_HOME "/home/sushi/.local/share/pnpm"

# Brew
set -gx BREW "/home/linuxbrew/.linuxbrew/bin/"
set -gx BREW_PATH "$BREW" "/home/linuxbrew/.linuxbrew/sbin/"

# Bun
set -gx BUN_HOME "$HOME/.bun/bin"

set -gx PATH "$GO/bin" "$PNPM_HOME" "$BREW_PATH" "$ASDF/bin" "$BUN_HOME" $PATH

# source "/home/sushi/.bun/_bun"

