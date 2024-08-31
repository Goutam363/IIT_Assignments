#!/bin/bash

csp102A=$(grep -E "^[0-9]{8},[[:space:]]*A" CSP102.txt | cut -d',' -f1)

for rollno in $csp102A; do
  if grep -q "^$rollno[[:space:]]*,[[:space:]]*B" CSP101.txt; then
    echo "$rollno"
  fi
done
