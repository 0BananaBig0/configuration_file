# Store the exit code if the last command failed
PROMPT_COMMAND='EXIT_CODE=$?'
# Define color codes (with proper escaping)
CYAN='\[\e[1;36m\]'
GREEN='\[\e[1;32m\]'
YELLOW='\[\e[1;33m\]'
BLUE='\[\e[1;34m\]'
RED='\[\e[1;31m\]'
RESET='\[\e[0m\]'
# Build prompt components
USER_HOST="${CYAN}#\u${RESET}${GREEN}@\h in ${RESET}"
WORKING_DIR="${YELLOW}\w${RESET}"
TIMESTAMP="${BLUE}[${CYAN}$(date +"%d/%m/%Y-%a-%T")${BLUE}]${RESET}"
EXIT_CODE_PROMPT='$(if [[ $EXIT_CODE != 0 ]]; then echo -e " ${GREEN}C:${RESET}${RED}$EXIT_CODE${RESET}"; fi)'
# Combine all pieces
PS1="${USER_HOST}${WORKING_DIR} "
# Git
function git_branch {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return;
  local git_status=$(git status 2> /dev/null | tail -n1) || $(git status 2> /dev/null | head -n 2 | tail -n1);
  if [[ "$git_status" != "" ]]; then
    echo "("git:${ref#refs/heads/}*")";
  else
    echo "("git:${ref#refs/heads/}")";
  fi
}
PS1="${PS1}${GREEN}\$(git_branch)${TIMESTAMP}${EXIT_CODE_PROMPT}\n${YELLOW}\\\$${RESET} "
# Prevent exe files from appearing in auto-completion
FIGNORE=".exe"
