source /usr/share/cachyos-fish-config/cachyos-config.fish

# overwrite greeting
# potentially disabling fastfetch
#function fish_greeting
#    # smth smth
#end

# vim mode
#set -g fish_key_bindings fish_vi_key_bindings

alias vi='vim'
alias fishrc='vi ~/.config/fish/config.fish'
alias vimrc='vi ~/.vimrc'
alias ga='git add'
alias gc='git commit'
alias gd='git diff'
alias gl='git log --oneline'
alias gs='git status'

function 1
    cd ..
end

function 2
    cd ../..
end

function 3
    cd ../../..
end

function 4
    cd ../../../..
end

function 5
    cd ../../../../..
end
