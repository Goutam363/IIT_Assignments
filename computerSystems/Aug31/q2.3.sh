#!/bin/bash

grep ",[[:space:]]*E" *.txt | grep -o "^[0-9]\{8\}"

countCSP100=$(grep -c ",[[:space:]]*E" CSP100.txt)
countCSP101=$(grep -c ",[[:space:]]*E" CSP101.txt)
countCSP102=$(grep -c ",[[:space:]]*E" CSP102.txt)

mxCourse=""
if [ $countCSP100 -ge $countCSP101 ] && [ $countCSP100 -ge $countCSP102 ]; then
  mxCourse="CSP100.txt"
elif [ $countCSP101 -ge $countCSP102 ]; then
  mxCourse="CSP101.txt"
else
  mxCourse="CSP102.txt"
fi

sed -i 's/\bE\b/C/g' "$mxCourse"
echo "Replaced all E grades with C in $mxCourse"