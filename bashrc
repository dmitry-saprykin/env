# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=20000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias phpunit='/monamour/php/bin/php /usr/bin/phpunit'

export PATH=/monamour/php/bin/:/home/devel/phabricator/arcanist/bin/:$PATH:$HOME/bin:$HOME/local/bin:/opt/usr/local/bin:/opt/qtsdk/qt/bin:/usr/local/flashcam/bin

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

function svnup()
{
	echo 'svn up ~/mamba_trunk;';
	svn up ~/mamba_trunk; 
	echo 'svn up ~/images;';
	svn up ~/images/;
}

function scpwww()
{
	SERVER=$1
	shift

	CURRDIR=`pwd`
	for i in $@
	do
		SHORTPATH=${i#*/images/}
		if [ $i = "$SHORTPATH" ]; then
			echo "cd ~/mamba"
			cd ~/mamba
			echo "scp $i $SERVER:/monamour/www/$i"
			scp $i $SERVER:/monamour/www/$i
		else
			echo "cd ~/images"
			cd ~/images
			echo "scp $SHORTPATH $SERVER:/monamour/ftp/images/$SHORTPATH"
			scp $SHORTPATH $SERVER:/monamour/ftp/images/$SHORTPATH
		fi
	done
	echo "cd $CURRDIR"
	cd $CURRDIR
}

for i in 1 2 3 5 10 12 14 15
do
	alias scpwww$i="scpwww www$i"
done

function pushwww() {
    for i in $(git diff --name-only)
    do
        scpwww $1 $i
    done
}

alias phpcs="/monamour/composer/vendor/squizlabs/php_codesniffer/scripts/phpcs"
alias mgrep2="/home/devel/python/mgrep/mgrep.py"
alias mgrep="/home/devel/qt/mgrep-build-desktop/mgrep --exclude='.git,.svn,.swp,.swo,photos,.idea'"
alias br="/usr/bin/git branch"
alias co="/usr/bin/git checkout"
alias st="/usr/bin/git status"

export LANG=ru_RU.UTF-8
export LANGUAGE=en_UK.UTF-8
export LC_ALL=ru_RU.UTF-8

if [ -f "${HOME}/.gpg-agent-info" ]; then
	. "${HOME}/.gpg-agent-info"
	export GPG_AGENT_INFO
	export SSH_AUTH_SOCK
	export SSH_AGENT_PID
fi

GPG_TTY=$(tty)
export GPG_TTY
export GPGKEY=15BEC135
DEBEMAIL="saprykin.dmitry@gmail.com"
DEBFULLNAME="Дмитрий Сапрыкин"
export DEBEMAIL
export DEBFULLNAME

alias dquilt="quilt --quiltrc=${HOME}/.quiltrc-dpkg"

export JAVA_HOME="/opt/java"
