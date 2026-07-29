fish_add_path ~/.local/bin

# Machine-specific config (secrets, local overrides) — not tracked in dotfiles
if test -f ~/.config/fish/local.fish
    source ~/.config/fish/local.fish
end
alias davinci-resolve-studio 'env QT_QPA_PLATFORM=xcb /usr/bin/davinci-resolve-studio'
