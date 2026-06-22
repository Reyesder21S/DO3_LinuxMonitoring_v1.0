#!/bin/bash

source script.sh

if [ $# -ne 1 ]; then
   echo "1 text parameter is required"
   exit 1
fi

parameter "$1"

if [ $? -ne 0 ]; then
   exit 1
fi