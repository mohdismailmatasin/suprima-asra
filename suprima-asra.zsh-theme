# Suprima ASRA Zsh Theme - Enhanced Version (Dark Background Optimized)
# Based on Ultima Zsh Theme p2.c7 - https://github.com/egorlem/ultima.zsh-theme
#
# Enhanced with performance optimizations, additional features, and better error handling
# Optimized for dark terminal backgrounds
#
# ------------------------------------------------------------------------------

autoload -Uz compinit; compinit

# LOCAL/VARIABLES/ANSI ---------------------------------------------------------

ANSI_reset="\x1b[0m"
ANSI_dim_black="\x1b[0;30m"
ANSI_grey="\x1b[0;37m"
ANSI_dim_grey="\x1b[2;37m"
ANSI_very_dim_grey="\x1b[2;37m"  # Changed from black to grey for dark backgrounds

# LOCAL/VARIABLES/GRAPHIC ------------------------------------------------------

char_arrow="›"                                                  #Unicode: \u203a
char_up_and_right_divider="└"                                   #Unicode: \u2514
char_down_and_right_divider="┌"                                 #Unicode: \u250c
char_vertical_divider="─"                                       #Unicode: \u2500

# SEGMENT/VCS_STATUS_LINE ------------------------------------------------------

export VCS="git"

current_vcs="\":vcs_info:*\" enable $VCS"
char_badge="%F{white} on %f%F{white}${char_arrow}%f"  # Changed from black to white
vc_branch_name="%F{green}%b%f"

vc_action="%F{white}%a %f%F{white}${char_arrow}%f"  # Changed from black to white
vc_unstaged_status="%F{cyan} M ${char_arrow}%f"

vc_git_staged_status="%F{green} A ${char_arrow}%f"
vc_git_hash="%F{green}%6.6i%f %F{white}${char_arrow}%f"  # Changed from black to white
vc_git_untracked_status="%F{blue} U ${char_arrow}%f"

if [[ $VCS != "" ]]; then
  autoload -Uz vcs_info
  eval zstyle $current_vcs
  zstyle ':vcs_info:*' get-revision true
  zstyle ':vcs_info:*' check-for-changes true
fi

case "$VCS" in 
   "git")
    # git specific 
    zstyle ':vcs_info:git*+set-message:*' hooks use_git_untracked git_stash_count
    zstyle ':vcs_info:git:*' stagedstr $vc_git_staged_status
    zstyle ':vcs_info:git:*' unstagedstr $vc_unstaged_status
    zstyle ':vcs_info:git:*' actionformats "  ${vc_action} ${vc_git_hash}%m%u%c${char_badge} ${vc_branch_name}"
    zstyle ':vcs_info:git:*' formats " %c%u%m${char_badge} ${vc_branch_name}"
  ;;

  "svn")
    zstyle ':vcs_info:svn:*' branchformat "%b"
    zstyle ':vcs_info:svn:*' formats " ${char_badge} ${vc_branch_name}"
  ;;

  "hg")
    zstyle ':vcs_info:hg:*' branchformat "%b"
    zstyle ':vcs_info:hg:*' formats " ${char_badge} ${vc_branch_name}"
  ;;
esac

# Show untracked file status char on git status line
+vi-use_git_untracked() {
  if [[ $(git rev-parse --is-inside-work-tree 2>/dev/null) == "true" ]] &&
    git status --porcelain | grep -m 1 "^??" &>/dev/null; then
    hook_com[misc]+=$vc_git_untracked_status
  fi
}

# NEW: Show git stash count
+vi-git_stash_count() {
  if [[ $(git rev-parse --is-inside-work-tree 2>/dev/null) == "true" ]]; then
    local stash_count=$(git stash list 2>/dev/null | wc -l)
    if (( stash_count > 0 )); then
      hook_com[misc]+="%F{magenta} S${stash_count} ${char_arrow}%f"
    fi
  fi
}

# SEGMENT/SSH_STATUS -----------------------------------------------------------

ssh_marker=""

if [[ -n "$SSH_CLIENT" || -n "$SSH2_CLIENT" ]]; then
 ssh_marker="%F{green}SSH%f%F{white}:%f"  # Changed separator from black to white
fi

# UTILS ------------------------------------------------------------------------

setopt PROMPT_SUBST

