#!/usr/bin/python
import os
import subprocess
# from pathlib import Path
from datetime import datetime

def linkDotfile(file):
    dest = os.path.expanduser('~') +'/'+ file
    dateStr = datetime.now().strftime("%Y-%m-%d-%H%M")

    if os.path.islink(os.path.expanduser('~') +'/'+ file):
        print("Removing existing symlink: "+ dest)
        process = subprocess.run(['rm', dest],
                                 stderr=subprocess.PIPE,
                                 universal_newlines=True)
        print(process.stderr)
    elif os.path.isfile(dest):
        print("Backing up existing file: " + dest)
        process = subprocess.run(['mv', dest, dest+'-'+dateStr],
                                 stderr=subprocess.PIPE,
                                 universal_newlines=True)
        print(process.stderr)
    elif os.path.isdir(dest):
        print("Backing up existing dir: " + dest)
        process = subprocess.run(['mv', dest, dest+'-'+dateStr],
                                 stderr=subprocess.PIPE,
                                 universal_newlines=True)
        print(process.stderr)

    print("Creating new symlink: " + dest)
    process = subprocess.run(['ln', '-sv', dotfilesDir+'/'+file, dest],
                             stdout=subprocess.PIPE,
                             stderr=subprocess.PIPE,
                             universal_newlines=True)
    print(process.stderr, process.stdout)

dotfilesDir = os.getcwd()
files = ['.aliases',
         '.bash_profile',
         '.bashrc',
         '.gitconfig',
         '.vimrc']

for f in files:
    linkDotfile(f)
