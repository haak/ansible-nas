# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/alex/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# Caution: this setting can cause issues with multiline prompts (zsh 5.7.1 and newer seem to work)
# See https://github.com/ohmyzsh/ohmyzsh/issues/5765
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git
  zsh-autosuggestions
  zsh-fzf-history-search
  vscode
)
source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='vim'
 else
   export EDITOR='vim'
 fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
# source /usr/share/nvm/init-nvm.sh

alias vim="nvim"
alias etmux="vim ~/.tmux.conf"
alias ezsh="vim ~/.zshrc"
alias essh="vim ~/.ssh/config"
alias evim="vim ~/.vimrc"
alias envim="vim ~/.config/nvim/init.vim"
alias etask="vim ~/.taskrc"
alias "pl"="pacman -Q"

alias fdsk="sudo fdisk -l | sed -e '/Disk \/dev\/loop/,+5d'"

### TASKWARRIOR ###
alias in="task add +in"
alias tatoday="task add due:today"
alias talater="task add due:later"
alias work="task add +work"
alias home="task add +home"
alias t none="task context none"
alias ts="task sync"
alias tu="task tags.none: list"
alias tcount="task +PENDING count"

alias tltoday="task due:today list"

tags() {
    task tags rc.verbose:nothing | sed -e '$d;1,2d' | sort -k2 -n -r | awk '{print $1}'
}


alias ttui="taskwarrior-tui"


### TAILSCALE ###
alias tsu="sudo tailscale up --accept-dns=false --accept-routes"

#sudo tailscale up --advertise-routes 192.168.177.0/24 --advertise-exit-node --exit-node-allow-lan-access
#  sudo tailscale up --advertise-routes=192.168.177.0/24 --advertise-exit-node
alias tsd="sudo tailscale down"
alias tss="sudo tailscale status"


alias enable-hibernate-sleep="sudo systemctl unmask sleep.target suspend.target hibernate.target hybrid-sleep.target"
alias disable-hibernate-sleep="sudo systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target"
alias status-hibernates-sleep="sudo systemctl status sleep.target suspend.target hibernate.target hybrid-sleep.target"

alias yeet="yay -R"

alias mc="mcli"

alias kb+="gdbus call --session --dest org.gnome.SettingsDaemon.Power --object-path /org/gnome/SettingsDaemon/Power --method org.gnome.SettingsDaemon.Power.Keyboard.StepUp"
alias kb-="gdbus call --session --dest org.gnome.SettingsDaemon.Power --object-path /org/gnome/SettingsDaemon/Power --method org.gnome.SettingsDaemon.Power.Keyboard.StepDown"

alias dev0="export DISPLAY=:0 && code ."
alias dev="export DISPLAY=:1 && code ."

alias h="/home/alex/Documents/projects/go/habits/bin/habits"

alias see-disk-usage="ncdu -e / --exclude /run"

### HISTORY FILE ###
# history must be written of, by and for the survivors.
#export HISTSIZE=10000
#export HISTFILESIZE=10000
#export HISTCONTROL=ignoredups # ignore duplicate entries
#export HISTCONTROL=ignoreboth # ignore successive entries
#export HISTIGNORE="ls:[bf]g:c:clear:exit:gp:gs:ll:lsd:ls?:s:ss:lvim:bashrc:t" # ignore these cmds
#export HISTFILE="${HOME}/.histories/.bash_history.`hostname`" # separate host files
# shopt -s histappend # append to the history file, don't overwrite
#export PROMPT_COMMAND="history -a" # Whenever displaying the prompt, write the previous line to disk




export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"


ssh() {
    if [ "$(ps -p $(ps -p $$ -o ppid=) -o comm=)" = "tmux" ]; then
        tmux rename-window "$(echo $* | cut -d . -f 1)"
        command ssh "$@"
        tmux set-window-option automatic-rename "on" 1>/dev/null
    else
        command ssh "$@"
    fi
}

