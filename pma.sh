#!/usr/bin/env bash
# _____ ______   ___       ________     
#|\   _ \  _   \|\  \     |\   __  \    
#\ \  \\\__\ \  \ \  \    \ \  \|\  \   
# \ \  \\|__| \  \ \  \    \ \   __  \  
#  \ \  \    \ \  \ \  \____\ \  \ \  \ 
#   \ \__\    \ \__\ \_______\ \__\ \__\
#    \|__|     \|__|\|_______|\|__|\|__|
# MemeLicensesArchive-CLI
# v1
# LICENSED UNDER YES
# FORKED FROM PMA

DIR="/the/path/of/plugins/folder"
QUERY=`echo $2 | sed 's/ /+/'g`
RESULT=`curl -s https://pluginmanagerr.github.io/pma-repo/vizality.json | jq -r  ".pma."$QUERY"_link"`
if ! [ -x "$(command -v jq)" ]; then
    echo "jq is not installed, attempting to install it"
    sudo pacman -S jq
    doas pacman -S jq
    sudo apt install jq
    doas apt install jq
    sudo emerge -a jq --autounmask
    doas emerge -a jq --autounmask
    sudo zypper install jq
    doas zypper install jq
    echo "If it didnt work, install  jq manually"
fi

if ! [ -x "$(command -v curl)" ]; then
    echo "cURL is not installed, attempting to install it"
    sudo pacman -S curl
    doas pacman -S curl
    sudo apt install curl 
    doas apt install curl 
    sudo zypper install curl
    doas zypper install curl
    sudo emerge -a curl --autounmask  
    doas emerge -a curl --autounmask
    echo "If it didnt work, install  curl manually"
fi

if ! [ -x "$(command -v git)" ]; then
    echo "git is not installed, attempting to install it"
    sudo pacman -S git
    doas pacman -S git
    sudo apt install git 
    doas apt install git 
    sudo zypper install git
    doas zypper install git
    sudo emerge -a git --autounmask
    doas emerge -a git --autounmask
    echo "If it didnt work, install  git manually"
fi


_print_help(){
  cat << "EOF"
Usage:  pma [OPTIONS]
Options:
    -i  --info        Info of a license, and descriptions of those
    -l  --list        List of licenses
    -h  --help        Show help
    -v  --version     Show version
    -f  --fetch       Fetch a license
EOF
}

POSITIONAL=()
while [[ $# -gt 0 ]]; do
    case $1 in
         --list|-l)
          curl -s https://memelicensesarchive.github.io/mlacli-repo/mla.json | jq -r  ".mla"
            shift
            shift
            ;;
           --version|-v)
           echo '
  _____ ______   ___       ________     
|\   _ \  _   \|\  \     |\   __  \    
\ \  \\\__\ \  \ \  \    \ \  \|\  \   
 \ \  \\|__| \  \ \  \    \ \   __  \  
  \ \  \    \ \  \ \  \____\ \  \ \  \ 
   \ \__\    \ \__\ \_______\ \__\ \__\
    \|__|     \|__|\|_______|\|__|\|__|'              
            echo "v1"
            echo "mla-cli is open source, you can check the repos here:"
            echo "https://github.com/memelicensesarchive/mla-cli"
            echo "https://github.com/memelicensesarchive/mlacli-repo"
            shift
            ;;
          --fetch|-f)
           cd $DIR
           wget -O LICENSE $RESULT 
            shift
            shift
            ;;
          --info|-i)
           curl -s https://memelicensesarchive.github.io/mlacli-repo/mla.json | jq -r --arg QUERY "$QUERY"  ".mla.$QUERY"
            shift
            shift
            ;;
        --help|-h)
            _print_help
            shift
            shift
            ;;
        *)
          echo "Option not found"
          _print_help
          shift
          ;;
    esac
done
