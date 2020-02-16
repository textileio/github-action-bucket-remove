#!/bin/sh

set -e

echo "Removing Bucket $1"
time=$(date)
mkdir -p $HOME/.textile

echo "token: $2" > $HOME/.textile/auth.yml

echo -ne '\n' | textile buckets rm $1
wait