# Command execution time tracking - ENHANCED
cmd_exec_time() {
  local stop=$(date +%s)
  local start=${cmd_timestamp:-$stop}
  local elapsed=$((stop - start))
  
  if (( elapsed >= 60 )); then
    local minutes=$((elapsed / 60))
    local seconds=$((elapsed % 60))
    echo "%F{red}⏱ ${minutes}m${seconds}s%f | "
  elif (( elapsed >= 10 )); then
    echo "%F{yellow}⏱ ${elapsed}s%f | "
  elif (( elapsed >= 3 )); then
    echo "%F{cyan}⏱ ${elapsed}s%f | "
  fi
}

preexec() {
  cmd_timestamp=$(date +%s)
}

# ENHANCED: Battery status with better cross-platform support
battery_status() {
  local percent bat_status icon color
  
  # Linux support
  if [[ -d /sys/class/power_supply/BAT0 ]]; then
    percent=$(< /sys/class/power_supply/BAT0/capacity 2>/dev/null)
    bat_status=$(< /sys/class/power_supply/BAT0/status 2>/dev/null)
  # macOS support
  elif command -v pmset >/dev/null 2>&1; then
    local battery_info=$(pmset -g batt | grep -o '[0-9]*%' | head -1)
    percent=${battery_info%\%}
    if pmset -g batt | grep -q "AC Power"; then
      bat_status="Charging"
    else
      bat_status="Discharging"
    fi
  # WSL/Windows support
  elif [[ -n "$WSL_DISTRO_NAME" ]] && command -v powershell.exe >/dev/null 2>&1; then
    local battery_info=$(powershell.exe -Command "Get-WmiObject Win32_Battery | Select-Object EstimatedChargeRemaining" 2>/dev/null)
    percent=$(echo "$battery_info" | grep -o '[0-9]*' | head -1)
  fi
  
  if [[ -n "$percent" && "$percent" != "" ]]; then
    if (( percent > 80 )); then
      icon="🔋"
      color="%F{green}"
    elif (( percent > 50 )); then
      icon="🔋"
      color="%F{yellow}"
    elif (( percent > 20 )); then
      icon="🔋"
      color="%F{208}"  # Orange color code for better visibility
    else
      icon="🪫"
      color="%F{red}"
    fi
    
    if [[ $bat_status == "Charging" ]]; then
      icon="⚡"
    fi
    echo "$color$icon $percent%%%f"
  fi
}

# NEW: System load indicator
system_load() {
  if command -v uptime >/dev/null 2>&1; then
    local load=$(uptime | grep -o 'load average.*' | awk '{print $3}' | sed 's/,//')
    if [[ -n "$load" ]]; then
      local load_int=${load%.*}
      if (( load_int > 2 )); then
        echo "%F{red}📊 ${load}%f | "
      elif (( load_int > 1 )); then
        echo "%F{yellow}📊 ${load}%f | "
      fi
    fi
  fi
}

# NEW: Memory usage indicator
memory_usage() {
  if command -v free >/dev/null 2>&1; then
    local mem_usage=$(free | awk '/Mem:/ {printf "%.0f", $3/$2 * 100}')
    if (( mem_usage > 80 )); then
      echo "%F{red}🧠 ${mem_usage}%%%f | "
    elif (( mem_usage > 60 )); then
      echo "%F{yellow}🧠 ${mem_usage}%%%f | "
    fi
  elif command -v vm_stat >/dev/null 2>&1; then
    # macOS memory check
    local mem_pressure=$(memory_pressure 2>/dev/null | grep "System-wide memory free percentage" | awk '{print $5}' | sed 's/%//')
    if [[ -n "$mem_pressure" ]] && (( mem_pressure < 20 )); then
      echo "%F{red}🧠 High%f | "
    elif [[ -n "$mem_pressure" ]] && (( mem_pressure < 40 )); then
      echo "%F{yellow}🧠 Med%f | "
    fi
  fi
}

