<!-- vim-markdown-toc GFM -->

* [(1) Configure vim/gvim/nvim/gnvim](#1-configure-vimgvimnvimgnvim)
  * [1,login your account](#1login-your-account)
  * [2,execute the following commands until it successes](#2execute-the-following-commands-until-it-successes)
  * [3,copy configuration file from celab106_z2mini and add some configurations](#3copy-configuration-file-from-celab106_z2mini-and-add-some-configurations)
  * [4,add the following content to your .bashrc](#4add-the-following-content-to-your-bashrc)
  * [5,open vim/gvim/gnvim/nvim and execute the following command:](#5open-vimgvimgnvimnvim-and-execute-the-following-command)
  * [6,open vim/gvim/gnvim/nvim and execute the following command:](#6open-vimgvimgnvimnvim-and-execute-the-following-command)
  * [7,install some dependencies](#7install-some-dependencies)
* [(2)use exa to replace ls](#2use-exa-to-replace-ls)
* [(3)add some tools](#3add-some-tools)
* [(4)close screensaver](#4close-screensaver)
* [(5)解决centos下非root用户频繁出现Authentication is required to set](#5解决centos下非root用户频繁出现authentication-is-required-to-set)
* [(6)解决没有root权限的普通用户使用vnc提示:](#6解决没有root权限的普通用户使用vnc提示)
* [(7)configure gdb](#7configure-gdb)

<!-- vim-markdown-toc -->
#(1) Configure vim/gvim/nvim/gnvim
## 1,login your account
```
ssh -X hxliang@10.34.24.11
```
## 2,execute the following commands until it successes
a plugin which is used to manage other plugins of vim and whose name is vim-plug
```
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://ghproxy.com/https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://ghproxy.com/https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
```
## 3,copy configuration file from celab106_z2mini and add some configurations
```
cp /home-local/celab106_z2mini/.vimrc ~
cp /home-local/celab106_z2mini/.vim/coc-settings.json ~/.vim
cp /home-local/celab106_z2mini/.config/goneovim ~/.config/ -r
cp /home-local/celab106_z2mini/.vim/.vimspectorjson/ ~/.vim -r
mkdir ~/.config/nvim -p
ln -s /home/hxliang/.vimrc ~/.config/nvim/init.vim
ln -s /home/hxliang/.vim/coc-settings.json ~/.config/nvim/
mkdir ~/Downloads/program/ -p
cp /home-local/celab106_z2mini/Downloads/program/goneovim-linux/ ~/Downloads/program/ -r
```
## 4,add the following content to your .bashrc
```
# the gui of neovim
alias gnvim='~/Downloads/program/Goneovim-v0.5.1-linux/goneovim -p'
```
## 5,open vim/gvim/gnvim/nvim and execute the following command:
```
PlugInstall
```
If you can success in downloading the plugin, retry it until all plugin has been downloaded.\
Maybe iamcco/markdown-preview.nvim will have some problem, when you open md file and press key F2, you have to uninstall
iamcco/markdown-preview.nvim and download it again. If it downloaded failed, close vim/gvim/nvim and open vim/gvim/nvim againg then download it again.Redo it until it can download successfully.\
coc.nvim may have the same problem like iamcco/markdown-preview.nvim, you can do the same thing to solve it.
## 6,open vim/gvim/gnvim/nvim and execute the following command:
```
CocInstall coc-omni coc-word coc-markdownlint coc-vimlsp coc-dictionary coc-tag coc-cmake coc-sh coc-css coc-json coc-pyright coc-yaml coc-cl coc-clangd coc-snippets 
```
(第一个补全选项要么直接按enter要么按了tab一会儿后再按enter否则补全会有问题)
如果想添加coc的补全拥有机械学习能力请参考coc-tabnine,缺点：耗内存和GPU,可能要钱.
## 7,install some dependencies
```
pip config set global.index-url https://mirrors.cloud.tencent.com/pypi/simple
pip install pysnooper ipdb
pip install compiledb #(a tool for you to create a compile_commands.json if you use make to manage your c/c++ project)
pip install pylint yapf futures isort pygments cmake_format hdl_checker vim-vint cmakelang pyright gdbgui
```
#(2)use exa to replace ls
```
# add the following to your .bashrc
export PATH=$PATH:/home-local/celab106_z2mini/.cargo/bin
```
#(3)add some tools
```
#cppman can help you know about c/c++ function
#you-get can download some videos from bilibili.com
pip install cppman you-get
```
#(4)close screensaver
查看vnc使用什么屏保程序
```
ps aux | grep screen
```
如果有则搜索linux如何关闭xxx的屏保，例如xscreensaver，没有则无需管理。
#(5)解决centos下非root用户频繁出现Authentication is required to set
  非root用户登陆linux服务器，总是弹出一个对话框，而且关闭之后，过一段时间还会弹出来。对话框的内容是：Authentication is required to set the network proxy used for downloading packages。然后提示你输入root密码。 \
  解决办法：在终端窗口（右键，open in terminal）输入“gnome-session-properties”。然后把“PackageKit Update Applet”前面的勾去掉就行了或者换成xfce
#(6)解决没有root权限的普通用户使用vnc提示:
XFCE PolicyKit Agent \
GDBus.Error:org.freedesktop.PolickKit1.Error.Failed:An authentication agent already exists for the given subject.
```
open Setting > Session and Startup > Application Autostart
Remove the check mark(√) of XFCE PolKit(Policykit Authentication Agent)[In other systems, it may be called PolicyKit Authentication Agent(Policykit Authentication Agent)]
```
# (7)configure gdb
```
cp /home/hxliang/.gdbinit ~
```
