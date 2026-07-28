#!/bin/bash

set -e

git branch -m temp_branch
git fetch origin main:main
git checkout main
git branch -D temp_branch
