[ -e /tmp/.failsafe ] && export FAILSAFE=1

[ -f /etc/banner ] && cat /etc/banner
[ -n "$FAILSAFE" ] && cat /etc/banner.failsafe

grep -Fsq '/ overlay ro,' /proc/mounts && {
	echo 'Your JFFS2-partition seems full and overlayfs is mounted read-only.'
	echo 'Please try to remove files from /overlay/upper/... and reboot!'
}

export PATH="%PATH%"
export HOME=$(grep -e "^${USER:-root}:" /etc/passwd | cut -d ":" -f 6)
export HOME=${HOME:-/root}
#export PS1='\u@\h:\w\$ '
export ENV=/etc/shinit

alias date='date +"%Y-%m-%d %A %H:%M:%S"'

PS1='\[\e[33;40m\][\u@\h \W]\$: \[\e[m\]'

case "$TERM" in
	xterm*|rxvt*)
		export PS1='\[\e]0;\u@\h: \w\a\]'$PS1
		;;
esac

[ -x /bin/more ] || alias more='less'
[ -x /usr/bin/vim ] && alias vi='vim' || alias vim='vi'

alias l='ls -lF'
alias la='ls -a'
#alias ll='ls -alhF'
alias ls='ls --color=auto'

[ -z "$KSH_VERSION" -o \! -s /etc/mkshrc ] || . /etc/mkshrc

[ -x /usr/bin/arp -o -x /sbin/arp ] || arp() { cat /proc/net/arp; }
[ -x /usr/bin/ldd ] || ldd() { LD_TRACE_LOADED_OBJECTS=1 $*; }

[ -n "$FAILSAFE" ] || {
	for FILE in /etc/profile.d/*.sh; do
		[ -e "$FILE" ] && . "$FILE"
	done
	unset FILE
}

if ( grep -qs '^root::' /etc/shadow && \
     [ -z "$FAILSAFE" ] )
then
cat << EOF
=== WARNING! =====================================
There is no root password defined on this device!
Use the "passwd" command to set up a new password
in order to prevent unauthorized SSH logins.
--------------------------------------------------
EOF
fi

alias ll='ls -alhF'
