source /usr/share/cachyos-fish-config/cachyos-config.fish

set -gx SSH_CONFIG_FILE "$HOME/.ssh/config"

# overwrite greeting
# potentially disabling fastfetch
#function fish_greeting
#    # smth smth
#end

# vim mode
#set -g fish_key_bindings fish_vi_key_bindings

alias rm='rm -I'
alias mv='mv -i'
alias cp='cp -i'
alias ln='ln -i'

alias vi='vim'
alias fishrc='vi ~/.config/fish/config.fish'
alias vimrc='vi ~/.vimrc'
alias ga='git add'
alias gc='git commit'
alias gd='git diff'
alias gl='git log --oneline'
alias gs='git status'
alias gp='git push'

function d --description 'List recent directories'
    if test (count $argv) -gt 0
        dirs $argv
        return $status
    end

    printf '%d\t%s\n' 0 (string replace -r '^'"$HOME"'($|/)' '~$1' -- $PWD)

    set -l stack $dirprev[-1..1]
    for index in (seq (math "min(9, "(count $stack)")"))
        printf '%d\t%s\n' $index (string replace -r '^'"$HOME"'($|/)' '~$1' -- $stack[$index])
    end
end

function 1 --description 'Go to directory history entry 1'
    prevd 1
end

function 2 --description 'Go to directory history entry 2'
    prevd 2
end

function 3 --description 'Go to directory history entry 3'
    prevd 3
end

function 4 --description 'Go to directory history entry 4'
    prevd 4
end

function 5 --description 'Go to directory history entry 5'
    prevd 5
end

zoxide init fish | source

direnv hook fish | source

if status is-interactive
    type -q fzf_key_bindings; and fzf_key_bindings

    function __tmux_session_picker
        if set -q TMUX
            command tmux-session-picker switch
        else
            command tmux-session-picker attach
        end
        commandline -f repaint
    end

    bind ctrl-f __tmux_session_picker
end
