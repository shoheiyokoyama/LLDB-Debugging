#!/bin/bash

COMMANDS_DIR=~/LLDBCommands

if [ ! -d $COMMANDS_DIR ]; then
    mkdir -p $COMMANDS_DIR 
fi

cp achoo.py $COMMANDS_DIR/achoo.py
cp .lldbinit ~/.lldbinit
cp .lldbinit-Xcode ~/.lldbinit-Xcode
