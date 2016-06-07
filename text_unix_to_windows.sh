#!/bin/bash
awk 'sub("$", "\r")' $1
