alias nvim-kick="NVIM_APPNAME=Kickstart nvim"

function nvims 
    set items "default" "Kickstart"
    set config (printf  "%s\n" $items | fzf --prompt=" Neovim Config " --height 50% --margin 10% --padding 5% --layout=reverse --border --exit-0)
    if [ -z $config ]
        echo "Nothing selected"
        return 0
    else if [ $config = "default" ]
        set config ""
    end
    env NVIM_APPNAME=$config nvim $argv
end
