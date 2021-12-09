#!/bin/bash

## Conditions are two types

# 1. if command (Mostly used)
# 2. case command (Rarely Used)

# IF COMMAND
# 1. Simple if

#Syntax:
#if [ expression ]; then
#  commands
#fi

# If expression is true then commands will be executed

# 2. If Else

# Syntax:

#if [ expression ]; then
#  commands-1
#else
#  commands-2
#fi

## If expression is true then commands-1 will be executed, if not commands-2 will be executed

# 3. Else If

# Syntax:

#if [ expression-1 ]; then
#  commands-1
#elif [ expression-2 ]; then
#  commands-2
#else
#  commands-else
#fi

# If expression-1 is true then commands-1 will be executed, if not expression-2 is true then commands-2 will be executed. If both the expressions are false then commands-else will be executed.

# Expressions
# 1. Strings
  # Operators : = , ==, !=, -z
  # Ex: [ abc == ABC ]
# 2. Numbers
  # Operators : -eq, -ne, -gt, -ge , -lt , -le
  # ex: [ 1 -eq 0 ]
# 3. Files
  # Operators : -e - to check if file exists or not
        # (somany are there can be referred from documentation when needed)


read -p 'Enter your age: ' age
if [ -z "$age" ]; then
  echo Input Missing
  exit
fi

if [ ! -z "${age}" -a "${age}" -lt 18 ]; then
  echo You are a Minor
elif [ ! -z "${age}" -a "${age}" -gt 60 ]; then
  echo You are a senior citizen
else
  echo You are Major
fi

## Note: When you use variables in expressions of if statement, Always double quote them.

## Expressions can be combined
# [ expression1 expression2]
# LOGICAL AND -a
#  [ expression1 -a expression2 ] -> True if both are true
# LOGICAL OR  -o
#  [ expression1 -o expression2 ] -> True if any expressions is true