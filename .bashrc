# anyenv
eval "$(anyenv init -)"
export PATH=$HOME/.anyenv/bin:$PATH
# exec $SHELL -l

# coreutils ex tac
export PATH=$PATH:/usr/local/opt.coreutils/libexec/gnubin

# bash
set ignoreeof=100

# nodebrew
#export PATH=$HOME/.nodebrew/current/bin:$PATH
#export NODEBREW_ROOT=/usr/local/var/nodebrew
#export PATH=/usr/local/var/nodebrew/current/bin:$PATH

# aws 
# export AWS_PROFILE=jtcf

# custom command
export PATH=$HOME/.bin:$PATH

# java
export JAVA_HOME=`/usr/libexec/java_home -v "17"`
export PATH=${JAVA_HOME}/bin:${PATH}

# 一旦
# sudo ln -sfn /opt/homebrew/opt/openjdk@11/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk-11.jdkqq
# export PATH="/opt/homebrew/opt/openjdk@11/bin:$PATH"

# go
export GOPATH=${HOME}/go
export PATH=$GOPATH/bin:$PATH

# flutter
export PATH="$PATH:/Users/ymitsugi/work/study/flutter/flutter/bin"

# sbt
alias sbc='sbt clean copyResources compile'
alias sbrun='sbt -Dconfig.file=conf/application-local.conf ~run -jvm-debug 5005'
alias sbrun-no='sbt -Dconfig.file=conf/application-local.conf ~run'

# docker
alias dcu='docker-compose up -d'


# command alias
## ls
alias ll='ls -laG'
alias ls='ls -G'

## cd
alias ..='cd ..'

## test
alias g='cd $(ghq list -p | fzf)'

# vim
export PATH="$PATH:/usr/local/Cellar/vim/8.1.2100/bin"

# bashhistory
export HISTSIZE=50000
export HISTIGNORE='history:pwd:ls:ls *:ll'
export HISTCONTROL=ignoreboth #空白、重複履歴を保存しない
export HISTTIMEFORMAT='%F %T '
export HISTCONTROL=ignoredups

export PROMPT_COMMAND="history -a; history -c; history -r;"
## 重複コマンドを履歴に保存しないようにする
shopt -u histappend

# 複数行のコマンドのすべての行を同じ履歴エントリに保存する。
# shopt -s cmdhist
# shopt -s cmdhist shopt -s lithist HISTTIMEFORMAT='%F %T '

bind '"\C-n": history-search-forward'
bind '"\C-p": history-search-backward'

# bash prompt
source /Library/Developer/CommandLineTools/usr/share/git-core/git-prompt.sh
source /Library/Developer/CommandLineTools/usr/share/git-core/git-completion.bash
GIT_PS1_SHOWDIRTYSTATE=true
export PS1='\[\033[32m\]\u@\[\033[00m\]:\[\033[36m\]\w\[\033[31m\]$(__git_ps1)\[\033[00m\]\n\$ '

# curl alias

# brew
eval $(/opt/homebrew/bin/brew shellenv)

# sed
alias sed='gsed'

# Add Visual Studio Code (code)
# export PATH="$PATH:/usr/local/bin/code"

# graphoviz
export PATH="$PATH:/opt/homebrew/bin/dot"
[ -f "/Users/ymitsugi/.ghcup/env" ] && source "/Users/ymitsugi/.ghcup/env" # ghcup-env

# aws completer
complete -C '/opt/homebrew/bin/aws_completer' aws
