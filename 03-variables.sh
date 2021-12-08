#!/bin/bash

## If we assign a name to a set of data is called as Variable

# Syntax: VARNAME=DATA
a=100     # Number
b=apple   # String
c=true    # Boolean

# Shell does not have any data type by default

# Access the variables, Variable will be access in two ways
# 1. $VARNAME , $ preceding to the variable name , Ex: $a to access a variable
# 2. ${VARNAME}, $ preceding along with variable bounded in flower braces, Ex: ${a}

## Best practice is using along with flower  braces.
echo a = $a
echo a in currency = ${a}USD

## Use cases
# 1. If we want to use a value in multiple places then we go with variables. This brings and advantage of changing the value in one place and it implacts in all the places.


DATE=2021-12-08
echo Good Morning, Welcome, Today date is ${DATE}

## 2. Usecase: If we need to get the data dynamically we use variables to store that data and we refer
  # i. Command substitution - VAR=$(command)
  # ii. Arthimetic substitution VAR=$((expression))

DATE=$(date +%F)
echo Good Morning, Welcome, Today date is ${DATE}

ADD=$((2+3))
echo ADD = ${ADD}

## Variable from Shell command line
echo USER = ${USER}
echo A = ${A}