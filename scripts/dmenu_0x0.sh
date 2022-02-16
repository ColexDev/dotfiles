#!/bin/bash

file=$(find | dmenu -i -l 25)
curl -F "file=@$file" 0x0.st | xclip -selection c
