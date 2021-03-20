#!/bin/bash

SRC=$(pwd)/Sources

if !(systemctl -q is-active docker)
	then
	echo "Please start Docker service"
	exit 1
fi

docker run --name WebTools -d -p 8082:80 --mount type=bind,source="$SRC",target=/var/www/html php:apache
