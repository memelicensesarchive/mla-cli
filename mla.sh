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

QUERY=`echo $2 | sed 's/ /+/'g`
RESULT=`curl -s https://memelicensesarchive.github.io/mlacli-repo/mla.json | jq -r  .["mla."$QUERY"_link"]`
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

if ! [ -x "$(command -v wget)" ]; then
    echo "wget is not installed, attempting to install it"
    sudo pacman -S wget
    doas pacman -S wget
    sudo apt install wget 
    doas apt install wget
    sudo zypper install wget
    doas zypper install wget
    sudo emerge -a wget --autounmask
    doas emerge -a wget --autounmask
    echo "If it didnt work, install  wget manually"
fi


_print_help(){
  cat << "EOF"
Usage:  mla [OPTIONS]
Options:
    -i  --info        Info of a license, and descriptions of that
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
