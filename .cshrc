#!/usr/bin/env csh
# ############################################################################ #
# #                            File Name: .cshrc                             # #
# #                          Author: Huaxiao Liang                           # #
# #                         Mail: hxliang666@qq.com                          # #
# #                         04/28/2025-Mon-23:21:13                          # #
# ############################################################################ #


# Define color codes (with proper escaping)
set CYAN = "%{\033[1;36m%}"
set GREEN = "%{\033[1;32m%}"
set YELLOW = "%{\033[1;33m%}"
set BLUE = "%{\033[1;34m%}"
set RED = "%{\033[1;31m%}"
set RESET = "%{\033[0m%}"

# Build prompt components
set USER_HOST = "${CYAN}#%n${RESET}${GREEN}@%m in ${RESET}"
set WORKING_DIR = "${YELLOW}%~${RESET}"
set TIMESTAMP = "${BLUE}[${CYAN}`date +"%d/%m/%Y-%a-%T"`${BLUE}]${RESET}"

# Set the prompt in two steps to avoid quote issues
set prompt = "${USER_HOST}${WORKING_DIR} "
set prompt = "${prompt}${TIMESTAMP}"

# Complete the prompt
set prompt = "${prompt}\r\n${YELLOW}%#${RESET} "

# Prevent exe files from appearing in auto-completion
set fignore = (.exe)
