#!/usr/bin/python3
# shows the git status for repositries in specified directory default is cwd
# for a given recursion depth, there is a hard coded recursion depth
#
# Sypnosis
# ./gitstatus.py [-n] <integer depth> [<directory>]


# imports
import os
import os.path as osp
import subprocess
import sys


# params
_maxmaxdepth = 1000


# rev func
def _gitstatus_func(wd):
    printstr = f'--- git status for {wd} ---'
    borderstr = '*'*len(printstr)
    print(borderstr)
    print(f'--- git status for {wd} ---')
    print(borderstr)
    os.system('git status')
    print('\n')


# defining recursive main func
def main(wd, counter, maxdepth):
    for f in list(map(osp.abspath, os.listdir(wd))):

        # only cd into the file if it is a directory, and not the .git file
        if osp.isdir(f) and ('.git' not in f):
            os.chdir(f)

            # only run 'git status' if directory is a repo
            if '.git' in os.listdir(f):
                _gitstatus_func(f)

            if counter < maxdepth:
                if counter == _maxmaxdepth:
                    print(f'maximum recursion depth {_maxmaxdepth} reached')
                else:
                    main(f, counter + 1, maxdepth)


# running
if __name__ == '__main__':

    maxdepth = _maxmaxdepth

    # parsing arguments
    wd = os.getcwd()
    if len(sys.argv) > 1:
        revarg_l = sys.argv[1:]
        while revarg_l:
            arg = revarg_l.pop(0)

            if arg == '-n':
                try:
                    maxdepth = int(revarg_l.pop(0))
                    print(f'setting max recursion depth: {maxdepth}')
                except IndexError:
                    raise ValueError('missing "integer depth" for flag -n')
                except ValueError:
                    raise ValueError('"integer depth" for flag -n should be a number')
            elif arg[0] == '-':
                raise ValueError(f'unknown flag: {arg}')
            else:
                wd = osp.abspath(arg)

    # running func
    print(f'begin recursive "git status" from {wd}\n')
    if '.git' in os.listdir(wd):
        _gitstatus_func(wd)
    main(wd, 1, maxdepth)
