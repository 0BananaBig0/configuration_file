# Store the exit code if the last command failed
PROMPT_COMMAND='EXIT_CODE=$?'
# Define the PS1 prompt
PS1='\[\e[1;36m\]#\u\[\e[0m\]\[\e[1;32m\]@\h in \[\e[1;33m\]\w\[\e[0m\] \[\e[1;34m\][\[\e[1;36m\]$(date +"%d/%m/%Y-%a-%T")\[\e[0m\]\[\e[1;34m\]]\[\e[0m\]$(if [[ $EXIT_CODE != 0 ]]; then echo -e " \[\e[1;32m\]C:\[\e[0m\]\[\e[1;31m\]$EXIT_CODE\[\e[0m\]"; fi)\n\[\e[1;33m\]$\[\e[0m\] '


