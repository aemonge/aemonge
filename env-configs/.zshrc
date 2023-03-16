ENABLE_TVIM=1

BEFORE(){
  PATH
  PROFILE
}

AFTER(){
}

BEFORE_NVIM(){
  SSH
}

AFTER_NVIM(){
  P10K_ZINIT
  ZINIT_PLUGINS
  THEME
  CONDA
  alias vim=~/u/bin/vim
}

PATH() {
  export PATH=$PATH:/bin
  export PATH=$PATH:/sbin
  export PATH=$PATH:/usr/bin
  export PATH=$PATH:/usr/local/bin
  export PATH=$PATH:/usr/sbin

  export PATH=$PATH:$HOME/u/bin/
  export PATH=$PATH:$HOME/bin/
  export PATH=$PATH:$HOME/.local/bin/
}

PROFILE() {
  export LANG=en_US.UTF-8
  export EDITOR='nvr --remote-tab'
  set -o vi
  source ~/.profile
  source ~/.aliases
}

SSH() {
  eval "$(ssh-agent -s)" > /dev/null
  ssh-add ~/.ssh/git_aemonge > /dev/null
}

CONDA() {
  # >>> conda initialize >>>
  # !! Contents within this block are managed by 'conda init' !!
  __conda_setup="$('/home/deck/.miniconda/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
  if [ $? -eq 0 ]; then
      eval "$__conda_setup"
  else
      if [ -f "/home/deck/.miniconda/etc/profile.d/conda.sh" ]; then
          . "/home/deck/.miniconda/etc/profile.d/conda.sh"
      else
          export PATH="/home/deck/.miniconda/bin:$PATH"
      fi
  fi
  unset __conda_setup
  # <<< conda initialize <<<
}

P10K_ZINIT() {
  # Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
  # Initialization code that may require console input (password prompts, [y/n]
  # confirmations, etc.) must go above this block; everything else may go below.

  if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
  fi

  ZINIT
}

THEME() {
  # To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
  export ZLE_RPROMPT_INDENT=0
  [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
  # zinit ice wait lucid # Turbo mode is verbose, so you need an option for quiet.
  zinit light romkatv/powerlevel10k
}

ZSH_HISTORY() {
  HISTFILE="$HOME/.zsh_history"
  HISTSIZE=10000000
  SAVEHIST=10000000
  setopt BANG_HIST                 # Treat the '!' character specially during expansion.
  setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
  setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
  setopt SHARE_HISTORY             # Share history between all sessions.
  setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
  setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
  setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
  setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
  setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
  setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
  setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
  setopt HIST_VERIFY               # Don't execute immediately upon history expansion.
  setopt HIST_BEEP
}

ZINIT_PLUGINS(){
  ZSH_HISTORY
  ZSH_AUTOSUGGEST_STRATEGY=(history completion)

  # zinit load zdharma-continuum/history-search-multi-word
  zinit ice wait lucid # Turbo mode is verbose, so you need an option for quiet.
  zinit light zsh-users/zsh-completions

  zinit light zdharma-continuum/fast-syntax-highlighting
  zinit snippet OMZP::dotenv

  # zsh-autosuggestions
  zinit ice wait lucid # Turbo mode is verbose, so you need an option for quiet.
  zinit light zsh-users/zsh-autosuggestions
  bindkey '^p' history-search-backward
  bindkey '^o' history-search-forward
  bindkey '^n' autosuggest-accept
  bindkey '^e' autosuggest-execute
  bindkey '^a' autosuggest-toggle
  bindkey '^s' autosuggest-clear

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

START() {
  BEFORE

  if [ $ENABLE_TVIM -eq "1" ]; then
    if [ -z $NVIM ]; then
      BEFORE_NVIM
      nvim +':lua StartTerm(1)' && exit || $(ZINIT_PLUGINS && THEME)
    else
      AFTER_NVIM
    fi
  else
    BEFORE_NVIM
    AFTER_NVIM
  fi

  AFTER
}
START