# ENHANCED: Kubernetes context
k8s_context() {
  if command -v kubectl >/dev/null 2>&1; then
    local context=$(kubectl config current-context 2>/dev/null)
    if [[ -n "$context" ]]; then
      # Truncate long context names
      if (( ${#context} > 15 )); then
        context="${context:0:12}..."
      fi
      echo "%F{blue}⎈ ${context}%f | "
    fi
  fi
}

# ENHANCED: Git status with ahead/behind info
git_remote_status() {
  if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    local ahead behind
    local remote_info=$(git rev-list --count --left-right @{upstream}...HEAD 2>/dev/null)
    if [[ -n "$remote_info" ]]; then
      behind=$(echo "$remote_info" | awk '{print $1}')
      ahead=$(echo "$remote_info" | awk '{print $2}')
      local status=""
      if (( ahead > 0 )); then
        status+="%F{green}↑${ahead}%f"
      fi
      if (( behind > 0 )); then
        status+="%F{red}↓${behind}%f"
      fi
      if [[ -n "$status" ]]; then
        echo " $status"
      fi
    fi
  fi
}

# Function to get public IP address (if online) - DISABLED
get_public_ip() {
  # IP address display removed for privacy
  echo ""
}

# Prepare git status line - ENHANCED
prepareGitStatusLine() {
  echo '${vcs_info_msg_0_}$(git_remote_status)'
} 

# Prepare prompt line limiter
printPsOneLimiter() {
  local termwidth
  local spacing=""
  
  ((termwidth = ${COLUMNS} - 1))
  
  for i in {1..$termwidth}; do
    spacing="${spacing}${char_vertical_divider}"
  done
  
  echo $ANSI_very_dim_grey$char_down_and_right_divider$spacing$ANSI_reset
}

# SEGMENT/PYTHON_ENV -----------------------------------------------------------

python_env_status() {
  if [[ -n "$VIRTUAL_ENV" ]]; then
    local env_name=$(basename "$VIRTUAL_ENV")
    echo "%F{yellow}🐍 $env_name%f | "  # Changed from white to yellow for better visibility
  elif [[ -n "$CONDA_DEFAULT_ENV" ]]; then
    echo "%F{yellow}🐍 $CONDA_DEFAULT_ENV%f | "  # Changed from white to yellow
  fi
}

# SEGMENT/NODE_ENV - ENHANCED --------------------------------------------------

node_env_status() {
  if [[ -f "package.json" ]] || [[ -f ".nvmrc" ]] || [[ -d "node_modules" ]]; then
    local node_version=$(node --version 2>/dev/null)
    if [[ -n "$node_version" ]]; then
      echo "%F{green}⬢ ${node_version#v}%f | "
    fi
  fi
}

# NEW: Rust environment
rust_env_status() {
  if [[ -f "Cargo.toml" ]] && command -v rustc >/dev/null 2>&1; then
    local rust_version=$(rustc --version 2>/dev/null | awk '{print $2}')
    if [[ -n "$rust_version" ]]; then
      echo "%F{red}🦀 ${rust_version}%f | "
    fi
  fi
}

# NEW: Go environment
go_env_status() {
  if [[ -f "go.mod" ]] && command -v go >/dev/null 2>&1; then
    local go_version=$(go version 2>/dev/null | awk '{print $3}' | sed 's/go//')
    if [[ -n "$go_version" ]]; then
      echo "%F{cyan}🐹 ${go_version}%f | "
    fi
  fi
}

# SEGMENT/DIRECTORY_INFO -------------------------------------------------------

dir_info() {
  local username=$(whoami)
  echo "%F{248}($username)%f"  # Changed from 242 to 248 for better visibility on dark backgrounds
}

# SEGMENT/DOCKER_STATUS - ENHANCED ---------------------------------------------

docker_status() {
  local docker_info=""
  
  if [[ -f "Dockerfile" ]] || [[ -f "docker-compose.yml" ]] || [[ -f "docker-compose.yaml" ]]; then
    docker_info="%F{blue}🐳%f"
  fi
  
  # Show if Docker daemon is running
  if command -v docker >/dev/null 2>&1 && docker info >/dev/null 2>&1; then
    local containers=$(docker ps -q 2>/dev/null | wc -l)
    if (( containers > 0 )); then
      docker_info+="%F{green}[$containers]%f"
    fi
  fi
  
  if [[ -n "$docker_info" ]]; then
    echo "$docker_info | "
  fi
}

# NEW: Last command status with more details
command_status() {
  if [[ $LAST_EXIT_STATUS -ne 0 ]]; then
    local status_color="%F{red}"
    local status_icon="✗"
    
    # Common exit codes
    case $LAST_EXIT_STATUS in
      1) status_icon="✗" ;;      # General error
      2) status_icon="⚠" ;;      # Misuse of shell builtins
      126) status_icon="🚫" ;;   # Command invoked cannot execute
      127) status_icon="❓" ;;   # Command not found
      130) status_icon="🛑" ;;   # Ctrl+C
      *) status_icon="✗" ;;
    esac
    
    echo "$status_color$status_icon $LAST_EXIT_STATUS%f | "
  fi
}

# ENV/VARIABLES/PROMPT_LINES ---------------------------------------------------

# PS1 arrow - green # PS2 arrow - cyan # PS3 arrow - white

