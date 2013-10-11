#!/bin/bash
# homebase.sh
# TODO:
# Make the password field invisible

function login () {
	echo "Build a new project using another repo as a base app!"
	echo -n "Name your new project: " 
	read -e PROJECT 
	echo -n "Git username: " 
	read -e NAME 
	echo -e "Password: " 
	unset password
	while IFS= read -r -s -n1 pass; do
	  if [[ -z $pass ]]; then
	     echo
	     break
	  else
	     echo -n '*'
	     password+=$pass
	  fi
	done
	echo "Which repo do you want to depend on?"
	echo "example: stevefloat/freshstart.git"
	echo -n "Enter user/repo: "
	read -e REPO
	check
}
function check () {
	echo "---------------------------------------"
	echo "Project name:" $PROJECT 
	echo "Git Username:" $NAME 
	echo "Base Repo: http://github.com/"$REPO
	echo -e "Is this right? (Y/n)"
	read YUP
	if [ "$YUP" == "Y" ]; then
	    echo -e $YUP
	    echo "Wonderful!"
	    echo "Setting up project..."
	    setup
	else
		echo "---------------------------------------"
		echo "Make sure your id_rsa file is in your ~/.ssh folder."
		echo "Make sure your ~/.ssh/config file is set up for git like so:"
		echo "    Host github.com"
		echo "    	User git"
		echo "	IdentityFile ~/.ssh/id_rsa"
		echo "---------------------------------------"
	    login
	fi
}
function setup () {
	echo "making new repo on Github...."
	curl -u ''$NAME':'$password'' https://api.github.com/user/repos -d '{"name":"'$PROJECT'"}'
	cd ~/git
	echo "SETUP=============="
	ls .
	echo "======SETUP========"
	git init $PROJECT
	cd $PROJECT
	touch SETUP
	echo "===========SETUP==="
	ls -ah .
	echo "==================="
	git remote add origin ssh://git@github.com/$NAME/$PROJECT.git
	git remote add base https://github.com/$REPO
	git config --global core.mergeoptions --no-edit
	git add .
	git commit -a -m "setup"
	git pull --no-edit base master;
	cd ~/git/$PROJECT;
	echo "==================="
	echo "in: "$PWD
	ls .
	echo "=================OK!"
	echo "Successfully pulled " $REPO "."
	git push origin master
	echo "You now got a new project called " $PROJECT
	echo "Which uses " $REPO "as it's homebase"
	opendirr
}
function opendirr () {
	cd ~/git/$PROJECT;
	{ echo $PROJECT; echo "======="; echo "A new app, using **"$REPO"** as a base"; } > README.md
	git commit -a -m "README.md"
	git push origin master
	echo "run: cd" $PWD
}
login