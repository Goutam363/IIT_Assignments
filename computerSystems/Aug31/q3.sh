#!/bin/bash

folder=$1

find "$folder" -type f -size 0 | xargs rm -f
