parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
export PS1='\u@\h \[\033[32m\]\w\[\033[33m\]$(parse_git_branch)\[\033[00m\] $ '

alias submod="git submodule update --init --recursive"
alias retrig='git commit --no-verify --allow-empty -m "Re-Trigger build"'
alias jn="jupyter-notebook"
alias rebase='git fetch upstream; git rebase upstream/master'
alias storage='du -h --max-depth=1'
alias pp='export PYTHONPATH=`pwd`/python; echo PYTHONPATH=$PYTHONPATH'
alias rebase_upstream="git stash; git fetch upstream && git rebase upstream/master; git stash pop"
alias flags='python -c "from mxnet.runtime import Features; print(Features())"'
alias mmx="cd build && cmake -DCMAKE_BUILD_TYPE=Release -GNinja .. && ninja -v && cd .. || cd .."
alias dmmx="cd build && cmake -DCMAKE_BUILD_TYPE=Debug -GNinja .. && ninja -v && cd .. || cd .."
alias cmmx="rm -rf build && mkdir build && mmx"
alias cdmmx="rm -rf build && mkdir build && dmmx"
alias mx_path='python -c "import mxnet as mx; print(mx.__path__)"'
git_squash() {
        if [[ $1 -eq 0 ]] ; then
                echo 'Enter number of commits you want to squash from HEAD(including HEAD)'
                return
        fi
        git add -u
        git ci -m "qertgqerg"
        git rebase -i HEAD~$1
        git fetch upstream
        git rebase upstream/master
}

force_push() {
        BRANCH_NAME=`git rev-parse --abbrev-ref HEAD`
        echo "Force push branch:" $BRANCH_NAME
        git push -f origin $BRANCH_NAME
}

push() {
        BRANCH_NAME=`git rev-parse --abbrev-ref HEAD`
        echo "Push branch:" $BRANCH_NAME
        git push origin $BRANCH_NAME
}

case "$TERM" in
xterm*|rxvt*)
        PROMPT_COMMAND='echo -ne "\033]0;${PWD##*/}\007"'
    show_command_in_title_bar()
    {
        case "$BASH_COMMAND" in
            *\033]0*)
                ;;
            *)
                echo -ne "\033]0;${BASH_COMMAND} - ${PWD##*/}\007"
                ;;
        esac
    }
    trap show_command_in_title_bar DEBUG
    ;;
*)
    ;;
esac

export DGLBACKEND="mxnet"
export PATH="/usr/lib/ccache:$PATH"
#export PATH="~/deps/cmake-3.10.2-Linux-x86_64/bin/:$PATH"
export PYTHONPATH=/home/ubuntu/workspace/incubator-mxnet/python/
