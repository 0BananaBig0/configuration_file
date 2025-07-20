#########################################################################
# File Name: rename.sh
# Author: Huaxiao Liang
# mail: 1184903633@qq.com
# Created Time: Sun 30 Apr 2023 10:34:06 PM
#########################################################################
#!/bin/bash

#!/bin/sh

git filter-branch --env-filter '

OLD_EMAIL_1="16hxliang3@stu.edu.cn"
OLD_EMAIL_2="1184903633@qq.com"
OLD_NAME_1="Liang"
OLD_NAME_2="Banana"
OLD_NAME_3="Banana-Two"
CORRECT_NAME="Huaxiao Liang"
CORRECT_EMAIL="1184903633@qq.com"

if [ "$GIT_COMMITTER_EMAIL" = "$OLD_EMAIL_1" ]
then
    export GIT_COMMITTER_NAME="$CORRECT_NAME"
    export GIT_COMMITTER_EMAIL="$CORRECT_EMAIL"
fi
if [ "$GIT_AUTHOR_EMAIL" = "$OLD_EMAIL_1" ]
then
    export GIT_AUTHOR_NAME="$CORRECT_NAME"
    export GIT_AUTHOR_EMAIL="$CORRECT_EMAIL"
fi
if [ "$GIT_COMMITTER_EMAIL" = "$OLD_EMAIL_2" ]
then
    export GIT_COMMITTER_NAME="$CORRECT_NAME"
    export GIT_COMMITTER_EMAIL="$CORRECT_EMAIL"
fi
if [ "$GIT_AUTHOR_EMAIL" = "$OLD_EMAIL_2" ]
then
    export GIT_AUTHOR_NAME="$CORRECT_NAME"
    export GIT_AUTHOR_EMAIL="$CORRECT_EMAIL"
fi
if [ "$GIT_COMMITTER_NAME" = "$OLD_NAME_1" ]
then
    export GIT_COMMITTER_NAME="$CORRECT_NAME"
    export GIT_COMMITTER_EMAIL="$CORRECT_EMAIL"
fi
if [ "$GIT_AUTHOR_NAME" = "$OLD_NAME_1" ]
then
    export GIT_AUTHOR_NAME="$CORRECT_NAME"
    export GIT_AUTHOR_EMAIL="$CORRECT_EMAIL"
fi
if [ "$GIT_COMMITTER_NAME" = "$OLD_NAME_2" ]
then
    export GIT_COMMITTER_NAME="$CORRECT_NAME"
    export GIT_COMMITTER_EMAIL="$CORRECT_EMAIL"
fi
if [ "$GIT_AUTHOR_NAME" = "$OLD_NAME_2" ]
then
    export GIT_AUTHOR_NAME="$CORRECT_NAME"
    export GIT_AUTHOR_EMAIL="$CORRECT_EMAIL"
fi
if [ "$GIT_COMMITTER_NAME" = "$OLD_NAME_3" ]
then
    export GIT_COMMITTER_NAME="$CORRECT_NAME"
    export GIT_COMMITTER_EMAIL="$CORRECT_EMAIL"
fi
if [ "$GIT_AUTHOR_NAME" = "$OLD_NAME_3" ]
then
    export GIT_AUTHOR_NAME="$CORRECT_NAME"
    export GIT_AUTHOR_EMAIL="$CORRECT_EMAIL"
fi
' --tag-name-filter cat -- --branches --tags
