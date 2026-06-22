#!/bin/bash

parameter() {
    param='^[+-]?[0-9]+([.][0-9]+)?$'
    if [[ $1 =~ $param ]]; then
       echo "The parameter must not be a number"
       return 1
    else
       echo "Parameter:$1"   
       return 0
    fi   
}
