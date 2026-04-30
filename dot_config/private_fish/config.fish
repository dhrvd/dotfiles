set -g fish_greeting ""

if status is-interactive
    starship init fish | source
    zoxide init fish | source
end

if command -q eza
    alias ls 'eza --group-directories-first'
    alias ll 'eza -l --group-directories-first --git'
    alias la 'eza -la --group-directories-first --git'
    alias lt 'eza --tree --group-directories-first'
    alias lt2 'eza --tree --level=2 --group-directories-first'
end

abbr -a -- hx helix

abbr -a -- cz chezmoi
abbr -a -- cza 'chezmoi apply'
abbr -a -- cze 'chezmoi edit'
