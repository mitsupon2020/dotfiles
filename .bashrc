# anyenv
eval "$(anyenv init -)"
export PATH="$PATH:$HOME/.anyenv/bin"
# exec $SHELL -l
#
#
#
#
#

# volta install shell実行でbash_profile,bashrcに自動設定されていたパスを移動
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

# 指定したディレクトリ以下のファイルやディレクトリをfzfで検索し、選択した結果をコマンドに渡す関数
# 使用例: ff /path/to/search "code"  # 選択したファイルやディレクトリをVS Codeで開く
#


gg() {
  local search_dir=$1
  local command=$2
  local selection

  if [[ -z "$search_dir" ]] || [[ ! -d "$search_dir" ]]; then
    echo "Invalid or unspecified directory: $search_dir"
    return 1
  fi

  selection=$(find "$search_dir" -print 2>/dev/null | fzf \
    --preview 'if [ -d {} ]; then ls -1 {} | head -100; else bat --style=numbers --color=always {} | head -100; fi' \
    --preview-window=right:50%:wrap \
    --bind 'ctrl-v:preview-half-page-down' \
    --bind 'alt-v:preview-half-page-up')

  if [[ -n "$selection" ]]; then
    if [[ -n "$command" ]]; then
      $command "$selection"
    else
      echo "Selected: $selection"
    fi
  else
    echo "No selection made."
  fi
}


gcode() {
  local dir="${HOME}/work" # ~/work から探索を開始
  local stack=("$dir") selected

  while true; do
    selected=$(find "$dir" -maxdepth 4 -type d -print 2> /dev/null | fzf --bind="ctrl-f:reload(find \"$dir\" -mindepth 1 -type d -print 2> /dev/null)" --bind="ctrl-b:execute(echo ${stack[@]: -2:1})+abort" +m --preview='tree -C {} | head -n 10' --preview-window=right:50%:hidden --expect=enter,ctrl-f,ctrl-b)
    local status=$?
    key=$(head -1 <<< "$selected")

    if [ $status -ne 0 ]; then
      # fzfがCtrl-Cで中断された場合、ループから抜ける
      break
    fi

    dir=$(sed '1d' <<< "$selected")

    case "$key" in
      enter)
        if [ -n "$dir" ]; then
          code "$dir" # 選択したディレクトリをVS Codeで開く
          break # VS Codeで開いた後、ループを抜ける
        fi
        ;;
      ctrl-f)
        if [ -n "$dir" ]; then
          cd "$dir"
          dir=$PWD
          stack+=("$dir") # 現在のディレクトリをスタックに追加
        fi
        ;;
      ctrl-b)
        if [ ${#stack[@]} -gt 1 ]; then
          stack=("${stack[@]::${#stack[@]}-1}") # スタックから最後の要素を削除
          dir=${stack[@]: -1:1} # スタックの最後の要素を現在のディレクトリとする
          cd "$dir"
        else
          dir="${HOME}/work" # スタックが1つの場合、~/work にリセット
          cd "$dir"
        fi
        ;;
    esac
  done
}


gd() {
  local dir="${HOME}/work" # ~/work から探索を開始
  local stack=("$dir") selected

  while true; do
    selected=$(find "$dir" -maxdepth 3 -type d -print 2> /dev/null | fzf --bind="ctrl-f:reload(find \"$dir\" -mindepth 1 -type d -print 2> /dev/null)" --bind="ctrl-b:execute(echo ${stack[@]: -2:1})+abort" +m --preview='tree -C {} | head -n 10' --preview-window=right:50%:hidden --expect=enter,ctrl-f,ctrl-b)
    local status=$? # fzfの終了ステータスを取得
    key=$(head -1 <<< "$selected")

    if [ $status -ne 0 ]; then
      # fzfがCtrl-Cで中断された場合、ループから抜ける
      break
    fi

    dir=$(sed '1d' <<< "$selected")

    case "$key" in
      enter)
        if [ -n "$dir" ]; then
          cd "$dir"
          stack=("$HOME/work" "$dir") # スタックをリセットして現在のディレクトリを追加
          break
        fi
        ;;
      ctrl-f)
        if [ -n "$dir" ]; then
          cd "$dir"
          dir=$PWD
          stack+=("$dir") # 現在のディレクトリをスタックに追加
        fi
        ;;
      ctrl-b)
        if [ ${#stack[@]} -gt 1 ]; then
          stack=("${stack[@]::${#stack[@]}-1}") # スタックから最後の要素を削除
          dir=${stack[@]: -1:1} # スタックの最後の要素を現在のディレクトリとする
          cd "$dir"
        else
          dir="${HOME}/work" # スタックが1つの場合、~/work にリセット
          cd "$dir"
        fi
        ;;
    esac
  done
}

fzf_git_blame() {
  # fzfでファイルを選択
  local file=$(git ls-files | fzf --height 40% --border --preview 'git blame {}')

  # 選択されたファイルに対してgit blameを実行
  if [ -n "$file" ]; then
    git blame "$file"
  fi
}


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
# export GOPATH=${HOME}/go
# export PATH=$GOPATH/bin:$PATH

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
[[ -r "/opt/homebrew/etc/bash_completion.d/git-prompt.sh" ]] && . "/opt/homebrew/etc/bash_completion.d/git-prompt.sh"
[[ -r "/opt/homebrew/etc/bash_completion.d/git-completion.bash" ]] && . "/opt/homebrew/etc/bash_completion.d/git-completion.bash"
#source /Library/Developer/CommandLineTools/usr/share/git-core/git-prompt.sh
#source /Library/Developer/CommandLineTools/usr/share/git-core/git-completion.bash
GIT_PS1_SHOWDIRTYSTATE=true
export PS1='\[\033[32m\]\u@\[\033[00m\]:\[\033[36m\]\w\[\033[31m\]$(__git_ps1)\[\033[00m\]\n\$ '

# curl alias

# brew
eval $(/opt/homebrew/bin/brew shellenv)

# sed
alias sed='gsed'
export PATH="/opt/homebrew/opt/gnu-sed/libexec/gnubin:$PATH"

# Add Visual Studio Code (code)
# export PATH="$PATH:/usr/local/bin/code"

# graphoviz
export PATH="$PATH:/opt/homebrew/bin/dot"
[ -f "/Users/ymitsugi/.ghcup/env" ] && source "/Users/ymitsugi/.ghcup/env" # ghcup-env

# aws completer
complete -C '/opt/homebrew/bin/aws_completer' aws

# emacs
alias e="emacs -nw"

# alias
export PATH="$PATH:/usr/local/bin/"

# git
alias gpush="git push origin HEAD"

. "$HOME/.cargo/env"

# latex
export PATH="$PATH:/usr/local/texlive/2023/bin/universal-darwin/"

# multipass
export PATH="$PATH:/Users/ymitsugi/Library/Application Support/multipass/bin"
