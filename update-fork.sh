#!/bin/bash


# FORK NAME: origin
# UPSTREAM NAME: upstream

remote=upstream
for brname in `git branch -r | grep upstream | grep -v master | grep -v HEAD | sed -e 's/.*\///g'`; do
    git branch --track $brname  $remote/$brname ; 
done

git pull --rebase --all

git push --all origin
git push --tags origin
