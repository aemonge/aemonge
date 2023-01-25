ENABLE_LVIM=1
# https://github.com/nodenv/nodenv-aliases
# https://github.com/tpope/rbenv-aliases

PATH() {
  export PATH=$PATH:/bin
  export PATH=$PATH:/opt/homebrew/bin
  export PATH=$PATH:/opt/homebrew/sbin
  export PATH=$PATH:/sbin
  export PATH=$PATH:/usr/bin
  export PATH=$PATH:/usr/local/bin
  export PATH=$PATH:/usr/local/opt/coreutils/libexec/gnubin
  export PATH=$PATH:/usr/sbin
  export PATH=$PATH:$HOME/.local/bin
  export PATH=$PATH:$HOME/.zplug/bin
  export PATH=$PATH:$HOME/aemonge/bin/
  export PATH=$PATH:$HOME/usr/scripts/bin/
  export PATH=$PATH:$HOME/.npm-global/bin/
}

PROFILE() {
  export LANG=en_US.UTF-8
  export EDITOR='nvr --remote-tab'
  set -o vi
  source ~/.profile
  source ~/.aliases
}

CONDA() {
  # >>> conda initialize >>>
  # !! Contents within this block are managed by 'conda init' !!
  __conda_setup="$('/usr/local/Caskroom/miniconda/base/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
  if [ $? -eq 0 ]; then
      eval "$__conda_setup"
  else
      if [ -f "/usr/local/Caskroom/miniconda/base/etc/profile.d/conda.sh" ]; then
          . "/usr/local/Caskroom/miniconda/base/etc/profile.d/conda.sh"
      else
          export PATH="/usr/local/Caskroom/miniconda/base/bin:$PATH"
      fi
  fi
  unset __conda_setup
  # <<< conda initialize <<<
}

TERRAFORM() {
  autoload -U +X bashcompinit && bashcompinit
  complete -o nospace -C /opt/homebrew/bin/terraform terraform
}

MORPHO() {
  zstyle ":morpho" screen-saver "cmatrix" # select screen saver "zmorpho"; available: zmorpho, zmandelbrot, zblank, pmorpho
  zstyle ":morpho" arguments "-ba"        # arguments given to screen saver program; -s - every key press ends
  zstyle ":morpho" delay "900"            # 15 minutes before screen saver starts
  zstyle ":morpho" check-interval "120"   # check every 2 minutes if to run screen saver
}

PLUGINS_FISH() {
  # zplug "zsh-users/autosuggestions"
  source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh

  bindkey '^g' autosuggest-execute
  bindkey '^n' forward-word
}

PLUGINS() {
  CASE_INSENSITIVE="true"

  # Essential
  zplug "zplug/zplug"
  zplug "johnhamelink/env-zsh"
  zplug "bobsoppe/zsh-ssh-agent"
  zplug "srijanshetty/zsh-pip-completion"
  zplug "zsh-users/zsh-completions"
  zplug "zsh-users/zsh-syntax-highlighting"
  zplug "felipec/git-completion"

  # Dev
  # zplug "conda-incubator/conda-zsh-completion"
  # zplug "asuran/zsh-docker-machine"
  # zplug "eastokes/aws-plugin-zsh"
  # zplug "rawkode/zsh-docker-run"
  # zplug "sroze/docker-compose-zsh-plugin"
  # zplug "webyneter/docker-aliases"
  # zplug "dim-an/cod"
  # zplug "iloginow/zsh-paci"
  # zplug "lukechilds/zsh-better-npm-completion", defer:2
  # zplug "plugins/dirhistory", from:oh-my-zsh
  # zplug "plugins/history", from:oh-my-zsh
  # zplug "reegnz/jq-zsh-plugin"

  # zplug "bobthecow/git-flow-completion"
  # zplug "plugins/pip", from:oh-my-zsh
  # zplug "z-shell/zsh-morpho"
  # zplug "plugins/archlinux", from:oh-my-zsh

  # Slow plugins
  # zplug "MenkeTechnologies/zsh-more-completions"      # Super Slow
  # zplug "tymm/zsh-directory-history"
  # zplug "johnhamelink/rvm-zsh"

  # Wrong Expectations
  # zplug "MenkeTechnologies/zsh-expand"

  # FZF
  # [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

  # Theme
  export AGNOSTER_THEME_TINY=1
  export DEFAULT_USER="aemonge" # don't display my user name, unless I change it
  zplug "aemonge/agnoster-zsh-theme", as:theme

  # Install plugins if there are plugins that have not been installed
  # zplug clean && zplug clear
  if ! zplug check --verbose; then
      printf "Install? [y/N]: "
      if read -q; then
          echo; zplug install
      fi
  fi

  # rbenv ctags SEE: https://github.com/tpope/rbenv-ctags, https://github.com/rbenv/rbenv-default-gems

  # heroku autocomplete setup
  # HEROKU_AC_ZSH_SETUP_PATH=/Users/aemonge/Library/Caches/heroku/autocomplete/zsh_setup && test -f $HEROKU_AC_ZSH_SETUP_PATH && source $HEROKU_AC_ZSH_SETUP_PATH;

  # Then, source plugins and add commands to $PATH
  zplug load
}

ZPLUG(){
  export ZPLUG_HOME=/usr/local/opt/zplug
  source $ZPLUG_HOME/init.zsh
  PLUGINS
  PLUGINS_FISH
}

VENVS() {
  CONDA
  if [ -e ~/.env ]; then
    source ~/.env;
  fi
  # eval "$(rbenv init - zsh)"
  # eval "$(nodenv init -)"
}

BEFORE_ALL() {
  PATH
  PROFILE
  VENVS
}

BEFORE_NVIM() {
}

AFTER_NVIM() {
  alias vim=~/aemonge/bin/vim
  ZPLUG
}

VIM_MUX() {
  BEFORE_ALL

  if [ $ENABLE_LVIM -eq "1" ]; then
    if [ -z $NVIM ]; then
      BEFORE_NVIM
      lvim +':lua StartTerm(1, 1)' && exit # || exit
    elif then
      AFTER_NVIM
    fi
  else
    ZPLUG
  fi
}

VIM_MUX
