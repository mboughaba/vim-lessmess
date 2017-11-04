#!/usr/bin/env bash

# Do not "cd" to any existing "test" dir from CDPATH!
unset CDPATH

cd "$( dirname "${BASH_SOURCE[0]}" )" && vim -Nu minivimrc -c 'Vader! *' > /dev/null
