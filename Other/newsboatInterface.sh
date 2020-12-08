#!/bin/bash

[[ -z $(grep "youtube" $1) ]] && echo "This is a youtube link"
