#!/bin/bash
awk '{ sub("\r$", ""); print }' $1
