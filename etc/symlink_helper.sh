#!/bin/bash

set -eu

# If the given directory already exists and it's not symlink, rename it for backup
if [ -d $2 ] && ! [ -L $2 ]; then
  RENAMED_TO="$2_$(date +%Y_%m_%d_%H_%M_%s)"
  mv "$2" "$RENAMED_TO"
  echo "NOTICE ====================================================="
  echo "$2 already exists, so renamed to $RENAMED_TO"
  echo "============================================================"
fi

# Create a symlink
ln -sfnv $1 $2
