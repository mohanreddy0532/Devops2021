#!/bin/bash

## There are majorly two loop commands while & for , There are other two commands as well which are inverse the logic of while & for which are until & select.

# while [ expression ]; do
# commands
# done

# for var in input1 input2 input3 ... ; do
# commands
# done

# Read input from user and iterate loop those many times
read -p 'Enter iteration no: ' no
while [ $no -gt 0 ]; do
  echo iteration - $no
  no=$(($no-1))
done

for component in frontend catalogue monogdb ; do
  echo   Component - $component
done