#!/usr/bin/env bash

sudo pacman -Syyu && sudo pacman --needed --ask 4 -Sy - < software.txt
