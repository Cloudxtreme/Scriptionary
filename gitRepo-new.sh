#!/bin/bash

# Create a new git repo in the arg dir, and create repo on github.
# This is just a basic script, minimal error checks.


yesOrNo()
{
    read yn 
    if [ $yn == "yes" ] || [ $yn == "y" ] || [ $yn == "Y" ] || [ $yn == "Yes" ] ; then
        mkdir -p $1
        createGitRepo $1
    elif [ $yn == "no" ] || [ $yn == "n" ] || [ $yn == "N" ] || [ $yn == "No" ] ; then
        echo "No changes were made."
        exit
    else
        echo "A valid answer is yes or no."
        yesOrNo $1
    fi
}

create_repo(){
    echo 'GitHub Username:'
    read username
    # no error checking! that's not cool...
    x=$(curl -s -u $username https://api.github.com/user/repos -d '{"name":"'"$1"'"}')
}

createGitRepo()
{
    if [ -d "$1" ]; then
        cd $1
        REPO_NAME=${PWD##*/} 

        # Create git repo and add github as origin
        if ! [ -d ".git" ]; then
            git init -q
        fi
        git remote add origin git@github.com:billcd/$REPO_NAME.git

        create_repo $REPO_NAME
        
        # Again no error checks before we make such a bold statment.
        echo ''
        echo 'Git Project locally and on GitHub.'
        echo 'Your ready for adding files, commiting and pushing!'
    else
        echo 'Project directory does not exist. Should it be created?'
        yesOrNo $1
    fi
}

if [ $1 ]; then
    createGitRepo $1
else
    echo "Please include the projects folder name as argument. This will be used to create the project's folder if it does not exist. The folder name will be used as the GitHub Repo name."
fi

