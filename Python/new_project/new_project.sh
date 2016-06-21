#!/bin/bash

createProject(){
	projectName=$1

	mkdir $projectName
	cd $projectName
	git init
	mkdir docs tests $projectName
	touch README.rst requirements.txt .gitignore
	cp ../LICENSE .
	pyvenv env3
	source env3/bin/activate
	pip install --upgrade pip
	
	echo env3 >> .gitignore
	echo *.pyc >> .gitignore
	
	git add -A
	git commit -m"Initial File Touch"
	
	cd ..
	../../Git/gitRepo-new.sh $projectName
	cd $projectName
	git push origin master

}


projectName=$1
if ! [ $1 ]; then
	
	echo "Project Name: "
	read projectName
fi

createProject "$projectName"


