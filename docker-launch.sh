#!/bin/bash

function show_usage(){
  printf "Utilisation: $0 [options [paramètres]]\n" 
  printf "\n"
  printf "Options:\n"
  printf "  -r|--run,                     Lance le site web dans un conteneur Docker. \"WebTools\" par défaut.\n"
  printf "  -n|--name [nom du conteneur], Assigne un nom au conteneur. \"WebTools\" par défaut.\n"
  printf "  -u|--update,                  Redémarre le conteneur pour actualiser les fichiers du site.\n"
  printf "  -d|--delete,                  Stop et supprime le conteneur Docker.\n"
  printf "  -h|--help,                    Affiche le menu d'aide.\n"
  
  return 0  
}

function run(){
  docker run --name $1 -d -p 8082:80 --mount type=bind,source="$SRC",target=/var/www/html php:apache
}

function delete(){
  docker stop $1; docker rm $1;
}

if !(systemctl -q is-active docker)
	then
	echo "Veuillez démarrer le service Docker"
	exit 1
fi

SRC=$(pwd)/Sources
DNAME="WebTools"

while [ ! -z "$1" ]; do
    if [[ "$1" == "-h" ]] || [[ "$1" == "--help" ]];then
        show_usage
    elif [[ "$1" == "-r" ]] || [[ "$1" == "--run" ]];then
        run "$DNAME"
    elif [[ "$1" == "-n" ]] || [[ "$1" == "--name" ]];then
        run "$2"
        shift
    elif [[ "$1" == "-u" ]] || [[ "$1" == "--update" ]];then
        if [ -z "$2" ];then
            delete "$DNAME"
            $0 "-r"
        else
            delete "$2"
            $0 "-n $2"
            shift
        fi
    elif [[ "$1" == "-d" ]] || [[ "$1" == "--delete" ]];then
        if [ -z "$2" ];then
            delete "$DNAME"
        else
            delete "$2"
            shift
        fi
    else
        echo "Commande $1 inconnue."
        show_usage
    fi
    shift
done
