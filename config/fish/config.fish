set fish_greeting
starship init fish | source

if status --is-interactive
    abbr --add --global ls "exa --long"
    abbr --add --global lsa "exa --long --all"
    abbr --add --global tree "exa --tree --ignore-glob '.git|.svn|target|out|build'"
    abbr --add --global bat "bat --theme ansi"
    abbr --add --global vim "nvim"
    abbr --add --global sudo "doas"
    abbr --add --global open "xdg-open"
    abbr --add --global reboot "systemctl reboot"
    abbr --add --global poweroff "systemctl poweroff"
    abbr --add --global suspend "systemctl suspend"
end
