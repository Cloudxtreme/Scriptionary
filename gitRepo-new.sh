#!/bin/bash
# Create a new git repo in the arg dir, and create repo on github.
# This is just a basic script, minimal error checks.

yesOrNo(){
    echo $1
    read yn 
    if [ $yn == "yes" ] || [ $yn == "y" ] || [ $yn == "Y" ] || [ $yn == "Yes" ] ; then
        return 0
    elif [ $yn == "no" ] || [ $yn == "n" ] || [ $yn == "N" ] || [ $yn == "No" ] ; then
        return 1
    else
        echo "A valid answer is yes or no."
        yesOrNo "$1"
    fi
}

createGitHubRepo(){
    userName=$1
    repoName=$2
    # no error checking! that's not cool...
    x=$(curl -s -u $userName https://api.github.com/user/repos -d '{"name":"'"$repoName"'"}')
}

addGitHubToRepo(){
    userName=$1
    repoName=$2
    git remote add origin git@github.com:$userName/$repoName.git
}

createGitRepo(){
    if [ -d "$1" ]; then
        cd $1

        # Create git repo and add github as origin
        if ! [ -d ".git" ]; then
            git init -q
        fi
    else
        if yesOrNo 'Project directory does not exist. Should it be created?'; then
            mkdir -p $1
            createGitRepo $1
        else
            echo "No changes were made."
            exit
        fi
    fi
}

if [ $1 ]; then
    createGitRepo $1
    echo 'GitHub Username:'
    read userName
    REPO_NAME=${PWD##*/} 
    createGitHubRepo $userName $REPO_NAME 
    addGitHubToRepo $userName $REPO_NAME 

    # Again no error checks before we make such a bold statment.
    echo ''
    echo 'Git Project locally and on GitHub.'
    echo 'Your ready for adding files, commiting and pushing!'
else
    echo "Please include the projects folder name as argument. This will be used to create the project's folder if it does not exist. The folder name will be used as the GitHub Repo name."
fi

