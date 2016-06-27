#!/bin/bash
for f in "$@"
do
    SetFile -d "$(GetFileInfo -m "$f")" "$f" 
done