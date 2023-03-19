#!/bin/bash

if [ ! -e "${USER}/.local/share/keyrings" ]; then
	echo -e 1234 | gnome-keyring-daemon --unlock
fi
