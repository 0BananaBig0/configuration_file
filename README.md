# configuration_file
some_experience_in_configuring_Ubuntu18
Find a folder which you want to store the file and execute the following 
command in your terminal:
```
git clone https://github.com/Banana-Two/configuration_file
```
Before using the following commands,please read the ubuntu18_config.md or 
centos8_config.md according to your system.

## If you want to use the .vimrc_no_the_third_plugged,you can use the following command:

### For vim
(For common user)
```
ln -s /path/to/the/.vimrc_no_the_third_plugged /home/YourAccount/.vimrc
```
(For root user)
```
sudo ln -s /path/to/the/.vimrc_no_the_third_plugged /root/.vimrc
```

### For nvim
(For common user)
```
ln -s /path/to/the/.vimrc_no_the_third_plugged /home/YourAccount/.config/nvim/init.vim
```
(For root user)
```
sudo ln -s /path/to/the/.vimrc_no_the_third_plugged /root/.config/nvim/init.vim
```

## If you want to use the .vimrc,you can use the following command:
Before executing the following commands, read the .vimrc, there are some 
comments in it you need to know.

### For vim
(For common user)
```
ln -s /path/to/the/.vimrc /home/YourAccount/.vimrc
ln -s /path/to/the/coc-settings.json /home/YourAccount/.vim/coc-settings.json
```
(For root user)
```
sudo ln -s /path/to/the/.vimrc /root/.vimrc
sudo ln -s /path/to/the/coc-settings.json /root/.vim/coc-settings.json
```

### For nvim
(For common user)
```
ln -s /path/to/the/.vimrc /home/YourAccount/.config/nvim/init.vim
ln -s /path/to/the/coc-settings.json /home/YourAccount/.config/nvim/coc-settings.json
```
(For root user)
```
sudo ln -s /path/to/the/.vimrc /root/.config/nvim/init.vim
sudo ln -s /path/to/the/coc-settings.json /root/.config/nvim/coc-settings.json
```

## If you want to use the .vimrc_no_asyncrun,you can use the following command:
Before executing the following commands, read the .vimrc_no_asyncrun, there 
are some comments in it you need to know.

### For vim
(For common user)
```
ln -s /path/to/the/.vimrc_no_asyncrun /home/YourAccount/.vimrc
ln -s /path/to/the/coc-settings.json /home/YourAccount/.vim/coc-settings.json
```
(For root user)
```
sudo ln -s /path/to/the/.vimrc_no_asyncrun /root/.vimrc
sudo ln -s /path/to/the/coc-settings.json /root/.vim/coc-settings.json
```

### For nvim
(For common user)
```
ln -s /path/to/the/.vimrc.vimrc_no_asyncrun /home/YourAccount/.config/nvim/init.vim
ln -s /path/to/the/coc-settings.json /home/YourAccount/.config/nvim/coc-settings.json
```
(For root user)
```
sudo ln -s /path/to/the/.vimrc.vimrc_no_asyncrun /root/.config/nvim/init.vim
sudo ln -s /path/to/the/coc-settings.json /root/.config/nvim/coc-settings.json
```

## If you want to update the configuration,execute the following commands:
```
cd /path/to/the/github/file
git pull
```

## If you don't want to update the configuration about vim and nvim
And want to delete the file you download from the github, you can use 'cp' 
to replace 'ln -s' in the above commands.

## If you want to use the .zshrc file, you should execute the following commands:
(For common user)
```
gvim /path/to/my/.zshrc
```
Modify "/home/banana/.oh-my-zsh" to "/home/YourAccount/.oh-my-zsh" in the 13th rows
```
cp /path/to/my/ys_modified.zsh-theme /home/YourAccount/.oh-my-zsh/custom/themes/ys_modified.zsh-theme
cp /path/to/my/.zshrc /home/YourAccount/.zshrc
```
Maybe you can use 'ln -s' to replace 'cp',I'm not sure whether the terminal will 
give you warrnings or not.\
(For root user)
```
gvim /path/to/my/.zshrc
```
Modify "/home/banana/.oh-my-zsh" to "/root/.oh-my-zsh" in the 13th rows
```
sudo cp /path/to/my/ys_modified.zsh-theme /root/.oh-my-zsh/custom/themes/ys_modified.zsh-theme
sudo cp /path/to/my/.zshrc /root/.zshrc
```
Maybe you can use 'ln -s' to replace cp,I'm not sure whether the terminal will
give you warrnings or not.


## If you want to remove all the file,you can execute the following commands:
```
rm /path/to/the/github/file
```

### For vim
(For common user)
```
rm /home/YourAccount/.vimrc
rm /home/YourAccount/.vim/coc-settings.json
```
(For root user)
```
sudo rm /root/.vimrc
sudo rm /root/.vim/coc-settings.json
```

### For nvim
(For common user)
```
rm /home/YourAccount/.config/nvim/init.vim
rm /home/YourAccount/.config/nvim/coc-settings.json
```
(For root user)
```
sudo rm /root/.config/nvim/init.vim
sudo rm /root/.config/nvim/coc-settings.json
```

### For zshell or .zshrc
(For common user)
```
rm /home/YourAccount/.zshrc
rm /home/YourAccount/.oh-my-zsh/custom/themes/ys_modified.zsh-theme
```
(For root user)
```
sudo rm /root/.zshrc
sudo rm /root/.oh-my-zsh/custom/themes/ys_modified.zsh-theme
```
