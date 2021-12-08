#!/bin/bash

# Printing in shell can be done by using echo command

# Syntax : echo INPUT MESSAGE

echo Hello
echo Hello World

## Example from project
echo Installing Nginx
echo Starting Nginx Service

## We can print text in colors
# Syntax : echo -e "\e[COLmMESSSAGE\e[0m"

## -e - TO enable \e
## \e[ - To enable colors
## COL - Color Code
## m - End of syntax
## 0 - TO disable color
## All the above things should be quoted, either single or double quotes. But prefarably double quotes.

## Color Codes
# Red       31
# Green     32
# Yellow    33
# Blue      34
# Magenta   35
# Cyan      36


echo -e "\e[31mHello In Red Color\e[0m"
echo -e "\e[32mHello In Green Color\e[0m"
echo -e "\e[33mHello In Yellow Color\e[0m"
echo -e "\e[34mHello In Blue Color\e[0m"
echo -e "\e[35mHello In Magenta Color\e[0m"
echo -e "\e[36mHello In Cyan Color\e[0m"

# Reference : https://misc.flogisoft.com/bash/tip_colors_and_formatting

echo -e "\e[31mNormal Red\e[1;31mBold Red\e[0m"

#1--Bold
#2--lite
#3--Italic
#4--Underline
#5--Blink



