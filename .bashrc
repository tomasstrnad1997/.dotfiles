ex=$?
# If not running interactively, don't do anything
[[ $- != *i* ]] && return
PS1='[\u@\h \W]\$ '
git_branch()
{
    branch=`git rev-parse --abbrev-ref HEAD 2>/dev/null`
    if [[ -n "${branch}" ]]; then
        echo "($branch)"
    else
        echo ""
    fi
}
git_color() {
    branch=`git rev-parse --abbrev-ref HEAD 2>/dev/null`
    status=`git status 2> /dev/null`
    color='38;5;20'
    if [[ -n "${branch}" ]]; then
        if [[ "$status" =~ 'Your branch is behind' ]]; then
            color='38;5;230'
        elif [[ "$status" =~ 'Your branch is ahead' ]]; then
             color='38;5;230'
        elif [[ "$status" =~ 'Changes not staged for commit' ]]; then
             color='38;5;226'
        elif [[ "$status" =~ 'Untracked files' ]]; then
             color='38;5;214'
        elif [[ "$status" =~ 'to be committed' ]]; then
             color='38;5;82'
        elif [[ "$status" =~ 'tree clean' ]]; then
             color='38;5;76'
        fi
        echo -e "\033[${color}m" 
        # echo -e "\033[${color}m(${branch})" 
    else
        echo ""
    fi
}
alias ls='ls --color=auto'
alias grep='grep --color=auto'
exit_status()
{
    ex=$?
    if [ $ex -ne 0 ]; then
        echo -e "($ex)"
    else
        echo ""
    fi
}
# PS1='[\u@\h \W]\$ '
# PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[01;32m\] \[\033[00m\]\$ '
PS1='\[\033[0;91m\]$(exit_status)\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w \[$(git_color)\]$(git_branch)\[\033[00m\]\$ '
# PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[01;32m\]$(git_color)$(git_branch)\[\033[00m\]\$ '
if [ -f ~/.bash_aliases ]; then
	. ~/.bash_aliases
fi
