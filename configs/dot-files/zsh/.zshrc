AUTO_VIM=1

BEFORE(){
    OPTS
    PATH
}

AFTER(){
  alias vim="$EDITOR"
}

BEFORE_NVIM(){
    SSH
    PROFILE
    CONDA
    ZINIT
    ZINIT_BEFORE_PLUGINS
}

AFTER_NVIM(){
    P10K_ZINIT
    ZINIT
    ZINIT_PLUGINS
    ZINIT_BEFORE_PLUGINS
    THEME
    PROFILE
}

PATH() {
    export PATH=$PATH:/bin
    export PATH=$PATH:/sbin
    export PATH=$PATH:/usr/bin
    export PATH=$PATH:/usr/local/bin
    export PATH=$PATH:/usr/sbin

    export PATH=$PATH:$HOME/.local/bin/
    export PATH=$PATH:$HOME/.node_modules/bin/
}

OPTS() {
    export LANG=en_US.UTF-8
    export EDITOR='vmux'
    set -o vi
}


PROFILE() {
    source ~/.profile
    source ~/.aliases

}

SSH() {
    eval "$(ssh-agent -s)" > /dev/null 2>&1
}

CONDA() {
  # >>> conda initialize >>>
  [ -f /opt/miniconda3/etc/profile.d/conda.sh ] && source /opt/miniconda3/etc/profile.d/conda.sh
  # <<< conda initialize <<<
}

P10K_ZINIT() {
    # Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
    # Initialization code that may require console input (password prompts, [y/n]
    # confirmations, etc.) must go above this block; everything else may go below.

    if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
        source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
    fi
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

ZINIT_PLUGINS_COMPLETIONS(){
    zinit light conda-incubator/conda-zsh-completion
    zinit light srijanshetty/zsh-pip-completion

    # Replace `light` with `load` if you want some more debugging
    zinit ice depth=1 # optional, but avoids downloading the full history
    zinit light 3v1n0/zsh-bash-completions-fallback

    # With a daemon for completion engine
    zinit wait lucid for \
        dim-an/cod

    # Even more completion bro
    zinit ice lucid nocompile wait'0e' nocompletions
    zinit load MenkeTechnologies/zsh-more-completions
    zinit light Dabz/kafka-zsh-completions
    zinit light sbodiu-pivotal/fly-zsh-autocomplete-plugin
    zinit light greymd/docker-zsh-completion
    zinit light nix-community/nix-zsh-completions
    zinit light chisui/zsh-nix-shell

    # gpt-engineer completion
    autoload -Uz compinit
    zstyle ':completion:*' menu select
    fpath+=~/.zfunc
}

ZINIT_BEFORE_PLUGINS() {
    zinit light mattberther/zsh-nodenv
    # zinit light commiyou/conda-init-zsh-plugin
}

ZINIT_PLUGINS(){
    ZSH_HISTORY
    ZSH_AUTOSUGGEST_STRATEGY=(history completion)

    # zinit load zdharma-continuum/history-search-multi-word
    zinit ice wait lucid # Turbo mode is verbose, so you need an option for quiet.
    zinit light zsh-users/zsh-completions

    zinit light Tarrasch/zsh-autoenv
    # https://github.com/Tarrasch/zsh-autoenv
    # By default it uses .autoenv.zsh for entering, and .autoenv_leave.zsh for leaving.

    zinit light zdharma-continuum/fast-syntax-highlighting
    zinit snippet OMZP::dotenv

    zinit light 0b10/cheatsheet
    ZINIT_PLUGINS_COMPLETIONS

    # zsh-autosuggestions
    # zinit light zsh-users/zsh-autosuggestions
    zinit load zsh-users/zsh-autosuggestions  # Load it instantly, no "light"
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

    if [ -v $AUTO_VIM ]; then
        BEFORE_NVIM
        AFTER_NVIM
    else
        if [ -z $NVIM ]; then
            BEFORE_NVIM
            nvim +':terminal' +':startinsert' && exit || AFTER_NVIM
        else
            AFTER_NVIM
        fi
    fi

    AFTER
}
START
