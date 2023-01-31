# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

ENABLE_TVIM=1

START() {
  BEFORE_ALL

  if [ $ENABLE_TVIM -eq "1" ]; then
    if [ -z $NVIM ]; then
      BEFORE_NVIM
      nvim +':lua StartTerm(1, 1)' && exit || exit
    elif then
      AFTER_NVIM
    fi
  else
    AFTER_NVIM
  fi
}

BEFORE_NVIM() {
  VENVS
}

AFTER_NVIM() {
  alias vim=~/u/bin/vim

  ZINIT
  ZINIT_PLUGINS
  THEME
}

BEFORE_ALL() {
  PATH
  PROFILE
}

PATH() {
  export PATH=$PATH:/bin
  export PATH=$PATH:/sbin
  export PATH=$PATH:/usr/bin
  export PATH=$PATH:/usr/local/bin
  export PATH=$PATH:/usr/sbin

  export PATH=$PATH:$HOME/u/bin/
}

PROFILE() {
  export LANG=en_US.UTF-8
  export EDITOR='nvr --remote-tab'
  set -o vi
  source ~/.profile
  source ~/.aliases
}

VENVS() {
  CONDA
  # eval "$(rbenv init - zsh)"
  # eval "$(nodenv init -)"
}


CONDA() {
  export PATH=$PATH:/home/deck/.anaconda3/bin/
  # >>> conda initialize >>>
  # !! Contents within this block are managed by 'conda init' !!
  __conda_setup="$('/home/deck/.anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
  if [ $? -eq 0 ]; then
      eval "$__conda_setup"
  else
      if [ -f "/home/deck/.anaconda3/etc/profile.d/conda.sh" ]; then
          . "/home/deck/.anaconda3/etc/profile.d/conda.sh"
      else
          export PATH="/home/deck/.anaconda3/bin:$PATH"
      fi
  fi
  unset __conda_setup
  # <<< conda initialize <<<
}

THEME() {
  # To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
  [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
  zinit load romkatv/powerlevel10k
}

ZINIT_PLUGINS(){
  zinit load zdharma-continuum/history-search-multi-word
  zinit light zsh-users/zsh-completions
  zinit light zdharma-continuum/fast-syntax-highlighting

  # zdharma-continuum/history-search-multi-word
  zstyle ":history-search-multi-word" page-size "11"
  zinit ice wait"1" lucid
  zinit load zdharma-continuum/history-search-multi-word

  # zsh-autosuggestions
  zinit light zsh-users/zsh-autosuggestions
  bindkey '^g' autosuggest-execute
  bindkey '^n' autosuggest-accept
  bindkey '^o' autosuggest-fetch
  bindkey '^e' autosuggest-clear

  autoload compinit
  compinit
}

ZINIT() {
  ### Added by Zinit's installer
  if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
      print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continu
  um/zinit%F{220})…%f"
      command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
      command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
          print -P "%F{33} %F{34}Installation successful.%f%b" || \
          print -P "%F{160} The clone has failed.%f%b"
  fi

  source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
  autoload -Uz _zinit
  (( ${+_comps} )) && _comps[zinit]=_zinit

  # Load a few important annexes, without Turbo
  # (this is currently required for annexes)
  zinit light-mode for \
      zdharma-continuum/zinit-annex-as-monitor \
      zdharma-continuum/zinit-annex-bin-gem-node \
      zdharma-continuum/zinit-annex-patch-dl \
      zdharma-continuum/zinit-annex-rust
  ### End of Zinit's installer chunk
}

START
