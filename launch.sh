#!/usr/bin/env bash

# Read in .env file; error if not found
if [ ! -f .env ]; then
    echo ".env not found, running setup.sh"
    bash setup.sh
fi
source ./.env

function showhelp () {
   # Display Help
   echo
   echo "Usage: $0 [option...]"
   echo "options:"
   echo "  -h       Print this help."
   echo "  -d       Start in daemon mode."
   echo
}

while getopts "hd" option; do
   case $option in
      h)
         showhelp
         exit;;
      d)
         options="-d"
         ;;
     \?) # incorrect option
         echo "Error: Invalid option"
         exit;;
   esac
done

# On newer versions, docker-compose is docker compose
docker compose up $options --remove-orphans || docker-compose up $options --remove-orphans
