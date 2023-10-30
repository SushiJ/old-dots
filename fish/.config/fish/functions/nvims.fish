alias nvim-lazyVim="NVIM_APPNAME=LazyVim nvim"
alias nvim-lazy="NVIM_APPNAME=LazyNvim nvim"
alias nvim-kick="NVIM_APPNAME=Kickstart nvim"
alias nvim-chad="NVIM_APPNAME=NvChad nvim"
alias nvim-astro="NVIM_APPNAME=AstroNvim nvim"
alias nvim-lunar="NVIM_APPNAME=LunarVim nvim"

function nvims 
    set items "default" "Kickstart" "LazyVim" "LazyNvim" "NvChad" "AstroNvim" "LunarVim"
    set config (printf  "%s\n" $items | fzf --prompt=" Neovim Config " --height=56% --layout=reverse --border --exit-0)
    if [ -z $config ]
        echo "Nothing selected"
        return 0
    else if [ $config = "default" ]
        set config ""
    end
    env NVIM_APPNAME=$config nvim $argv
end
