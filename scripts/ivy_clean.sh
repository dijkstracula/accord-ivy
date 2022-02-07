#!/bin/bash

# Finds all .ivy files in the directory tree, and removes their corresponding
# .cpp, .h, .dsc, executable, and, if on OSX, .dSYM files.  Prints the name of
# every deleted file.
#
# author: ntaylor
#
# This script deletes things! Use at your own risk.

root=$(pwd)

extensions="cpp h dsc"

function remove() {
    name=$1

    # Delete the compiled binary (but make sure it's an ordinary, executable file)
    if [[ -f "$name" ]] && [[ -x "$name" ]] 
    then 
        rm -v "$name" 
    fi

    # OSX's debug information is stored outside the binary in a directory (so we need -r).
    if [[ "$(uname)" == "Darwin" ]] && [[ -e "$name.dSYM" ]]
    then 
        echo "$name.dSYM"
        rm -r "$name.dSYM"
    fi

    for ext in $extensions; do
        if [[ -f "$name.$ext" ]]
        then
            rm -v "$name.$ext"
        fi
    done
}

for ivy_file in $(find $root -name '*.ivy')
do
    proj_name=${ivy_file%.*}

    remove $proj_name

    # For every "isolate subproject" (i.e. "hello_world_recv", "hello_world_send", ...
    for iso in $(ls -d ${proj_name}* | grep -v '.ivy$')
    do
        proj_name=${iso%.*}
        remove $proj_name
    done
done
