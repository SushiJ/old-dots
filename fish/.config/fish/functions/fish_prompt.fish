function fish_prompt
  if test -n "$SSH_TTY"
    echo -n (set_color brred)"$USER"(set_color white)'@'(set_color yellow)(prompt_hostname)' '
  end

  if test -n "$IN_NIX_SHELL"
    echo -n (set_color green) '<nix-shell>'
  end

  echo -n (set_color yellow)(prompt_pwd)' '

  set_color -o
  if fish_is_root_user
    echo -n (set_color red)'# '
  end
  echo -n (set_color "FF7F50")'λ '
  set_color normal
end
