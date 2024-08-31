#!/bin/bash

word=$1

count=$(find . -type f -name "*.csv" | xargs grep -o "\b${word}\b" | wc -l)

echo "Total occurences of '$word':$count"