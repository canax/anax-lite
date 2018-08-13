#!/usr/bin/env bash
#
# Postprocess scaffold
#

# Include ./functions.bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "$DIR/functions.bash"

# Install using composer
[[ $1 = "NO_COMPOSER" ]] || composer install

# Run all scripts in ./postprocess.d
for file in $( ls $DIR/postprocess.d/*.bash ); do
    #echo "${file##*/}"
    bash "$file"
done
