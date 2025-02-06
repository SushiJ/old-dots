set fish_greeting ""
set -gx COLORTERM truecolor

set -g fish_prompt_pwd_dir_length 1
set -g theme_display_user no
set -g theme_hide_hostname yes
set -g theme_hostname never
set -gx EDITOR "nvim"

set -g LANG "en_US.UTF-8"

# Aliases

if type -q exa
  alias ls "exa -l -g --icons"
  alias la "ls -a"
end

if type -q bat
  alias cat "bat"
end

alias p="pnpm"
alias vim="nvim"
alias px="pnpm dlx"
alias wmrc="cd ~/.config/bspwm/ && nvim ."
alias conf="cd ~/.config && nvim ."
alias nconf="cd ~/.config/nvim/ && nvim ."
alias pbcopy="xclip -selection clipboard"
alias pbpaste="xclip -selection clipboard -o"
alias dots="cd ~/.dotfiles"

zoxide init --cmd cd fish | source

# pnpm
set -gx PNPM_HOME "/home/sushi/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end
