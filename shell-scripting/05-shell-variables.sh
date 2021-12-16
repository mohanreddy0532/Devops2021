#!/bin/bash

# $0 is nothing but the script name
echo ${0}

# $1 is the first input/argument
echo ${1}

# $2 is the second argument
echo ${2}

# $* & #@ to get all the inputs
echo ${*}
echo ${@}

# $# is the number of inputs been parsed
echo ${#}