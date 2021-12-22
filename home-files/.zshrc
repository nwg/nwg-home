# NPM packages in homedir
export NPM_PACKAGES="$HOME/.npm-packages"

# Unset manpath so we can inherit from /etc/manpath via the `manpath` command
unset MANPATH  # delete if you already modified MANPATH elsewhere in your configuration
export MANPATH="$NPM_PACKAGES/share/man:$(manpath)"

# Tell Node about these packages
export NODE_PATH="$NPM_PACKAGES/lib/node_modules:$NODE_PATH"
export PATH="$HOME/.emacs.d/bin:/Applications/Emacs.app/Contents/MacOS/:$NPM_PACKAGES/bin:$HOME/.local/bin:/usr/local/bin:/opt/local/bin:$HOME/.root/bin:$HOME/Library/Haskell/bin:/opt/local/lib/postgresql11/bin/:/Library/TeX/:$PATH"

unalias run-help 2>/dev/null
autoload run-help
export HELPDIR="/usr/share/zsh/${ZSH_VERSION}/help"
alias help=run-help


# Nix
if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
  . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
fi
# End Nix

#unsetopt HASH_CMDS
zstyle ':completion:*' rehash true
autoload -Uz compinit && compinit

fpath=(
    ~/.zfunc
    "${fpath[@]}"
)

my_precmd() { hash -r; }
autoload -Uz add-zsh-hook
add-zsh-hook precmd my_precmd

export PATH="$PATH:/Users/griswold/Library/Python/3.9/bin"

export HISTSIZE=1000000   # the number of items for the internal history list
export SAVEHIST=1000000   # maximum number of items for the history file
setopt incappendhistorytime

use_racket () {
    export PATH="$HOME/Library/Racket/8.2/bin:/Applications/Racket v8.2/bin:$PATH"
}

use_racket
#exec rash-repl

gpgconf="$HOME/.nix-profile/bin/gpgconf"
if [ -x "$gpgconf" ]; then
  export SSH_AUTH_SOCK="$("$gpgconf" --list-dirs agent-ssh-socket)"
  "$gpgconf" --launch gpg-agent
else
  echo "Could not find gpgconf at $gpgconf"
fi
