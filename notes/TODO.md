TODO
====

* Still trying to get the synchronizing commits from the base app working properly...

```
git pull --rebase base master
git remote update
# I have no idea what this does >_<
git commit -a -m "updated README.md"
git push origin master
```

Still getting the same error.

>
```
To https://github.com/stevefloat/new-proj
 ! [rejected]        master -> master (non-fast-forward)
error: failed to push some refs to 'https://github.com/stevefloat/new-proj'
hint: Updates were rejected because the tip of your current branch is behind
hint: its remote counterpart. Integrate the remote changes (e.g.
hint: 'git pull ...') before pushing again.
hint: See the 'Note about fast-forwards' in 'git push --help' for details.
```

Errrg.... I think it might be the --rebase command.

**deleting repo & local copy. Lets try again....**


```
curl -u 'stevefloat:PASS' https://api.github.com/user/repos -d '{"name":"new-proj"}'
cd ~/git
git init new-proj
cd new-proj
git remote add origin https://github.com/stevefloat/new-proj
git remote add base https://github.com/stevefloat/freshstart
git config --global core.mergeoptions --no-edit
git add .
git commit -a -m "setup"
git pull base master
git push origin master

```

> No ```--rebase``` this time.

This time, it did work. No prompt, set up everything correctly.

I was able to make a commit to the base app _freshstart_, pull it into the _new-proj_ app, and then push the changes to the new-proj master branch. **SUCCESS**!

The only problem is that I wasn't able to pull the changes from _freshstart_ without getting the damn prompt again.

### Pulling the base app without being prompted to write a merge commit message

I edited the ```.git/config``` file directly to reflect the --no-edit config option.
```
[core]
	repositoryformatversion = 0
	filemode = true
	bare = false
	logallrefupdates = true
	ignorecase = true
	precomposeunicode = false
	mergeoptions = --no-edit
```
For some reason, ```git config --global core.mergeoptions --no-edit``` isn't actually modifying the config file like its supposed to.

After trying another push/pull, I **STILL** got prompted for a commit message when I ```git pull base master```

Finally, I could only get it working using the ```--no-edit``` flag on the git pull. So, like this:
```
git pull --no-edit base master
```

I don't like having to add that flag. I'm going to restart my computer and see if anything changes. She's been through a lot today.

### Asking for username/password on push

I don't like having to type in my username/pass everytime I push. Let's change that. I think I need to use ```git@github.com:stevefloat/new-proj.git``` in order to avoid that. The problem is that my repo is set to push to the ```https://``` address.

It can be changed in the ```.git/config``` file, like so:
```
[remote "origin"]
	git@github.com:stevefloat/new-proj.git
	fetch = +refs/heads/*:refs/remotes/origin/*
```

...which _should_ work. But I want to do this codically (is that a word?)

### Ignoring the default README.md file

When we are pulling new changes from the base app to our new project, it's going to also try to pull the README.md file. This is a problem because our README.md file is always going to be different in our new project, and that's the one we always want to keep. We never actually want the README.md from the base app.

Actually, we're probably going to want to keep most the files that we customize in the new project, even when there's a new version of them in the base app.

Ideally, we could make a list of files to ignore when we are making pull requests to ```git pull base master``` so that we never have an overwrite/merge issue.

Files that should be excluded from pulls:
* README.md
* public/js/main.js
* public/css/style.css
* custom-compiled gumby css files
* app.js

> **NOTE** these files should all be pulled the first time that the base app repo is pulled. They should only be excluded after that, or realisticly, only after they have been edited in the new project.