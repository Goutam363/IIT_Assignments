#!/bin/bash

string1=$1
string2=$2
folder=$3

for file in "$folder"/*.txt; do
  sed -i "1,10s/$string1/$string2/g" "$file"
done