alias docker-checkip="docker run --rm --network=container:gluetun alpine:3.14 sh -c 'apk add wget && wget -qO- https://ipinfo.io'"


rpg () {
    rpg-cli "$@"
    cd "$(rpg-cli pwd)"
}

alias df="df -h -x squashfs -x tmpfs -x devtmpfs -x overlay" 
alias lsmount="mount | column -t"
alias update="sudo pacman -Syyu"
alias pacs="sudo pacman -S"
alias pacrs="sudo pacman -Rs"
alias extip="curl icanhazip.com"

alias dpsr="docker ps -f "status=restarting""
alias port="sudo lsof -i:"
alias newscript="vim ~/.config/newscripts.sh"

alias faur="paru -Slq | fzf -m --preview 'cat (paru -Si {1} | psub) (paru -Fl {1} | awk \"{print \$2}\" | psub)' | xargs -ro paru -S"


alias remove-ssh-known-host="ssh-keygen -R"

### BTRFS ###
unalias btrfsCleanup 2>/dev/null
btrfsCleanup() {
    echo "btrfsCleanup"
    sudo btrfs fi show
    sudo btrfs fi df /
    sudo btrfs fi usage /
    sudo btrfs balance start -dusage=80 /
    sudo btrfs scrub start -d /
    sleep 120
    sudo btrfs fi df /var
    sudo btrfs fi usage /var
    sudo btrfs balance start -dusage=80 /var
    sudo btrfs scrub start -d /var
    sleep 120
    sudo btrfs fi df /var
    sudo btrfs fi usage /var
    echo "Done"
}
alias sync-cleanup='find . -name "*.sync-conflict*" -exec rm -rf {} \;'


alias sync-cleanup1='find . -name "*.sync-conflict*"'


alias bottom="btm"


alias "git log"="git log --pretty=oneline"

source /usr/share/autojump/autojump.zsh
[[ -s /home/alex/.autojump/etc/profile.d/autojump.sh ]] && source /home/alex/.autojump/etc/profile.d/autojump.sh

	autoload -U compinit && compinit -u


ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=2'


### GEBERAL PATH CHANGES
export PATH="$HOME/.local/bin:$PATH"
export PATH="/usr/bin/code:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"


### KUBERNETES ###
alias k="kubectl"

export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
export PATH=$PATH:~/.kube/plugins/jordanwilson230
export PATH=$PATH:/home/alex/.linkerd2/bin

### JAVA ###
alias set-java8="export JAVA_HOME=/usr/lib/jvm/java-8-openjdk/ && export PATH=$JAVA_HOME/bin:$PATH"


# /home/alex/.autojump/bin:/home/alex/.nvm/versions/node/v16.6.2/bin:/usr/local/bin:/usr/bin:/var/lib/snapd/snap/bin
#
export PATH="/usr/bin/code:/home/alex/.local/bin:/home/alex/.cargo/bin:/home/alex/.autojump/bin:/home/alex/.nvm/versions/node/v16.6.2/bin:/home/alex/.local/bin:/home/alex/.autojump/bin:/usr/local/bin:/usr/bin:/var/lib/snapd/snap/bin:/usr/local/sbin:/var/lib/flatpak/exports/bin:/usr/local/go/bin:/home/alex/go/bin:/usr/lib/jvm/default/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl"

export XDG_CONFIG_HOME="$HOME/.config"

source <(kubectl completion zsh)

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# Setup rustup, cargo path
[[ -f /home/alex/.rustrc ]] && source /home/alex/.rustrc

# >>>> Vagrant command completion (start)
fpath=(/opt/vagrant/embedded/gems/2.3.0/gems/vagrant-2.3.0/contrib/zsh $fpath)
compinit
# <<<<  Vagrant command completion (end)

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/home/alex/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)

# Required for TILIX on linux
if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
        source /etc/profile.d/vte.sh
fi
