#!/bin/bash

countCSP100=$(grep -c ",[[:space:]]*F" CSP100.txt)
countCSP101=$(grep -c ",[[:space:]]*F" CSP101.txt)
countCSP102=$(grep -c ",[[:space:]]*F" CSP102.txt)

if [ $countCSP100 -ge $countCSP101 ] && [ $countCSP100 -ge $countCSP102 ]; then
  echo "CSP100 has the maximum number of F grades: $countCSP100"
elif [ $countCSP101 -ge $countCSP102 ]; then
  echo "CSP101 has the maximum number of F grades: $countCSP101"
else
  echo "CSP102 has the maximum number of F grades: $countCSP102"
fi