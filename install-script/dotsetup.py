#import glob
import pathlib
import subprocess
import os

for fileref in pathlib.Path('..').glob('**/*'):
    fileref = str(fileref)
    if 'git' not in fileref and 'install-script' not in fileref and not os.path.isdir(fileref):
        dest = os.path.expanduser('~') + fileref[2:]
        dest_top = os.path.split(dest)[0] +'/'

        if not os.path.exists(dest_top):
            print("Creating path: "+dest_top)
            os.makedirs(dest_top)
        elif os.path.islink(dest):
            print("Removing existing symlink: "+ dest)
            process = subprocess.run(['rm', dest],
                                     stderr=subprocess.PIPE,
                                     stdout=subprocess.PIPE,
                                     universal_newlines=True)
            print(process.stderr, process.stdout)
        elif os.path.isfile(dest):
            print("Backing up existing file: " + dest)
            process = subprocess.run(['mv', dest, dest+'.bak'],
                                     stdout=subprocess.PIPE,
                                     stderr=subprocess.PIPE,
                                     universal_newlines=True)
            print(process.stderr, process.stdout)

        process = subprocess.run(['ln', '-sv', os.path.abspath(fileref), dest],
                                 stdout=subprocess.PIPE,
                                 universal_newlines=True)
        print(process.stdout)