# FIXED: Changed the order to put dir_info() before %~ and added proper spacing
PROMPT="%F{248}${char_up_and_right_divider} ${ssh_marker}$(dir_info) on %f%F{cyan}%~%f$(prepareGitStatusLine)
%F{green} ${char_arrow}%f "

# Enhanced RPROMPT with more information
RPROMPT='$(cmd_exec_time)$(system_load)$(memory_usage)$(k8s_context)$(docker_status)$(rust_env_status)$(go_env_status)$(node_env_status)$(python_env_status)$(command_status)%F{yellow}%*%f | $(battery_status)'

# PS2 Example 
PS2="%F{white} %_ %f%F{cyan}${char_arrow} "  # Changed from black to white

# PS3 The value of this parameter is used as the prompt for the select command
PS3=" ${char_arrow} "

# ENV/HOOKS --------------------------------------------------------------------

# Show exit status of last command in prompt
precmd() {
  if [[ $VCS != "" ]]; then
    vcs_info
  fi
  printPsOneLimiter
  export LAST_EXIT_STATUS=$?
}

# ENV/VARIABLES/LS_COLORS ------------------------------------------------------

LSCOLORS=gxafexdxfxagadabagacad
export LSCOLORS                                                             #BSD

LS_COLORS="di=36:ln=30;45:so=34:pi=33:ex=35:bd=30;46:cd=30;43:su=30;41:sg=30;46:tw=30;42:ow=30;43"
export LS_COLORS                                                            #GNU

# ENV/VARIABLES/LESS AND MAN ---------------------------------------------------

export LESS='--quit-if-one-screen --ignore-case --status-column --LONG-PROMPT --RAW-CONTROL-CHARS --HILITE-UNREAD --tabs=4 --no-init --window=-4'
export LESS_TERMCAP_mb=$'\x1b[0;36m'                                # begin bold
export LESS_TERMCAP_md=$'\x1b[0;34m'                               # begin blink
export LESS_TERMCAP_me=$'\x1b[0m'                             # reset bold/blink
export LESS_TERMCAP_so=$' \x1b[0;42;30m '                  # begin reverse video
export LESS_TERMCAP_se=$' \x1b[0m'
export LESS_TERMCAP_us=$'\x1b[0m\x1b[0;32m'                    # begin underline
export LESS_TERMCAP_ue=$'\x1b[0m'                              # reset underline
export GROFF_NO_SGR=1     

# SEGMENT/COMPLETION - ENHANCED ------------------------------------------------

setopt MENU_COMPLETE
setopt AUTO_LIST
setopt AUTO_MENU
setopt ALWAYS_TO_END

completion_descriptions="%F{blue} ${char_arrow} %f%%F{green}%d%f"
completion_warnings="%F{yellow} ${char_arrow} %fno matches for %F{green}%d%f"
completion_error="%B%F{red} ${char_arrow} %f%e %d error"

zstyle ':completion:*' completer _expand _complete _ignored _approximate
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/.zcompcache"
zstyle ':completion:*' verbose yes
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list "m:{a-z}={A-Z}" "r:|[._-]=* r:|=*" "l:|=* r:|=*"
zstyle ':completion:*' group-name ''

zstyle ':completion:*:*:*:*:descriptions' format $completion_descriptions
zstyle ':completion:*:*:*:*:corrections' format $completion_error
zstyle ':completion:*:*:*:*:default' list-colors ${(s.:.)LS_COLORS} "ma=0;42;30"
zstyle ':completion:*:*:*:*:warnings' format $completion_warnings
zstyle ':completion:*:*:*:*:messages' format "%d"

zstyle ':completion:*:expand:*' tag-order all-expansions
zstyle ':completion:*:approximate:*' max-errors "reply=( $(( ($#PREFIX+$#SUFFIX)/3 )) numeric )"
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters
zstyle ':completion:*:*:(^rm):*:*files' ignored-patterns "*?.o" "*?.c~" "*?.old" "*?.pro"
zstyle ':completion:*:functions' ignored-patterns "_*"

zstyle -e ':completion:*:(ssh|scp|sftp|rsh|rsync):hosts' hosts 'reply=(${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) /dev/null)"}%%[# ]*}//,/ })'

zstyle ':completion:*:parameters' list-colors '=*=34'
zstyle ':completion:*:options' list-colors '=^(-- *)=34'
zstyle ':completion:*:commands' list-colors '=*=1;34'

# NEW: Performance optimizations
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

# ------------------------------------------------------------------------------
