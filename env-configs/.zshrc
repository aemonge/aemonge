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
  export PATH=$PATH:$HOME/bin/
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

# SEE: [virtualenvs-for-all](https://jsatt.com/blog/virtualenvs-for-all/) and [conda](https://anaconda.org/search?q=nodejs)
CONDA() {
  # >>> conda initialize >>>
  # !! Contents within this block are managed by 'conda init' !!
  __conda_setup="$('/opt/homebrew/Caskroom/miniconda/base/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
  if [ $? -eq 0 ]; then
      eval "$__conda_setup"
  else
      if [ -f "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh" ]; then
          . "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh"
      else
          export PATH="/opt/homebrew/Caskroom/miniconda/base/bin:$PATH"
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
  # Fish-like fast/unobtrusive autosuggestions for ZSH.
  # zplug "zsh-users/autosuggestions"
  # git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh-autosuggestions
  source ~/.zsh-autosuggestions/zsh-autosuggestions.zsh
  bindkey '^g' autosuggest-execute
  bindkey '^n' forward-word
  # export ZVM_LINE_INIT_MODE=$ZVM_MODE_NORMAL
  ZSH_AUTOSUGGEST_STRATEGY=(history completion)
}

PLUGINS() {
  CASE_INSENSITIVE="true"
  source ~/.zplug/init.zsh

  zplug "asuran/zsh-docker-machine"
  zplug "bobsoppe/zsh-ssh-agent"
  zplug "conda-incubator/conda-zsh-completion"
  zplug "dim-an/cod"
  zplug "eastokes/aws-plugin-zsh"
  zplug "iloginow/zsh-paci"
  zplug "johnhamelink/env-zsh"
  zplug "lukechilds/zsh-better-npm-completion", defer:2
  zplug "plugins/dirhistory", from:oh-my-zsh
  zplug "plugins/history", from:oh-my-zsh
  zplug "rawkode/zsh-docker-run"
  zplug "reegnz/jq-zsh-plugin"
  zplug "srijanshetty/zsh-pip-completion"
  zplug "sroze/docker-compose-zsh-plugin"
  zplug "webyneter/docker-aliases"
  zplug "zplug/zplug"
  zplug "zsh-users/zsh-completions"
  zplug "zsh-users/zsh-syntax-highlighting"
  zplug "felipec/git-completion"
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
  [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

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
  HEROKU_AC_ZSH_SETUP_PATH=/Users/aemonge/Library/Caches/heroku/autocomplete/zsh_setup && test -f $HEROKU_AC_ZSH_SETUP_PATH && source $HEROKU_AC_ZSH_SETUP_PATH;

  # Then, source plugins and add commands to $PATH
  zplug load
}

SET_OPTS() {
  # # setopt no_complete_aliases
  # [[ -r "/opt/homebrew/etc/profile.d/bash_completion.sh" ]] && . "/opt/homebrew/etc/profile.d/bash_completion.sh"
  # autoload -U compinit && compinit
  # unsetopt complete_aliases
  # setopt no_complete_aliases
  # compdef _git bstack=git-checkout # BUG: This isn't working yet.
  # compdef git bstack push=git-checkout
  # compdef git bstack pop=git-checkout
}

ZPLUG(){
  PLUGINS
  PLUGINS_FISH
  SET_OPTS
  # MORPHO
  # TERRAFORM
}

BEFORE_ALL() {
  PATH
  PROFILE

  CONDA # Conda manages my ~Ruby~, Python and NodeJS interpreters
  eval "$(rbenv init - zsh)"
  eval "$(nodenv init -)"

  if [ $ENABLE_LVIM = 1 ]; then
    if [ -e ~/.env ]; then
      source ~/.env;
    fi
  fi
}

BEFORE_NVIM() {
  if [ -e ~/.env ]; then
    source ~/.env;
  fi
}

AFTER_NVIM() {
  alias vim=~/bin/vim
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
