#!/usr/bin/python3
# shows the git status for repositries in specified directory default is cwd
# for a given recursion depth, there is a hard coded recursion depth
#
# Also shows the relevancy of local commit for every git branch w.r.t to remote
#
# Sypnosis
# options are listed in the if else block below
# ./gitstatus.py [<options [<arguments>]] [<directory>]


# imports
import os
import os.path as osp
import subprocess
import sys


# params
_maxmaxdepth = 1000


# rev func
def _gitstatus_func(wd, checklagboo):
    printstr = f'--- git status for {wd} ---'
    borderstr = '*' * len(printstr)
    print(borderstr)
    print(f'--- git status for {wd} ---')
    print(borderstr)
    if checklagboo:
        os.system('git remote update')

        # performs a branch relevance check with updated remote
        comstr = '''
        git for-each-ref --format="%(refname:short) %(upstream:short)" refs/heads | \
        while read local remote
        do
            [ -z "$remote" ] && continue
            git rev-list --left-right ${local}...${remote} -- 2>/dev/null \
                >/tmp/git_upstream_status_delta || continue
            LEFT_AHEAD=$(grep -c '^<' /tmp/git_upstream_status_delta)
            RIGHT_AHEAD=$(grep -c '^>' /tmp/git_upstream_status_delta)
            echo "$local (ahead $LEFT_AHEAD) | (behind $RIGHT_AHEAD) $remote"
            rm /tmp/git_upstream_status_delta
        done
        '''
    else:
        comstr = 'git status'
    os.system(comstr)

    print('\n')


# defining recursive main func
def main(wd, counter, maxdepth, checklagboo):
    for f in list(map(osp.abspath, os.listdir(wd))):

        # only cd into the file if it is a directory, and not the .git file
        if osp.isdir(f) and ('.git' not in f):
            os.chdir(f)

            # only run 'git status' if directory is a repo
            if '.git' in os.listdir(f):
                _gitstatus_func(f, checklagboo)

            if counter < maxdepth:
                if counter == _maxmaxdepth:
                    print(f'maximum recursion depth {_maxmaxdepth} reached')
                else:
                    main(f, counter + 1, maxdepth, checklagboo)


# running
if __name__ == '__main__':

    maxdepth = _maxmaxdepth
    checklagboo = False

    # parsing arguments
    wd = os.getcwd()
    if len(sys.argv) > 1:
        revarg_l = sys.argv[1:]
        while revarg_l:
            arg = revarg_l.pop(0)

            if arg in ['-n', '--number']:
                try:
                    maxdepth = int(revarg_l.pop(0))
                    print(f'setting max recursion depth: {maxdepth}')
                except IndexError:
                    raise ValueError('missing "integer depth" for flag -n')
                except ValueError:
                    raise ValueError('"integer depth" for flag -n should be a number')
                
            elif arg in ['-c', '--check-update']:
                checklagboo = True
                print('will perform status check of all branches')
                
            elif arg[0] == '-':
                raise ValueError(f'unknown flag: {arg}')
            
            else:
                wd = osp.abspath(arg)

                
    print(f'begin recursive "git status" from {wd}\n')
    if '.git' in os.listdir(wd):
        _gitstatus_func(wd, checklagboo)
    if maxdepth > 1:            # starting recursion function
        main(wd, 1, maxdepth, checklagboo)
