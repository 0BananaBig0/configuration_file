<!-- vim-markdown-toc GFM -->

* [Note:](#note)
* [(1) Configure vim/gvim/nvim/gnvim](#1-configure-vimgvimnvimgnvim)
    * [1,login your account](#1login-your-account)
    * [2,execute the following commands until it successes](#2execute-the-following-commands-until-it-successes)
    * [3,copy configuration file from hxliang and add some configurations](#3copy-configuration-file-from-hxliang-and-add-some-configurations)
    * [4,add the following content to your .bashrc or .zshrc](#4add-the-following-content-to-your-bashrc-or-zshrc)
    * [5,open vim/gvim/gnvim/nvim and execute the following command:](#5open-vimgvimgnvimnvim-and-execute-the-following-command)
    * [6,install some dependencies](#6install-some-dependencies)
    * [7,modify .vimrc](#7modify-vimrc)
    * [8,if you not want to use my recommended plugin. You can just do the following command](#8if-you-not-want-to-use-my-recommended-plugin-you-can-just-do-the-following-command)
* [(2)use some new command tools to replace old command tools](#2use-some-new-command-tools-to-replace-old-command-tools)
* [(3)add some tools](#3add-some-tools)
* [(4)close screensaver](#4close-screensaver)
* [(5)解决centos下非root用户频繁出现Authentication is required to set](#5解决centos下非root用户频繁出现authentication-is-required-to-set)
* [(6)解决没有root权限的普通用户使用vnc提示:](#6解决没有root权限的普通用户使用vnc提示)
* [(7)永久切换gcc/g++版本](#7永久切换gccg版本)
* [(8)自己启动自己的vnc](#8自己启动自己的vnc)
* [(9)永久切换git版本](#9永久切换git版本)
* [(10),默认浏览器和终端不需要vpn快速链接github](#10默认浏览器和终端不需要vpn快速链接github)
    * [也可以使用github代理](#也可以使用github代理)
* [(11)configure gdb](#11configure-gdb)
* [(12)use zinit, omz and zsh](#12use-zinit-omz-and-zsh)
* [(13)add new dynamic library](#13add-new-dynamic-library)
* [(14)configure multiple ssh keys](#14configure-multiple-ssh-keys)
    * [1,execute the following commands.](#1execute-the-following-commands)
    * [2,add the following content to config file.](#2add-the-following-content-to-config-file)
    * [3,execute the following commands.](#3execute-the-following-commands)
    * [4,add the content of id_rsa.gitee to your gitee accout.](#4add-the-content-of-id_rsagitee-to-your-gitee-accout)
    * [5,add the content of id_rsa.github to your github accout.](#5add-the-content-of-id_rsagithub-to-your-github-accout)
* [(15)服务器的Vivado无法识别fpga板子的解决方法：](#15服务器的vivado无法识别fpga板子的解决方法)
* [(16)configure your git](#16configure-your-git)
* [(17)install fonts for ourselves](#17install-fonts-for-ourselves)
* [(18)solve the problem which results in vnc work abnormally](#18solve-the-problem-which-results-in-vnc-work-abnormally)

<!-- vim-markdown-toc -->
#Note:
# (1) Configure vim/gvim/nvim/gnvim
## 1,login your account
```
ssh -X YourAccount@10.34.24.11
```
## 2,execute the following commands until it successes
a plugin which is used to manage other plugins of vim and whose name is vim-plug
```
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://ghproxy.com/https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://ghproxy.com/https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
```
## 3,copy configuration file from hxliang and add some configurations
```
cd ~
cp /home/hxliang/.vimrc ~/.vimrc
cp /home/hxliang/.vim/.vimspectorjson ~/.vim -r
cp /home/hxliang/.vim/coc-settings.json ~/.vim
cp /home/hxliang/.config/goneovim ~/.config/ -r
mkdir ~/.config/nvim -p
mkdir ~/Downloads/program/ -p
npm config set registry https://registry.npm.taobao.org/
cp /home/hxliang/Downloads/program/goneovim-linux/ ~/Downloads/program/ -r
gvim
```
execute the following commands in vim
```
:PlugInstall
```
Note:If the plugin of vim has some problems, you can uninstall it and reinstall it. Our plugins management plugin is vimplug.\ 
If Updating plugin failes, you may need to go to the ~/.vim/plugged/the_name_of_pluggin and execute "git stash" and "git stash clear" , then update it again.
## 4,add the following content to your .bashrc or .zshrc
```
# the gui of neovim
alias gnvim='~/Downloads/program/goneovim-linux/goneovim -p'
```
## 5,open vim/gvim/gnvim/nvim and execute the following command:
```
PlugInstall
```
If you can success in downloading the plugin, retry it until all plugin has been downloaded.\
Maybe iamcco/markdown-preview.nvim will have some problem, when you open md file and press key F2, you have to uninstall
iamcco/markdown-preview.nvim and download it again. If it downloaded failed, close vim/gvim/nvim and open vim/gvim/nvim againg then download it again.Redo it until it can download successfully.\
coc.nvim may have the same problem like iamcco/markdown-preview.nvim, you can do the same thing to solve it.
(第一个补全选项要么直接按enter要么按了tab选择好后直接继续打代码。)
如果想添加coc的补全拥有机械学习能力请参考coc-tabnine,缺点：耗内存和GPU,可能要钱.
## 6,install some dependencies
```
python3 -m pip config set global.index-url https://mirrors.cloud.tencent.com/pypi/simple
python3 -m pip install pysnooper ipdb
python3 -m pip install pylint yapf futures isort pygments cmake_format vim-vint cmakelang pyright
```
## 7,modify .vimrc
use "YourAccount" to replace "hxliang" in .vimrc
## 8,if you not want to use my recommended plugin. You can just do the following command
```
cp /home/hxliang/.vimrc.noplugin ~/.vimrc
```

# (2)use some new command tools to replace old command tools
```
# add the following to your .bashrc
if [ -d "/home-local/celab106_z2mini/.cargo/bin" ]; then
  export PATH=$PATH:/home-local/celab106_z2mini/.cargo/bin
fi
if [ -d "/home-local/celab106_z2mini/.local/.go/bin" ]; then
  export PATH=$PATH:/home-local/celab106_z2mini/.local/.go/bin
fi
if command -v zoxide >/dev/null 2>&1;then
  eval "$(zoxide init bash)"
fi
```
fd-find replaces find, command: fd
dust replaces du, command: dust
procs replaces ps, command: procs
bottom replaces top, command: btm
exa replaces ls, command: exa
zoxide replaces cd, command: z
ripgrep replaces grep, command: rg
bat replaces cat, command: bat
hyperfine replaces time, command: hyperfine
duf replaces df, command: duf
httpie replaces replaces curl and wget, command: http/https

# (3)add some tools
```
#cppman can help you know about c/c++ function
#you-get can download some videos from bilibili.com
#sphinx transform rst file to html file
python3 -m pip install cppman you-get sphinx sphinx-rtd-theme
```

# (4)close screensaver
查看vnc使用什么屏保程序
```
ps aux | grep screen
```
如果有则搜索linux如何关闭xxx的屏保，例如xscreensaver，没有则无需管理。
也可以参考下面这个第(6)点：
```
open Setting > Session and Startup > Application Autostart
Remove the check mark(√) of the item whose name has word "screensaver" and restart vnc.
```

# (5)解决centos下非root用户频繁出现Authentication is required to set
  非root用户登陆linux服务器，总是弹出一个对话框，而且关闭之后，过一段时间还会弹出来。对话框的内容是：Authentication is required to set the network proxy used for downloading packages。然后提示你输入root密码。 \
  解决办法：在终端窗口（右键，open in terminal）输入“gnome-session-properties”。然后把“PackageKit Update Applet”前面的勾去掉就行了或者换成xfce

# (6)解决没有root权限的普通用户使用vnc提示:
XFCE PolicyKit Agent \
GDBus.Error:org.freedesktop.PolickKit1.Error.Failed:An authentication agent already exists for the given subject.
```
open Setting > Session and Startup > Application Autostart
Remove the check mark(√) of XFCE PolKit(Policykit Authentication Agent)[In other systems, it may be called PolicyKit Authentication Agent(Policykit Authentication Agent)]
```

# (7)永久切换gcc/g++版本
11那台服务器已默认切换到gcc-9,g++-9版本。
```
#add the following content to your .bashrc or .zshrc(You only need to choose one)
#for gcc-7 g++-7
if [ -f "/opt/rh/devtoolset-7/enable" ]; then
  source /opt/rh/devtoolset-7/enable #or scl enable devtoolset-7 bash #only for .bashrc 
fi
#for gcc-9 g++-9
if [ -f "/opt/rh/devtoolset-9/enable" ]; then
  source /opt/rh/devtoolset-9/enable #or scl enable devtoolset-9 bash #only for .bashrc 
fi
#for gcc-11 g++-11
if [ -f "/opt/rh/devtoolset-11/enable" ]; then
  source /opt/rh/devtoolset-11/enable #or scl enable devtoolset-11 bash #only for .bashrc 
fi
```

# (8)自己启动自己的vnc
（有时候系统自动启动的vnc会黑屏，需要先用ssh登录到自己的用户，kill掉自己的vnc进程
再重新启动vnc） 
```
ssh -X UserAccount@10.34.24.11
ps -ef | grep vnc #找到自己用户名然后使用kill关掉
kill xxx #xxx为你自己的vnc进程，一般在第二列会有xxx这串数字。注意，第七列一般为你的vnc端口
vncserver :x -geometry 1920x1080 #x为端口
```
也可以使用这个命令代替kill xxx
```
vncserver -kill :x #其中x为你的vnc端口
```
如果是第一次启动vnc
```
ssh -X UserAccount@10.34.24.11
cd ~
mkdir .vnc
cp /home/hxliang/.vnc/xstartup ~/.vnc
vncserver :x -geometry 1920x1080 #x为端口,记得叫管理员打开防火墙的(5900+x)端口
```

# (9)永久切换git版本
11那台服务器已默认切换到git227版本。
```
#add the following content to your .bashrc or .zshrc
if [ -f "/opt/rh/rh-git227/enable" ]; then
  source /opt/rh/rh-git227/enable
fi
```

# (10),默认浏览器和终端不需要vpn快速链接github
（1）默认浏览器在linux使用firefox，在win10使用edge因为不用翻墙就能下载插件。\
（2）浏览器下载“Hoxx VPN Proxy”插件，这个插件可以帮助浏览器翻墙。(注册账号时的密码请使用不与你的钱有关系的密码) \
（3）浏览器下载“GitHub加速”插件，这个插件可以提供不需要翻墙就能快速链接github的网址：\
      1）打开某一github仓库 \
      2）点击网页上的加速按钮，这个按钮会提供四个网址，前三个是用于克隆别人的仓库的，使用的是HTTPS协议。由于github现在只允许使用SSH协议上传仓库，所以前三个网址只能用于克隆仓库，如果既需要克隆仓库也需要上传文件到仓库，需要使用第四个网址，第四个网址用于代替github的code按钮所提供的网址。\
      3）因为加速按钮前三个网址是别人提供的，有时由于未知力量可能会导致某一个或者某两个网址用不了，此时只需要把已克隆的本地仓库文件里面的.git/config的url更改为可以用的那个网址即可。
## 也可以使用[github代理](https://ghproxy.com/)

# (11)configure gdb
```
cd ~/Downloads/program
git clone https://github.com/hugsy/gef.git
python3 -m pip install keystone-engine unicorn capstone ropper
cp /home/hxliang/.gdbinit ~
cp /home/hxliang/.gdbgef ~ #only use for gdb command line.
```

# (12)use zinit, omz and zsh
```
mkdir -p ~/.local/share
cp /home/hxliang/.local/share/zinit ~/.local/share -r
cp /home/hxliang/.oh-my-zsh ~
cp /home/hxliang/.zshrc ~
```
Ask your 10.34.24.11 administrators to do the following things \
Note: 可能会导致该用户在vnc时执行/etc/profile文件失效。因为/etc/profile只会在用户登录时执行一次，shell的切换可能会导致ldap用户执行失效。解决办法，手动关闭vnc再重启。
```
ssh -X root@10.34.24.11
id hxliang #check the uid and gid
gvim /etc/passwd
```
add the following content to passwd
```
hxliang:x:1000004:1000001:hxliang:/home/hxliang:/usr/local/bin/zsh
```
1000004 is hxliang's uid. 1000001 is hxliang's gid(Maybe same)

# (13)add new dynamic library
add the following content to your .bashrc or .zshrc
```
LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib
```

# (14)configure multiple ssh keys
## 1,execute the following commands.
```
mkdir ~/.ssh -p
cd ~/.ssh
ssh-keygen -t rsa -b 4096 -f id_rsa.github -C "YourEmail"
ssh-keygen -t rsa -b 4096 -f id_rsa.gitee -C "YourEmail"
gvim config
```
## 2,add the following content to config file.
```
# ------------ 配置说明（始） ------------
# Host：别名，HostName：服务器域名或 IP 地址
# User：用户名
# 例：在 git clone git@github.com:torvalds/linux.git 中
# User 是 git，Host 是 github.com
# IdentityFile：私钥路径
# ------------ 配置说明（末） ------------
 


# ------------ 具体配置（始） ------------
# GitHub
Host github.com
HostName github.com
User git
PreferredAuthentications publickey
IdentityFile ~/.ssh/id_rsa.github

 

# Gitee
Host gitee.com
HostName gitee.com
User git
PreferredAuthentications publickey
IdentityFile ~/.ssh/id_rsa.gitee
# ------------ 具体配置（末） ------------
```
## 3,execute the following commands.
```
chmod 700 ~/.ssh
chmod 600 config id_rsa.gitee id_rsa.github
chmod 644 id_rsa.gitee.pub id_rsa.github.pub
```
## 4,add the content of id_rsa.gitee to your gitee accout.
## 5,add the content of id_rsa.github to your github accout.

# (15)服务器的Vivado无法识别fpga板子的解决方法：
(There is no active target available for server at localhost.) \
安装JTAG驱动。
```
cd /cadtools/Xilinx/2022.1/Vivado/2022.1/data/xicom/cable_drivers/lin64/install_script/install_drivers
sudo ./install_drivers 
```
安装完成后需要重新插拔JTAG。

# (16)configure your git
```
git config --global user.name "YourName"
git config --global user.email "YourEmail(NotUseSchoolEmailWhichWillBeExpiredAfterYourGraduation)"
git config --global alias.logline "log --graph --abbrev-commit"
git config --global core.editor gvim
git config --global protocol.https.allow always
git config --global push.default "current"
git config --global diff.tool gvimdiff
#23年后下面这个梯子不知为啥挂掉了，请别执行下面这条命令，除非你尝试过梯子复活了
#git config --global url."https://github.91chi.fun//https://github.com/".insteadOf "https://github.com/"
```

# (17)install fonts for ourselves
```
#去https://www.nerdfonts.com/font-downloads下载自己喜欢的字体，以DejaVuSansMono,FantasqueSansMono,InconsolataLGC字体为例
unzip DejaVuSansMono.zip FantasqueSansMono.zip InconsolataLGC.zip #解压文件
mkdir ~/.fonts -p
cd ~/.fonts
cp -r ~/Downloads/program/font/FantasqueSansMono ~/Downloads/program/font/DejaVuSansMono ~/Downloads/program/font/InconsolataLGC .
chmod 755 DejaVuSansMono FantasqueSansMono InconsolataLGC -R
fc-cache -fv
```

# (18)solve the problem which results in vnc work abnormally
```
cp /home/lylai/.vnc ~ -r
vncserver -kill :端口号
cd ~/.vnc
rm *.pid *.log
vncserver :端口号
```
