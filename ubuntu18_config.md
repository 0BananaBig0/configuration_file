<!-- vim-markdown-toc GFM -->

* [1,本Ubuntu使用了terminator代替了terminal](#1本ubuntu使用了terminator代替了terminal)
* [2,本Ubuntu使用了zsh代替了bash](#2本ubuntu使用了zsh代替了bash)
* [3,本Ubuntu使用了zinit和oh-my-zsh](#3本ubuntu使用了zinit和oh-my-zsh)
    * [zsh](#zsh)
    * [安装omz](#安装omz)
    * [安装zinit](#安装zinit)
* [4,本Ubuntu的vim插件管理器使用vim-plug,这个是截止2021年6月17日位置最快的插件管理器,没有之一。具体插件内容,请看.vimrc.](#4本ubuntu的vim插件管理器使用vim-plug这个是截止2021年6月17日位置最快的插件管理器没有之一具体插件内容请看vimrc)
    * [Install vim-plug](#install-vim-plug)
    * [Install dein.vim](#install-deinvim)
    * [python-mode出问题解决方法](#python-mode出问题解决方法)
* [5,compile and install lua, vim, neovim](#5compile-and-install-lua-vim-neovim)
    * [(0)remove vim and neovim](#0remove-vim-and-neovim)
    * [(1)compile and install lua](#1compile-and-install-lua)
    * [(2)compile and install vim](#2compile-and-install-vim)
    * [(3) compile and install neovim](#3-compile-and-install-neovim)
    * [(4)建立符号链接](#4建立符号链接)
* [6,本Ubuntu的nodejs版本使用下面的方法安装,版本已最新。](#6本ubuntu的nodejs版本使用下面的方法安装版本已最新)
* [7,本Ubuntu安装的软件](#7本ubuntu安装的软件)
    * [安装ctags:](#安装ctags)
    * [安装gtags:](#安装gtags)
    * [安装iverilog](#安装iverilog)
    * [安装verilator:](#安装verilator)
    * [安装最新版smplayer:](#安装最新版smplayer)
* [8,本Ubuntu的coc.nvim插件安装了](#8本ubuntu的cocnvim插件安装了)
* [9,本Ubuntu安装了gnome-tweaks,安装了如下插件：](#9本ubuntu安装了gnome-tweaks安装了如下插件)
* [10,cd .config/sogoupinyin/conf隐藏搜狗拼音状态栏](#10cd-configsogoupinyinconf隐藏搜狗拼音状态栏)
* [11,安升级CMake和gcc以及g++,valgrind](#11安升级cmake和gcc以及gvalgrind)
* [12,vim/gvim更换python版本支持或更换vim/gvim版本](#12vimgvim更换python版本支持或更换vimgvim版本)
* [13,安装llvm](#13安装llvm)
    * [添加llvm源](#添加llvm源)
* [14,coc-nvim找不到头文件的解决办法：](#14coc-nvim找不到头文件的解决办法)
    * [对于cmake和catkin:](#对于cmake和catkin)
    * [对于make:](#对于make)
        * [Installation](#installation)
* [15,解决双系统ubuntu没有挂载硬盘写入权限的方法：如果win10那边提示要修复硬盘,不用管,否则ubuntu会没有读写权限。](#15解决双系统ubuntu没有挂载硬盘写入权限的方法如果win10那边提示要修复硬盘不用管否则ubuntu会没有读写权限)
* [16,更换python的方法和安装debug工具](#16更换python的方法和安装debug工具)
* [17,关闭dash-to-panel的hot-corners的方法：鼠标左上角](#17关闭dash-to-panel的hot-corners的方法鼠标左上角)
* [18,正常关闭tweak的hot-corners的方法：](#18正常关闭tweak的hot-corners的方法)
* [19,添加nvidia显卡驱动源,安装nvidia显卡官方驱动](#19添加nvidia显卡驱动源安装nvidia显卡官方驱动)
* [20,更改core file size](#20更改core-file-size)
* [21,动态库被截断的原因](#21动态库被截断的原因)
* [22,安装qbittorrent](#22安装qbittorrent)
* [23,尽量使用openjdk,因为cuda默认使用openjdk](#23尽量使用openjdk因为cuda默认使用openjdk)
* [23,gvim or matlab启动时xxx/canberra-gtk-module打开失败:](#23gvim-or-matlab启动时xxxcanberra-gtk-module打开失败)
* [24,解决安装后ubuntu18.04后出现Unable to download updates from extensions.gnome.org的问题](#24解决安装后ubuntu1804后出现unable-to-download-updates-from-extensionsgnomeorg的问题)
* [25,安装文泉驿和Nerd字体](#25安装文泉驿和nerd字体)
    * [安装文泉驿#本人已不再用文泉驿字体](#安装文泉驿本人已不再用文泉驿字体)
    * [安装,DejaVuSansMonoFantasqueSansMono Nerd Font,UbuntuMono Nerd,InconsolataLGC字体](#安装dejavusansmonofantasquesansmono-nerd-fontubuntumono-nerdinconsolatalgc字体)
* [26,创建smb服务](#26创建smb服务)
* [27,禁用ibus](#27禁用ibus)
* [28,设置静态ip](#28设置静态ip)
* [29,查看带宽：ethtool 网络接口名](#29查看带宽ethtool-网络接口名)
* [30,安装cuda,看官网即可,这个会自动安装openjdk-11](#30安装cuda看官网即可这个会自动安装openjdk-11)
* [31,安装cudnn和tensorrt,看官网即可](#31安装cudnn和tensorrt看官网即可)
* [32,安装opencv过程,先安装cudnn,cuda,显卡驱动,tensorrt](#32安装opencv过程先安装cudnncuda显卡驱动tensorrt)
    * [Download and unpack sources](#download-and-unpack-sources)
    * [Create build directory and switch into it](#create-build-directory-and-switch-into-it)
    * [由于某些未知力量的原因，可能会导致opencv4某些模块下载失败，要多次进行cmake，但是这样太过费时，所以可以使用代理解决，这里以常见的失败模块IPPICV为例子](#由于某些未知力量的原因可能会导致opencv4某些模块下载失败要多次进行cmake但是这样太过费时所以可以使用代理解决这里以常见的失败模块ippicv为例子)
    * [由于某些未知力量，face_landmark_model.dat可能会下载失败，解决办法:](#由于某些未知力量face_landmark_modeldat可能会下载失败解决办法)
    * [Install tensorflow](#install-tensorflow)
* [33,安装docker](#33安装docker)
* [34,解决hds和vsim打开时字体缺失报错问题。](#34解决hds和vsim打开时字体缺失报错问题)
* [35,设置默认pip以及换源](#35设置默认pip以及换源)
* [36,goldendict配置大全](#36goldendict配置大全)
* [37,sudo update-initramfs -u缺失 /lib/firmware/i915/xxx.bin for module i915](#37sudo-update-initramfs--u缺失-libfirmwarei915xxxbin-for-module-i915)
* [38,更改ubuntu18切换窗口快捷键以及关闭自动弹出网络登录窗口](#38更改ubuntu18切换窗口快捷键以及关闭自动弹出网络登录窗口)
* [39,修改系统硬盘分配](#39修改系统硬盘分配)
* [40,vmworkstation激活码](#40vmworkstation激活码)
* [41,安装bazel和svlangserver和verible](#41安装bazel和svlangserver和verible)
    * [Install bazel](#install-bazel)
    * [Install svlangserver](#install-svlangserver)
* [42,解决verilog找不到模块问题,coc-nvim使用iverilog,verilator](#42解决verilog找不到模块问题coc-nvim使用iverilogverilator)
* [43,C/C++/python debug工具以及配置.gdbinit](#43ccpython-debug工具以及配置gdbinit)
    * [configure gdb](#configure-gdb)
* [44,如何卸载XDM](#44如何卸载xdm)
* [45,使用sshfs远程挂载目录:](#45使用sshfs远程挂载目录)
* [46,安装打印机驱动](#46安装打印机驱动)
* [47,kazam录屏降噪：](#47kazam录屏降噪)
* [48,markdown(缩写为md)文件转docx或pdf工具](#48markdown缩写为md文件转docx或pdf工具)
* [49,sudo update-initramfs -u报UUID RESUME](#49sudo-update-initramfs--u报uuid-resume)
* [50,出现的错误 W: Possible missing firmware /lib/firmware/rtl_nic/rtl8125a-3.fw for…](#50出现的错误-w-possible-missing-firmware-libfirmwarertl_nicrtl8125a-3fw-for)
* [51,开机自动挂载win10硬盘](#51开机自动挂载win10硬盘)
* [52,关于ubuntu18掉帧的解决方法](#52关于ubuntu18掉帧的解决方法)
* [中文字体渲染问题解决方法：](#中文字体渲染问题解决方法)
* [53,关于vim离开搜索模式取消中文输入法](#53关于vim离开搜索模式取消中文输入法)
* [54,解决ubuntu18,remmina经常崩溃的办法](#54解决ubuntu18remmina经常崩溃的办法)
* [55,关于vim显示符号乱码问题](#55关于vim显示符号乱码问题)
* [56,如果因为indentLine插件导致json文件的引号被隐藏,可以做以下操作](#56如果因为indentline插件导致json文件的引号被隐藏可以做以下操作)
* [57,install go language and goneovim](#57install-go-language-and-goneovim)
    * [install go language](#install-go-language)
    * [更换go的镜像源,在.bashrc或.zshrc中加入下面这个](#更换go的镜像源在bashrc或zshrc中加入下面这个)
    * [install goneovim](#install-goneovim)
* [58,卸载envice,因为有时候会莫名奇妙在后台跑起来,占用大量cpu。](#58卸载envice因为有时候会莫名奇妙在后台跑起来占用大量cpu)
* [59,一些小工具](#59一些小工具)
    * [查看cpp手册工具](#查看cpp手册工具)
    * [类图生成工具](#类图生成工具)
    * [ipad通过airplay投屏到ubuntu18](#ipad通过airplay投屏到ubuntu18)
    * [ubuntu18投屏到ipad（还没进行测试）](#ubuntu18投屏到ipad还没进行测试)
    * [安装下载B站视频小工具you-get](#安装下载b站视频小工具you-get)
    * [钉钉](#钉钉)
    * [rst file to html file](#rst-file-to-html-file)
    * [use httpie to replace replace curl and wget](#use-httpie-to-replace-replace-curl-and-wget)
* [60,安装rust和一些新的命令行工具](#60安装rust和一些新的命令行工具)
* [61,修复sudo apt update出现错误：](#61修复sudo-apt-update出现错误)
* [62,如何确定系统所用屏保软件](#62如何确定系统所用屏保软件)
* [63,gnome文件的默认打开方式的配置文件](#63gnome文件的默认打开方式的配置文件)
* [64,解决nfs挂载硬盘普通用户没有访问权限问题](#64解决nfs挂载硬盘普通用户没有访问权限问题)
* [65,使独立显卡仅用于计算，显示全交给英特尔集显](#65使独立显卡仅用于计算显示全交给英特尔集显)
* [66,更新git](#66更新git)
* [67,add new dynamic library](#67add-new-dynamic-library)
* [68,install rr debugger](#68install-rr-debugger)
* [69,解决有线网无法正常使用的问题](#69解决有线网无法正常使用的问题)
    * [(1) netword-managed无法正常使用](#1-netword-managed无法正常使用)
    * [(2) ubuntu 18.04系统，有线网无法连接，无线网可以正常连接；](#2-ubuntu-1804系统有线网无法连接无线网可以正常连接)
* [70,install opencl intel runtime(2.0)](#70install-opencl-intel-runtime20)
* [71,install opencl intel runtime(2.2)(21.38.21026)](#71install-opencl-intel-runtime22213821026)
* [72,add shell environment variables](#72add-shell-environment-variables)
* [73,compile duf to replace df](#73compile-duf-to-replace-df)
* [74,configure multiple ssh keys](#74configure-multiple-ssh-keys)
    * [(1) execute the following commands.](#1-execute-the-following-commands)
    * [(2) add the following content to config file.](#2-add-the-following-content-to-config-file)
    * [(3) execute the following commands.](#3-execute-the-following-commands)
    * [(4) add the content of id_rsa.gitee to your gitee accout.](#4-add-the-content-of-id_rsagitee-to-your-gitee-accout)
    * [(5) add the content of id_rsa.github to your github accout.](#5-add-the-content-of-id_rsagithub-to-your-github-accout)
* [75 关于主目录下突然出现一个javasharedresources目录](#75-关于主目录下突然出现一个javasharedresources目录)
* [76 install and use kvm](#76-install-and-use-kvm)
    * [(1) install kvm](#1-install-kvm)
    * [(2) create a virtual machine](#2-create-a-virtual-machine)
* [77 configure perl LSP](#77-configure-perl-lsp)
* [78 configure fcitx](#78-configure-fcitx)
* [79 install YaHeiConsolas](#79-install-yaheiconsolas)
* [80 install brave browser](#80-install-brave-browser)
* [81 install zotero](#81-install-zotero)
* [82 install a json formatter](#82-install-a-json-formatter)
* [83 use neovim as a backend of vscode](#83-use-neovim-as-a-backend-of-vscode)
* [83 latexmk](#83-latexmk)

<!-- vim-markdown-toc -->
最先换源和安装好所有需要的ppa源和deb源(cuda,tensorrt),接着优先安装gcc,g++,jdk,zsh,zinit,llvm,更换默认pip为pip3,使用pip下载pylint.现在ubuntu安装不同的包都会在/bin或/usr/bin或/usr/local/bin等那些地方安装可执行文件并带有版本号,使用时要么输入有版本号的命令,要么使用update-alternatives来管理符号链接.可去到bin文件夹ls xxx*来看有多少个版本的xxx软件。\
Zinit omz vim-plug的安装仅对当前用户有效,如果想要对root用户有效,请进入root用户再安装。 \
使用npm和yarn时全部在普通用户下使用sudo,npm使用时添加-g,除了vim-plug使用yarn安装vim插件外,尽量不要使用yarn,虽然它比npm下载安装更友善,但是安装位置以及配置文件的位置管理的一塌糊涂。

# 1,本Ubuntu使用了terminator代替了terminal
这两个都是虚拟终端,用于传输来自键盘的信息给shell,把接受来自shell的信息传输给屏幕。terminator的好处是拥有分屏功能。
```
sudo apt install terminator
```
添加右键打开terminator工具
```
sudo add-apt-repository ppa:daniel-marynicz/filemanager-actions
sudo apt install filemanager-actions-nautilus-extensionfma-config-tool
fma-config-tool
```
1)新建action
命名：Open in Terminator
在Action标签页勾选"Display item in location context menu"
在Command标签页填写Path:/usr/bin/terminator,parameters:--working-directory=%d/%b
2)配置Preferences
取消勾选"Create a root 'FileManager-Action' menu"

# 2,本Ubuntu使用了zsh代替了bash
这两个都是shell的一种,是一种命令行解释器,接受来自终端的信息,然后经过解释传输给内核,内核再把硬件执行结果的信息传输给shell,shell再反馈给终端,终端再再在屏幕显示信息。

# 3,本Ubuntu使用了zinit和oh-my-zsh
zinit和oh-my-zsh(必选,主要是我使用了ys主题和incr插件,zinit那边配置incr插件速度很慢,但是其它插件很快。暂时还不知道怎么在zinit那边配置ys主题,不过zinit有自己的主题,如果不需要ys主题和incr插件,应该可以不用安装oh-my-zsh)。zinit的作用主要是加速启动终端和shell,其原理是代替oh-my-zsh加载插件的方式,把所有插件编译成二进制码并且延后启动,以加速终端和shell的启动。在本人电脑中,终端和shell的启动速度在0.2s以内。zinit是截止2021年6月17日为止最快的zsh插件管理器,没有之一。
## zsh
```
sudo apt install zsh
chsh -s /bin/zsh
sudo chsh -s /bin/zsh
reboot
```
## 安装omz
```
sudo apt install git
git config --global user.name "Huaxiao Liang"
git config --global user.email "1184903633@qq.com"
git config --global alias.logline "log --graph --abbrev-commit"
git config --global core.editor gvim
#23年后下面这个梯子不知为啥挂掉了，请别执行下面这条命令，除非你尝试过梯子复活了
#git config --global url."https://github.91chi.fun//https://github.com/".insteadOf "https://github.com/"
git config --global protocol.https.allow always
git config --global push.default "current"
git config --global diff.tool gvimdiff
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```
## 安装zinit
```
sh -c "$(curl -fsSL https://git.io/zinit-install)"
```
# 4,本Ubuntu的vim插件管理器使用vim-plug,这个是截止2021年6月17日位置最快的插件管理器,没有之一。具体插件内容,请看.vimrc.
## Install vim-plug
```
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://ghproxy.com/https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://ghproxy.com/https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
python3 -m pip install pylint yapf futures isort pygments cmake_format vim-vint cmakelang pyright # hdl_checker 
```
## Install dein.vim
可以试试dein.vim(https://github.com/Shougo/dein.vim) \
经测试还没有vim-plug和vim的timer延迟以及if和autocmd进行组合来的速度快。\
延迟加载技巧：\
（1）命令触发加载,这种直接利用vim-plug提供的on功能即可。\
（2）按类型加载,有部分插件可以利用vim-plug提供的for功能实现按类型加载,有部分不行,这时可以
试试自己利用if和vim-plug提供的plug#load以及{'on':[]}功能实现按类型加载。\
（3）延迟加载,利用vim提供的延迟机制和vim-plug提供的plug#load以及{'on':[]}功能即可实现。\
（4）延迟按需加载,if,vim延迟,plug#load,{'on':[]}即可实现。\
（5）个人配置延迟加载,vim延迟和function。\
延迟加载注意事项：\
（1）不是所有插件都支持延迟加载,例如会明显改变启动界面的主题,语法高亮等。\
（2）不是所有配置都应该弄成延迟加载,例如set number这种明显改变界面的,set linespace=0这种造成界面
刷新的,set noswapfile这种造成仅仅输入gvim显示白屏的就不适合延迟加载。\
（3）有些插件如果延迟加载,那么其配置也要延迟加载例如vim-quickui。\
（4）如果使用autocmd延迟加载或者做某种事情,一定要注意事件选择,因为autocmd是事件发生就会完成一件事
这可能会造成使用快捷键时有种不流畅感觉,例如,如果添加了autocmd CmdwinLeave ...有可能导致用插件注释代码
时有种不流畅感。同时要注意autocmd的事件选择,如果延迟加载autocmd的命令可能会导致被延迟加载项加载失败。
```
curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
# 安装路径我们选择：~/.vim/dein
sh ./installer.sh ~/.vim/dein
```
```
if &compatible
    set nocompatible
endif
let s:dein_path = '~/.vim/dein'
" Add the dein installation directory into runtimepath
let &runtimepath = &runtimepath.','.s:dein_path.'/repos/github.com/Shougo/dein.vim'
if dein#load_state(s:dein_path)
  call dein#begin(s:dein_path)
  call dein#add(s:dein_path.'/repos/github.com/Shougo/dein.vim')
  " install third-party plugins
  " call dein#add('tpope/vim-surround')
  call dein#end()
  call dein#save_state()
endif
filetype plugin indent on
syntax enable
```
https://www.jianshu.com/p/0874e6be9d74
## python-mode出问题解决方法
If you are trying to update the plugin (using a plugin manager or manually) and you are seeing an error such as: \
Server does not allow request for unadvertised object \
Then we probably changed some repo reference or some of our dependencies had a git push --force in its git history. So the best way for you to handle it is to run, inside the python-mode directory:
```
git submodule update --recursive --init --force
git submodule sync --recursive
```

# 5,compile and install lua, vim, neovim
## (0)remove vim and neovim
```
sudo apt install ppa-purge -y
sudo ppa-purge ppa:jonathonf/vim
sudo add-apt-repository --remove ppa:jonathonf/vim
sudo ppa-purge ppa:neovim-ppa/stable
sudo add-apt-repository --remove ppa:neovim-ppa/stable
sudo apt purge *vim* -y
sudo apt autoremove --purge
sudo apt autoclean
sudo rm /usr/share/vim /var/lib/vim -r
dpkg -l | grep vim
```
## (1)compile and install lua
```
sudo apt install libreadline-dev
cd ~/Downloads/program
wget http://www.lua.org/ftp/lua-5.3.6.tar.gz
x lua-5.3.6.tar.gz
cd lua-5.3.6
make linux
sudo make install INSTALL_TOP=/usr # INSTALL_TOP is a variable of a Makefile of this project
```
Note: In ubuntu18, the path of lua header and library files are different from where vim wants to find.
## (2)compile and install vim
```
sudo apt install libncurses5-dev python-dev python3-dev \
                 libgtk2.0-dev libatk1.0-dev libbonoboui2-dev \
                 libcairo2-dev libx11-dev libxpm-dev libxt-dev \
                 libgnome2-dev libgnomeui-dev ruby-dev libperl-dev \
                 tcl tcl-dev libgpm-dev libgpm2 gpm -y
cd ~/Downloads/program
git clone https://github.com/vim/vim.git
cd vim
./configure --prefix=/usr \
            --with-features=huge \
            --enable-fail-if-missing \
            --enable-luainterp=yes \
            --enable-mzschemeinterp \
            --enable-perlinterp=yes \
            --enable-pythoninterp=yes \
            --with-python-config-dir=/usr/lib/python2.7/config-x86_64-linux-gnu \
            --enable-python3interp=yes \
            --with-python3-config-dir=/usr/lib/python3.6/config-3.6m-x86_64-linux-gnu \
            --enable-tclinterp=yes \
            --enable-rubyinterp=yes \
            --enable-cscope \
            --enable-terminal \
            --enable-autoservername \
            --enable-multibyte \
            --enable-xim \
            --enable-fontset --enable-gpm=yes \
            --enable-gui=gtk2 \
            --with-x \
            --with-compiledby="Banana" \
            # 请注意：把 config-3.6m-x86_64-linux-gnu 这个目录换成你自己的,就是你的操作系统自带的 \
            # python3 的 config 目录,/usr/lib/python3.6/config-3.6m-x86_64-linux-gnu 这个是我的目录, \
            # 跟你的可能不一样,请自行查找.
make
sudo make install
sudo ln -s /usr/bin/vim /usr/bin/vi
```
## (3) compile and install neovim
```
sudo apt install python3.8 -y
sudo apt install xclip -y
sudo apt install ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip curl doxygen -y
cd ~/Downloads/program
git clone https://github.com/neovim/neovim.git
cd neovim
git checkout stable
make CMAKE_BUILD_TYPE=Release CMAKE_INSTALL_PREFIX=/usr #repeat until success
sudo make install
sudo su
npm install -g neovim
gem install neovim
python3.8 -m pip install neovim
exit
```
## (4)建立符号链接
使nvim和vim共享配置,注意在判断文件类型哪里nvim不允许==两边参数存在空格,vim和nvim的set配置也不许=左右两边的参数存在空格,但是let的语法允许
```
mkdir /home/banana/.config/nvim -p
sudo su
mkdir /root/.config/nvim -p
ln -s /root/.vim/coc-settings.json /root/.config/nvim/coc-settings.json
ln -s /root/.vimrc /root/.config/nvim/init.vim
```
觉得vim配置麻烦,可以使用vscode,vscode-neovim,这样的话neovim可以作为vscode的后端,用来编辑代码,又能使用IDE的插件。\
如果不想用vscode,可以试试spacevim或者exvim。

# 6,本Ubuntu的nodejs版本使用下面的方法安装,版本已最新。
https://blog.csdn.net/g8433373/article/details/95812821
```
sudo apt remove --purge nodejs cmdtest npm #(安装nodejs会自己安装npm)
```
(PS:cmdtest会在/usr/bin创建一个名叫yarn以及名叫cmdtest的可执行程序,目测这两个可执行程序功能一致,所以如果要安装yarn,要么卸载cmdtest要么删掉cmdtest创建的yarn可执行程序)
```
sudo apt autoremove
sudo apt autoclean
sudo apt install -f
sudo apt install curl
curl -sL https://deb.nodesource.com/setup_16.x | sudo -E bash -
sudo apt install -y nodejs
sudo npm config set registry https://registry.npmmirror.com -g
sudo npm config set coc.nvim:registry https://registry.npmmirror.com -g
sudo npm install -g yarn
```

# 7,本Ubuntu安装的软件
主题解压后的目录放到/usr/share/themes/ \
图标目录放到/usr/share/icons/ \
锁屏壁纸放到/usr/share/backgroups/(要记得修改图片文件权限为755),并修改/etc/alternatives/gdm3.css \
grub主题目录放在/boot/grub/themes \
gdm3.css修改前
```
#lockDialogGroup {
  background: #2c001e url(resource:///org/gnome/shell/theme/noise-texture.png);
  background-repeat: repeat; }
```
gdm3.css修改后
```
#lockDialogGroup {
  background: #2c001e url(file:///usr/share/backgrounds/gundam.png);
  background-repeat: no-repeat;
  background-size: cover;
  background-position: center; }
```
登录界面主题目录务必放在/usr/share/plymouth/themes/(自ubuntu16后登录界面主题不再在/var文件夹里面,所以下载旧版主题时,请别直接安装。如果直接安装会导致桌面字体显示产生bug—每次开机或重启自动变小。)。\
使用apt安装的安装的软件有：calibre(记得修改library的位置到.config/calibre/calibre_library中),nfs-common,clinfo,
gnome-tweaks,smplayer, firefox,terminator,p7zip-full,rename,kazam(记得调录制麦克风以及喇叭声音的大小,降噪操作请看第47点),
gtkwave,doxygen,graphviz,remmina\*(注：remmina的桌面快捷方式需要先用文本编辑器打开把—connect U%删掉才能正常使用),
图片编辑器gimp,goldendict(先查看第36条内容再安装), chromium-browser,zathura\* \
源码编译安装的软件: gnu global,universal-ctags,verilator,iverilog,vim,lua\
deb包安装的软件：dingding,百度云,腾讯会议, 欧路词典，每日英语听力，easyconnect,master-pdf,网易云,nvim,tencentmeeting,wps,zhumuintl,vscode\
##安装ctags:
```
sudo apt install -y libncurses5-dev autogen automake libjansson-dev
git clone https://github.com/universal-ctags/ctags.git
cd ctags
./autogen.sh
./configure --prefix=/where/you/want # defaults to /usr/local
make
sudo make install # may require extra privileges depending on where to install
```
##安装gtags:
```
去https://mirrors.aliyun.com/gnu/global/下载global-6.6.8.tar.gz
x global-6.6.8.tar.gz #x为解压命令
cd ../global-6.6.8
sudo apt install ncurses-devel -y
./configure
make
make check
sudo make install
make installcheck
```
如果gtags不工作,删除.cache/tags/ ,再重新打开。
##安装iverilog
```
sudo apt purge iverilog
git clone https://github.com.cnpmjs.org/steveicarus/iverilog.git
cd iverilog
sudo apt install make bison flex gperf readline-common
sh autoconf.sh
./configure
make
make check
sudo make install
```
##安装verilator:
```
git clone https://github.com/verilator/verilator.git
sudo apt install git perl python3 make autoconf g++ flex bison ccache
sudo apt install libgoogle-perftools-dev numactl perl-doc
sudo apt install libfl2 # Ubuntu only (ignore if gives error)
sudo apt install libfl-dev # Ubuntu only (ignore if gives error)
sudo apt install zlibc zlib1g zlib1g-dev # Ubuntu only (ignore if gives error)
cd verilator
unset VERILATOR_ROOT
git checkout stable
autoconf
./configure
make
sudo make install
```
##安装最新版smplayer:
```
sudo add-apt-repository ppa:rvm/smplayer
sudo apt install smplayer smtube smplayer-themes smplayer-skins mpv
```
Re: smplayer全屏当鼠标移动到屏幕底部,出现控制条时就闪屏:\
(1)多媒体驱动问题,把驱动更改为mpv即可 \
(2)compiz 设置问题:到compizconfig的 常规选项-》常规 ,把 取消重定向全屏窗口 取消选择就好了 \
(3)使用cuda和x11

# 8,本Ubuntu的coc.nvim插件安装了
coc-word,coc-markdownlint coc-vimlsp,coc-dictionary,coc-tag,coc-cmake,coc-sh,coc-css,coc-json,coc-pyright,coc-yaml,coc-snippets (第一个补全选项要么直接按enter要么按了tab一会儿后再按enter否则补全会有问题)
如果想添加coc的补全拥有机械学习能力请参考coc-tabnine,缺点：耗内存和GPU,可能要钱。

# 9,本Ubuntu安装了gnome-tweaks,安装了如下插件：
```
sudo apt install chrome-gnome-shell
#查看gnome版本方便后续安装扩展
gnome-shell --version
gnome-tweak --version
```
gnome-shell-extension-dash-to-panel (别用ubuntu18的apt安装会造成字体异常和hotconcern异常,使用谷歌/火狐浏览器插件安装比较好)
```
sudo apt purge  gnome-shell-extension-ubuntu-dock
sudo apt purge  gnome-shell-extension-appindicators*
```
上面这两个扩展会和下面这个产生冲突。\
gnome-shell-extension-trayicons \
gsettings set org.gnome.shell enable-hot-corners false(禁止鼠标左上角列出窗口)\
看第18条

# 10,cd .config/sogoupinyin/conf隐藏搜狗拼音状态栏

# 11,安升级CMake和gcc以及g++,valgrind
```
wget -O - https://apt.kitware.com/keys/kitware-archive-latest.asc 2>/dev/null | sudo apt-key add -
sudo apt-add-repository 'deb https://apt.kitware.com/ubuntu/ bionic main'
sudo add-apt-repository ppa:ubuntu-toolchain-r/test
sudo apt update
sudo apt upgrade
sudo apt install gcc-7 g++-7 gcc-8 g++-8 gcc-9 g++-9 gcc-10 g++-10 gcc-11 g++-11
sudo apt install  gcc-9* g++-9* gcc-10* g++-10* gcc-11* g++-11*  gdb* ddd*
sudo apt  install valgrind
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-7 100
sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-7 100
sudo update-alternatives --install /usr/bin/gcc-ar gcc-ar /usr/bin/gcc-ar-7 100
sudo update-alternatives --install /usr/bin/gcc-nm gcc-nm /usr/bin/gcc-nm-7 100
sudo update-alternatives --install /usr/bin/gcc-ranlib gcc-ranlib /usr/bin/gcc-ranlib-7 100

sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-8 100
sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-8 100
sudo update-alternatives --install /usr/bin/gcc-ar gcc-ar /usr/bin/gcc-ar-8 100
sudo update-alternatives --install /usr/bin/gcc-nm gcc-nm /usr/bin/gcc-nm-8 100
sudo update-alternatives --install /usr/bin/gcc-ranlib gcc-ranlib /usr/bin/gcc-ranlib-8 100

sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-9 100
sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-9 100
sudo update-alternatives --install /usr/bin/gcc-ar gcc-ar /usr/bin/gcc-ar-9 100
sudo update-alternatives --install /usr/bin/gcc-nm gcc-nm /usr/bin/gcc-nm-9 100
sudo update-alternatives --install /usr/bin/gcc-ranlib gcc-ranlib /usr/bin/gcc-ranlib-9 100

sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-10 100
sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-10 100
sudo update-alternatives --install /usr/bin/gcc-ar gcc-ar /usr/bin/gcc-ar-10 100
sudo update-alternatives --install /usr/bin/gcc-nm gcc-nm /usr/bin/gcc-nm-10 100
sudo update-alternatives --install /usr/bin/gcc-ranlib gcc-ranlib /usr/bin/gcc-ranlib-10 100

sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-11 100
sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-11 100
sudo update-alternatives --install /usr/bin/gcc-ar gcc-ar /usr/bin/gcc-ar-11 100
sudo update-alternatives --install /usr/bin/gcc-nm gcc-nm /usr/bin/gcc-nm-11 100
sudo update-alternatives --install /usr/bin/gcc-ranlib gcc-ranlib /usr/bin/gcc-ranlib-11 100

sudo update-alternatives --config gcc
sudo update-alternatives --config g++
sudo update-alternatives --config gcc-ar
sudo update-alternatives --config gcc-nm
sudo update-alternatives --config gcc-ranlib
sudo apt install build-essential cmake python3-dev
```

# 12,vim/gvim更换python版本支持或更换vim/gvim版本
```
sudo update-alternatives --config vim
sudo update-alternatives --config gvim
```

# 13,安装llvm
```
wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add - #(以根用户执行)
sudo apt-add-repository 'deb http://apt.llvm.org/bionic/ llvm-toolchain-bionic-10 main'
sudo apt install -y libllvm-10-ocaml-dev libllvm10 llvm-10 llvm-10-dev llvm-10-doc llvm-10-examples llvm-10-runtime
sudo apt install -y clang-10 clang-tools-10 clang-10-doc libclang-common-10-dev libclang-10-dev libclang1-10 clang-format-10 python3-clang-10 clangd-10 libclang-10-dev clang-tidy-10
sudo apt install -y libfuzzer-10-dev
sudo apt install -y lldb-10 liblldb-10-dev
sudo apt install -y lld-10
sudo apt install -y libc++-10-dev libc++abi-10-dev
sudo apt install -y libomp-10-dev
sudo apt install -y libclc-dev
sudo apt install -y libunwind-dev
sudo apt install *clang*10* *llvm*10*
sudo update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-10 100
sudo update-alternatives --install /usr/bin/clang clang /usr/bin/clang-10 100
sudo update-alternatives --install /usr/bin/clangd clangd /usr/bin/clangd-10 100
sudo update-alternatives --install /usr/bin/clang-format clang-format /usr/bin/clang-format-10 100
sudo update-alternatives --install /usr/bin/clang-apply-replacements clang-apply-replacements /usr/bin/clang-apply-replacements-10 100
sudo update-alternatives --install /usr/bin/clang-change-namespace clang-change-namespace /usr/bin/clang-change-namespace-10 100
sudo update-alternatives --install /usr/bin/clang-check clang-check /usr/bin/clang-check-10 100
sudo update-alternatives --install /usr/bin/clang-cl clang-cl /usr/bin/clang-cl-10 100
sudo update-alternatives --install /usr/bin/clang-cpp clang-cpp /usr/bin/clang-cpp-10 100
sudo update-alternatives --install /usr/bin/clang-doc clang-doc /usr/bin/clang-doc-10 100
sudo update-alternatives --install /usr/bin/clang-extdef-mapping clang-extdef-mapping /usr/bin/clang-extdef-mapping-10 100
sudo update-alternatives --install /usr/bin/clang-format-diff clang-format-diff /usr/bin/clang-format-diff-10 100
sudo update-alternatives --install /usr/bin/clang-include-fixer clang-include-fixer /usr/bin/clang-include-fixer-10 100
sudo update-alternatives --install /usr/bin/clang-move clang-move /usr/bin/clang-move-10 100
sudo update-alternatives --install /usr/bin/clang-offload-bundler clang-offload-bundler /usr/bin/clang-offload-bundler-10 100
sudo update-alternatives --install /usr/bin/clang-offload-wrapper clang-offload-wrapper /usr/bin/clang-offload-wrapper-10 100
sudo update-alternatives --install /usr/bin/clang-query clang-query /usr/bin/clang-query-10 100
sudo update-alternatives --install /usr/bin/clang-refactor clang-refactor /usr/bin/clang-refactor-10 100
sudo update-alternatives --install /usr/bin/clang-rename clang-rename /usr/bin/clang-rename-10 100
sudo update-alternatives --install /usr/bin/clang-reorder-fields clang-reorder-fields /usr/bin/clang-reorder-fields-10 100
sudo update-alternatives --install /usr/bin/clang-scan-deps clang-scan-deps /usr/bin/clang-scan-deps-10 100
sudo update-alternatives --install /usr/bin/clang-tidy clang-tidy /usr/bin/clang-tidy-10 100
sudo update-alternatives --install /usr/bin/clang-tidy-diff clang-tidy-diff /usr/bin/clang-tidy-diff-10.py 100
```
## 添加llvm源
```
sudo apt-add-repository 'deb http://apt.llvm.org/bionic/ llvm-toolchain-bionic-12 main'
sudo apt-add-repository 'deb http://apt.llvm.org/bionic/ llvm-toolchain-bionic-13 main'
sudo apt install -y libllvm-13-ocaml-dev libllvm13 llvm-13 llvm-13-dev llvm-13-doc llvm-13-examples llvm-13-runtime
sudo apt install -y clang-13 clang-tools-13 clang-13-doc libclang-common-13-dev libclang-13-dev libclang1-13 clang-format-13 python-clang-13 clangd-13 libclang-13-dev  clang-tidy-13
sudo apt install -y libfuzzer-13-dev
sudo apt install -y lldb-13      liblldb-13-dev
sudo apt install -y lld-13
sudo apt install -y libc++-13-dev libc++abi-13-dev
sudo apt install -y libomp-13-dev
sudo apt install -y libclc-13-dev
sudo apt install -y libunwind-13-dev
sudo update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-13 100
sudo update-alternatives --install /usr/bin/clang clang /usr/bin/clang-13 100
sudo update-alternatives --install /usr/bin/clangd clangd /usr/bin/clangd-13 100
sudo update-alternatives --install /usr/bin/clang-format clang-format /usr/bin/clang-format-13 100
sudo update-alternatives --install /usr/bin/clang-apply-replacements clang-apply-replacements /usr/bin/clang-apply-replacements-13 100
sudo update-alternatives --install /usr/bin/clang-change-namespace clang-change-namespace /usr/bin/clang-change-namespace-13 100
sudo update-alternatives --install /usr/bin/clang-check clang-check /usr/bin/clang-check-13 100
sudo update-alternatives --install /usr/bin/clang-cl clang-cl /usr/bin/clang-cl-13 100
sudo update-alternatives --install /usr/bin/clang-cpp clang-cpp /usr/bin/clang-cpp-13 100
sudo update-alternatives --install /usr/bin/clang-doc clang-doc /usr/bin/clang-doc-13 100
sudo update-alternatives --install /usr/bin/clang-extdef-mapping clang-extdef-mapping /usr/bin/clang-extdef-mapping-13 100
sudo update-alternatives --install /usr/bin/clang-format-diff clang-format-diff /usr/bin/clang-format-diff-13 100
sudo update-alternatives --install /usr/bin/clang-include-fixer clang-include-fixer /usr/bin/clang-include-fixer-13 100
sudo update-alternatives --install /usr/bin/clang-move clang-move /usr/bin/clang-move-13 100
sudo update-alternatives --install /usr/bin/clang-offload-bundler clang-offload-bundler /usr/bin/clang-offload-bundler-13 100
sudo update-alternatives --install /usr/bin/clang-offload-wrapper clang-offload-wrapper /usr/bin/clang-offload-wrapper-13 100
sudo update-alternatives --install /usr/bin/clang-query clang-query /usr/bin/clang-query-13 100
sudo update-alternatives --install /usr/bin/clang-refactor clang-refactor /usr/bin/clang-refactor-13 100
sudo update-alternatives --install /usr/bin/clang-rename clang-rename /usr/bin/clang-rename-13 100
sudo update-alternatives --install /usr/bin/clang-reorder-fields clang-reorder-fields /usr/bin/clang-reorder-fields-13 100
sudo update-alternatives --install /usr/bin/clang-scan-deps clang-scan-deps /usr/bin/clang-scan-deps-13 100
sudo update-alternatives --install /usr/bin/clang-tidy clang-tidy /usr/bin/clang-tidy-13 100
sudo update-alternatives --install /usr/bin/clang-tidy-diff clang-tidy-diff /usr/bin/clang-tidy-diff-13.py 100
sudo update-alternatives --install /usr/bin/lldb lldb /usr/bin/lldb-13 100
sudo update-alternatives --install /usr/bin/lld lld /usr/bin/lld-13 100
sudo update-alternatives --install /usr/bin/llc llc /usr/bin/llc-13 100
sudo update-alternatives --install /usr/bin/lldb-argdumper lldb-argdumper /usr/bin/lldb-argdumper-13 100
sudo update-alternatives --install /usr/bin/lldb-instr lldb-instr /usr/bin/lldb-instr-13 100
sudo update-alternatives --install /usr/bin/lldb-server lldb-server /usr/bin/lldb-server-13 100
sudo update-alternatives --install /usr/bin/lldb-vscode lldb-vscode /usr/bin/lldb-vscode-13 100

sudo update-alternatives --config clang
sudo update-alternatives --config clang++
sudo update-alternatives --config clangd
sudo update-alternatives --config clang-format
sudo update-alternatives --config  clang-apply-replacements
sudo update-alternatives --config clang-change-namespace
sudo update-alternatives --config clang-check
sudo update-alternatives --config clang-cl
sudo update-alternatives --config clang-cpp
sudo update-alternatives --config clang-doc
sudo update-alternatives --config clang-extdef-mapping
sudo update-alternatives --config clang-format-diff
sudo update-alternatives --config clang-include-fixer
sudo update-alternatives --config clang-move
sudo update-alternatives --config clang-offload-bundler
sudo update-alternatives --config clang-offload-wrapper
sudo update-alternatives --config clang-query
sudo update-alternatives --config clang-refactor
sudo update-alternatives --config clang-rename
sudo update-alternatives --config clang-reorder-fields
sudo update-alternatives --config clang-scan-deps
sudo update-alternatives --config clang-tidy
sudo update-alternatives --config clang-tidy-diff
sudo apt install *clang*13* *llvm*13*
```

# 14,coc-nvim找不到头文件的解决办法：
## 对于cmake和catkin:
(1)把set(CMAKE_EXPORT_COMPILE_COMMANDS 1)添加到在CMakeList.txt的project语句下面然后编译,再把生成的compile_commands.json复制到工程目录；\
(2)把build的compile_commands.json复制到工程目录；\
(3)自己写compile_commands.json \
(4)catkin_make -DCMAKE_EXPORT_COMPILE_COMMANDS=YES \
(5)建立compile_commands.json硬链接/ 软连接 \
(6)写compile_flags.txt \
## 对于make:
有三种工具可以辅助基于GNUmake的构建系统生成Clang的JSON编译数据库文件的工具。\
分别为compiledb，YCM-Generator和Bear。本系统主要使用的bear。
### Installation
```
sudo apt install bear
```

# 15,解决双系统ubuntu没有挂载硬盘写入权限的方法：如果win10那边提示要修复硬盘,不用管,否则ubuntu会没有读写权限。
(1)进入win10是关机后再进入的ubuntu,导致grub模式下的系统权限可能还在win10下,而没有转到ubuntu下。如果是进入win10后重启再进入ubuntu,可能情况会有所不同。\
(2)也有可能是挂载硬盘在win10那边被检测到损坏,需要修复,但是没修复完毕就保护起来了,此时,请使用以下方法：\
检查硬盘 \
```
sudo mount -a
```
如果什么都没有输出,那挂载硬盘已经成功,理论可以进行读写。\
如果无法读写或者出现The disk contains an unclean file system,问题不大。我们安装一波 ntfs-3g。\
```
sudo apt install ntfs-3g
sudo ntfsfix /dev/sda2   # 其中,/dev/sda2 是你要挂载的硬盘设备,一般打开文件系统,点击到其它位置哪里会有显示。
```
检查占用进程
```
sudo fuser -m -u /dev/sda2
```
杀掉
```
sudo kill 数字
```
取消挂载
```
sudo umount /dev/sda2
```
重新挂载
```
sudo mount /dev/sda2 你想挂载的绝对路径
```
重启

# 16,更换python的方法和安装debug工具
```
python3 -m pip install pysnooper ipdb
sudo update-alternatives --install /usr/bin/python python /usr/bin/python2 100
sudo update-alternatives --install /usr/bin/python python /usr/bin/python3 150
sudo update-alternatives --config python  #选择python2
```

# 17,关闭dash-to-panel的hot-corners的方法：鼠标左上角
先尝试第18点,不行再试这个
```
sudo gvim /usr/share/gnome-shell/extensions/dash-to-panel@jderose9.github.com/panel.js
```
把hot-corners相关的代码全部注释掉,然后重启。

# 18,正常关闭tweak的hot-corners的方法：
打开tweaks,去到top bar,关闭activities overview hot corners.

# 19,添加nvidia显卡驱动源,安装nvidia显卡官方驱动
换到tty2
```
sudo add-apt-repository ppa:graphics-drivers/ppa
sudo apt purge libnvidia* nvidia*
sudo gedit /etc/modprobe.d/blacklist.conf
```
最下方添加
blacklist nouveau
```
reboot
lsmod | grep nouveau
```
无输出则表示成功
换到tty2
```
sudo apt install nvidia-driver-版本号
sudo apt install mesa-common-dev
sudo apt install freeglut3-dev
sudo apt install build-essential
sudo apt install libgl1-mesa-dev
sudo apt install libglu1-mesa-dev
reboot
nviaid-smi
```
有显示结果则成功

# 20,更改core file size
```
ulimit -a #查看
ulimit -c 8192 #更改为8192mb
```

# 21,动态库被截断的原因
查阅资料发现,如有出现无法识别文件：文件被截断等问题,一般都是由于：在先前的构建过程中发生了中断并且目标文件未完全生成,会导致文件中只有部分内容,或者是直接缺少文件。\
这个解决方法一是删除对应的目标文件使其重新编译生成,二是多目标文件缺少太多时可以考虑重新安装,删除整个pangolin文件夹,在git clone步骤开始重新安装,并保证整个过程中不要发生中断。

# 22,安装qbittorrent
```
sudo add-apt-repository ppa:qbittorrent-team/qbittorrent-stable
sudo apt install qbittorrent
```

# 23,尽量使用openjdk,因为cuda默认使用openjdk
```
sudo apt install openjdk-11*
```
如果不想使用openjdk,那么安装java-13或jdk-13如下：
```
sudo apt purge openjdk*
sudo mkdir /usr/lib/jvm
sudo cp jdk-13 /usr/lib/jvm -rp
```
在.zshrc(zshell)/.bashrc(bash)中加入
```
export JAVA_HOME=/usr/lib/jvm/jdk-13
export CLASSPATH=.:${JAVA_HOME}/lib
export PATH=${JAVA_HOME}/bin:$PATH
```

# 23,gvim or matlab启动时xxx/canberra-gtk-module打开失败:
gtk和gtk3的模块冲突或者gtk3模块存在bug,不能使用gtk3的模块作为默认启动模块,或者该模块没有告诉该软件其位置,卸载后重新安装该模块即可。
```
sudo su
apt purge libcanberra-gtk-module -y
apt purge libcanberra-gtk3-module -y
apt purge packagekit-gtk3-module -y
apt install libcanberra-gtk-module -y
apt install libcanberra-gtk3-module -y
```

# 24,解决安装后ubuntu18.04后出现Unable to download updates from extensions.gnome.org的问题
```
sudo add-apt-repository ppa:gnome-shell-extensions/ppa
sudo apt update
sudo apt install gnome-shell-extensions
```

# 25,安装文泉驿和Nerd字体
##安装文泉驿#本人已不再用文泉驿字体
```
sudo apt install fonts-wqy*
#文泉驿字体和vim不是很适配,所以会看到部分字体或符号少半边的情况
#WenQuanYi Micro Hei Mono Regular 和Noto Mono Regular字体效果类似
```
##安装,DejaVuSansMonoFantasqueSansMono Nerd Font,UbuntuMono Nerd,InconsolataLGC字体
```
sudo apt install font-manager
#去https://www.nerdfonts.com/font-downloads下载DejaVuSansMono,FantasqueSansMono,UbuntuMono,InconsolataLGC字体
#解压DejaVuSansMono,FantasqueSansMono Nerd Font,UbuntuMono,InconsolataLGC字体并进入解压出来的文件夹
sudo mv DejaVuSansMono/ FantasqueSansMono UbuntuMono /usr/share/fonts -r
cd /usr/share/fonts
sudo chown root:root DejaVuSansMono FantasqueSansMono UbuntuMono -R
sudo chmod 755 DejaVuSansMono FantasqueSansMono UbuntuMono -R
sudo fc-cache -fv
```

# 26,创建smb服务
```
sudo apt install samba
sudo cp /etc/samba/smb.conf /etc/samba/smb.conf.back
sudo gvim /etc/samba/smb.conf
```
在末尾添加如下内容:
```
  [The_resource_of_ROS_car]
  comment = share folder required password
  browseable = yes
  path = /home/banana/win10store/The_resource_of_ROS_car
  create mask = 0777
  directory mask = 0777
  valid users = banana
  force user = banana
  force group = banana
  public = yes
  writable = yes
  available = yes
```
```
sudo /etc/init.d/smbd restart
sudo smbpasswd -a banana
```

# 27,禁用ibus
```
sudo dpkg-divert --package im-config --rename /usr/bin/ibus-daemon
#Adding 'diversion of /usr/bin/ibus-daemon to /usr/bin/ibus-daemon.distrib by im-config'
```

# 28,设置静态ip
```
cd /etc/netplan
ip addr
```
结果如下
```
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host
       valid_lft forever preferred_lft forever
2: enp4s0f1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    link/ether 80:fa:5b:35:25:54 brd ff:ff:ff:ff:ff:ff
    inet 192.168.3.3/24 brd 192.168.3.255 scope global enp4s0f1
       valid_lft forever preferred_lft forever
    inet6 fe80::82fa:5bff:fe35:2554/64 scope link
       valid_lft forever preferred_lft forever
3: wlp3s0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
    link/ether b8:81:98:1f:17:ab brd ff:ff:ff:ff:ff:ff
    inet 192.168.3.3/24 brd 192.168.3.255 scope global wlp3s0
       valid_lft forever preferred_lft forever
    inet6 fe80::526b:35c5:a124:9b3f/64 scope link noprefixroute
       valid_lft forever preferred_lft forever
```
```
sudo gvim 01-network-manager-all.yaml
```
在
```
network:
  version: 2
  renderer: networkd
```
后面添加
```
  ethernets:
    enp4s0f1:
      dhcp4: no
      dhcp6: no
      addresses: [192.168.3.3/24] #设置本机IP及掩码
      gateway4:  192.168.3.1 #设置网关
      nameservers:
        addresses: [114.114.114.114, 8.8.8.8] #设置DNS
```
其中,enp4s0f1和wlp3s0分别是网线网卡名称和wifi网卡名称
```
sudo netplan apply
```

# 29,查看带宽：ethtool 网络接口名

# 30,安装cuda,看官网即可,这个会自动安装openjdk-11
```
wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/cuda-ubuntu1804.pinsudo
mv cuda-ubuntu1804.pin /etc/apt/preferences.d/cuda-repository-pin-600
wget https://developer.download.nvidia.com/compute/cuda/11.5.0/local_installers/cuda-repo-ubuntu1804-11-5-local_11.5.0-495.29.05-1_amd64.debsudo
sudo dpkg -i cuda-repo-ubuntu1804-11-5-local_11.5.0-495.29.05-1_amd64.debsudo apt-key add /var/cuda-repo-ubuntu1804-11-5-local/7fa2af80.pub
sudo apt update
sudo apt -y install cuda
```

# 31,安装cudnn和tensorrt,看官网即可
```
sudo apt install libcupti-dev -y
sudo cp cuda/include/cudnn*.h /usr/local/cuda/include
sudo cp -P cuda/lib64/libcudnn* /usr/local/cuda/lib64
sudo chmod a+r /usr/local/cuda/include/cudnn*.h /usr/local/cuda/lib64/libcudnn*
sudo dpkg -i nv-tensorrt-repo-ubuntu1804-cuda11.3-trt8.0.0.3-ea-20210423_1-1_amd64.deb
sudo apt-key add /var/nv-tensorrt-repo-ubuntu1804-cuda11.3-trt8.0.0.3-ea-20210423/7fa2af80.pub
sudo apt update
sudo apt -y install tensorrt
sudo apt -y install python3-libnvinfer-dev
sudo apt -y install uff-converter-tf
sudo apt -y install onnx-graphsurgeon
dpkg -l | grep TensorRT
```

# 32,安装opencv过程,先安装cudnn,cuda,显卡驱动,tensorrt
```
sudo add-apt-repository "deb http://security.ubuntu.com/ubuntu xenial-security main"
sudo apt update
sudo apt install -y blender-ogrexml-1.9 libogre-1.9-dev libogre-1.9.0v5 ogre-1.9-doc ogre-1.9-tools cantor-backend-julia libdatetime-calendar-julian-perl
sudo apt install -y libjasper1 libjasper-dev
sudo apt install -y libgoogle-glog-dev  
sudo apt install -y glog* gflags* tesseract* openexr libglog* libgflags*
sudo apt install -y tesseract-ocr* liblept5 leptonica-progs libleptonica-dev libtesseract*
sudo apt install -y libatlas-base-dev gfortran # 优化opencv功能
sudo apt install -y libavcodec-dev libavformat-dev libswscale-dev libv4l-dev liblapacke-dev
sudo apt install -y build-essential cmake git
sudo apt install -y libgtk-3-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev
sudo apt install -y python-dev python-numpy  python3-dev python3-numpy python3-opencv
sudo apt install -y libtbb2 libtbb-dev libjpeg-dev libtiff-dev libjasper-dev libdc1394-22-dev
sudo apt-get -y install libavresample-dev libgstreamer-plugins-base1.0-dev libgstreamer1.0-dev
sudo apt install -y libopenblas-dev doxygen libopenjpip-server libgoogle-glog-dev libgoogle-glog0v5 checkinstall yasm libpng12-0 libpng-dev libxine2-bin libxine2-dev libgdk-pixbuf2.0-dev libpng-dev  libfaac-dev libfaac0 libmp3lame-dev libxvidcore-dev libopencore-amrnb-dev libopencore-amrwb-dev libffms2-4 libgpac4  *openjpip*
sudo ln -s /usr/lib/python2.7/dist-packages/vtk/libvtkRenderingPythonTkWidgets.x86_64-linux-gnu.so /usr/lib/x86_64-linux-gnu/libvtkRenderingPythonTkWidgets.so
sudo ln -s /usr/bin/vtk6 /usr/bin/vtk
```
## Download and unpack sources
```
wget -O opencv.zip https://github.com/opencv/opencv/archive/master.zip
wget -O opencv_contrib.zip https://github.com/opencv/opencv_contrib/archive/master.zip
unzip opencv.zip
unzip opencv_contrib.zip
```
## Create build directory and switch into it
```
mkdir -p build && cd build
cmake -DOPENCV_EXTRA_MODULES_PATH=../opencv_contrib-master/modules ../opencv-master -D CMAKE_BUILD_TYPE=RELEASE -D WITH_CUDA=ON -D WITH_CUBLAS=ON -D CUDA_ARCH_BIN='5.2' -D OPENCV_GENERATE_PKGCONFIG=YES  -D CUDA_FAST_MATH=Yes -D WITH_OPENCL=ON -D ENABLE_FAST_MATH=ON
make -j8
sudo make install
```
## 由于某些未知力量的原因，可能会导致opencv4某些模块下载失败，要多次进行cmake，但是这样太过费时，所以可以使用代理解决，这里以常见的失败模块IPPICV为例子
```
cd ~/Downloads/program/opencv4/opencv/3rdparty
cd ippicv
gvim ippicv.cmake
```
找到
```
"https://raw.githubusercontent.com/opencv/opencv_3rdparty/.../ippicv/"
```
添加
```
https://ghproxy.com/
```
到它前面，变成
```
"https://ghproxy.com/https://raw.githubusercontent.com/opencv/opencv_3rdparty/.../ippicv/"
```
## 由于某些未知力量，face_landmark_model.dat可能会下载失败，解决办法:
去[face_landmark_model.dat](https://raw.githubusercontent.com/opencv/opencv_3rdparty/8afa57abc8229d611c4937165d20e2a2d9fc5a12/face_landmark_model.dat)
下载落来，并迁移到~/Downloads/program/opencv4/opencv/.cache/data并把名字改为
~/Downloads/program/opencv4/opencv/.cache/data原来存在的face_landmark_model.dat的名字
## Install tensorflow
```
python3 -m pip install tensorflow
```

# 33,安装docker
```
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
sudo apt update
apt-cache policy docker-ce
sudo apt install docker-ce
```
更换docker镜像源和docker存储位置
```
mkdir ~/linuxstore/docker
sudo gvim /etc/docker/daemon.json
```
添加如下内容
```
{
  "registry-mirrors":["https://hub-mirror.c.163.com/"],
  "data-root":"/home/banana/linuxstore/docker"
}
```
执行如下命令
```
sudo systemctl daemon-reload
sudo systemctl restart docker.service
```
解决docker的部分命令只允许root用户使用的问题
```
sudo groupadd docker     #添加docker用户组
sudo gpasswd -a banana docker     #将banana用户加入到docker用户组中
newgrp docker     #更新用户组
reboot
docker ps    #测试docker命令是否可以使用sudo正常使用
```

# 34,解决hds和vsim打开时字体缺失报错问题。
```
sudo apt install xfsprogs xfstt -y
sudo apt install t1-xfree86-nonfree -y
sudo apt install ttf-xfree86-nonfree -y
sudo apt install ttf-xfree86-nonfree-syriac -y
sudo apt install xfonts-75dpi -y
sudo apt install xfonts-100dpi -y
```

# 35,设置默认pip以及换源
```
sudo apt intall python-pip python3-pip
sudo su
python3 -m pip install pip --upgrade
python -m pip install pip --upgrade
sudo rm /usr/bin/pip
sudo update-alternatives --install /usr/bin/pip pip /usr/bin/pip2 3
sudo update-alternatives --install /usr/bin/pip pip /usr/bin/pip3 6
sudo update-alternatives --config pip
```
对于普通用户：
```
python3 -m pip config set global.index-url https://mirrors.cloud.tencent.com/pypi/simple
# Writing to /home/banana/.config/pip/pip.conf
```
对于根用户用户：
```
sudo su
python3 -m pip config set global.index-url https://mirrors.cloud.tencent.com/pypi/simple
# Writing to /root/.config/pip/pip.conf
```

# 36,goldendict配置大全
配置字体文件,在~/.goldendict文件夹里添加article-style.css文件即可 \
https://zhuanlan.zhihu.com/p/344770839
https://www.autoptr.top/gdocr/

# 37,sudo update-initramfs -u缺失 /lib/firmware/i915/xxx.bin for module i915
到https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/tree/i915下载对应模块并移动到/lib/firmware/i915/

# 38,更改ubuntu18切换窗口快捷键以及关闭自动弹出网络登录窗口
Setting>Devices>Keyboard>Navgation \
把Switch windows绑定到Alt+Tab \
把Switch applications绑定到Ctrl+Alt+Tab \
Setting>Privacy>Turn Off Connectivity Checking

# 39,修改系统硬盘分配
```
sudo apt install gparted
sudo gparted
```

# 40,vmworkstation激活码
vmware workstation 16
```
ZF3R0-FHED2-M80TY-8QYGC-NPKYF
YF390-0HF8P-M81RQ-2DXQE-M2UT6
ZF71R-DMX85-08DQY-8YMNC-PPHV8
```
vmware workstation 17
```
MC60H-DWHD5-H80U9-6V85M-8280D
```
更新kernel可能因为忘记关vpn导致安装模块失败
```
cd /lib/modules
sudo rm 5.4.0-146-generic -r
sudo apt install linux-modules-extra-5.4.0-146-generic linux-modules-5.4.0-146-generic linux-headers-5.4.0-146-generic --reinstall
reboot
```
关闭vpn重新打开vmware

# 41,安装bazel和svlangserver和verible
## Install bazel
```
sudo apt install curl gnupg
curl -fsSL https://bazel.build/bazel-release.pub.gpg | gpg --dearmor > bazel.gpg
sudo mv bazel.gpg /etc/apt/trusted.gpg.d/
echo "deb [arch=amd64] https://storage.googleapis.com/bazel-apt stable jdk1.8" | sudo tee /etc/apt/sources.list.d/bazel.list
sudo apt update && sudo apt install bazel
```
## Install svlangserver
```
sudo npm install -g @imc-trading/svlangserver
```
https://github.com/chipsalliance/verible  \
看bazel官网,看imc-trading/svlangserver的github,看chipsalliance/verible的github\
注意gcc的版本，如果切换了gcc的版本再编译会出现bug，需要删除~/.cache/bazel里面对应的文件夹重新编译才行。
```
bazel build -c opt //...
bazel test -c opt //... --test_verbose_timeout_warnings
bazel run -c opt :install -- -s /usr/local/bin
```

# 42,解决verilog找不到模块问题,coc-nvim使用iverilog,verilator
使用语法
```
`include "xxx.v"
```
包含模块所在v文件

# 43,C/C++/python debug工具以及配置.gdbinit
https://www.gdbgui.com/installation/(gdbgui进入程序后无法使用删除键，有时由于进程占用问题导致无法添加断点，有时会崩溃) \
https://github.com/cyrus-and/gdb-dashboard(只需要该github的gdb初始化配置文件,可以启动gdb后再source) \
https://github.com/longld/peda \
https://github.com/hugsy/gef \
https://github.com/pwndbg/pwndbg \
https://github.com/vim-vdebug/vdebug(vim的插件,it is not tested with C++）\
https://github.com/puremourning/vimspector(比较接近vscode调试的vim插件)\
nemiver(ubuntu直接使用apt下载即可，是一个古老且比较完美的debug界面,由于需要经常使用鼠标操作，且变量观察相对麻烦，界面容易变形，暂时不作使用)\
termdebug(vim自带debug功能，该有的都有，唯一问题就是界面有闪烁)\
https://github.com/rr-debugger/rr#system-requirements(一个拥有比gdb更成熟的回溯能力的debug工具)

## configure gdb
```
cd ~/Downloads/program
git clone https://github.com/hugsy/gef.git
python3 -m pip install keystone-engine unicorn capstone ropper
gvim ~/.gdbinit #add the following content
```
```
set print pretty on
set print object on
set print static-members on
set print demangle on
set print sevenbit-strings off
set print array-indexes on
set print vtbl on
set confirm off
set history filename ~/.cache/.gdbHistory
set history save on
set history size 333
set history remove-duplicates 0



python
import sys
sys.path.insert(0, '/usr/share/gcc/python')
from libstdcxx.v6.printers import register_libstdcxx_printers
register_libstdcxx_printers (None)
end



# // Add function to change string pointer to char pointer
# // so that we can print map[xxx] elements by gdb.
# // For example,std::unordered_map<std::string, std::string> map_test = {{"Hello","Mike"}},
# // we can print map_test[spToCp("Hello")]. Add the following content to your C/C++ source codes.
# std::string spToCp(const char *x) { return x; };
```
configure gef #only use for gdb command line.
```
gvim ~/.gdbgef #add the following content, do not add the following content to .gdbinit, it will affect vimspector.
```
```
source ~/Downloads/program/gef/gef.py
```
note:'/usr/share/gcc/python' is the path of libstdcxx

# 44,如何卸载XDM
```
sudo rm -r /opt/xdman /usr/share/applications/xdman.desktop /usr/bin/xdman
```

# 45,使用sshfs远程挂载目录:
这个和XDM有冲突,要先卸载XDM,安装完sshfs再重新安装XDM。暂时无法实现挂载后正常使用插件进行跳转.(速度过慢,不建议使用,如果没有加密必要,可试试NFS挂载) \
https://segmentfault.com/a/1190000039677828
```
sudo apt install sshfs
```
别对下面的命令使用sudo,如果使用了,普通用户没有权限被挂载的目录,也没有权限卸载被挂载的目录,必须转到根用户。
```
sshfs -o transform_symlinks -o follow_symlinks  user@hostname: [dir]mountpoint
fusemount –u [dir]mountpoint
```

# 46,安装打印机驱动
```
sudo bash linux-brprinter-installer-2.2.2-1 HL-2560DN #HL-2560DN是我的打印机型号,请选择你自己的打印机型号
```
安装驱动后记得去设置如果打印失败则放弃,否则可能会卡机
如果打印机设置显示ubuntu18打印机服务不可用可以按如下操作,然后再重新执行上面的命令
```
sudo cp /usr/share/cups/cupsd.conf.default /etc/cups/cupsd.conf
sudo service cups restart
```

# 47,kazam录屏降噪：
```
sudo cp /etc/pulse/default.pa /etc/pulse/default.pa.bak
sudo vim /etc/pulse/default.pa
```
在文件末尾添加如下内容
```
#Active Noise Removal
.ifexists module-echo-cancel.so
load-module module-echo-cancel aec_method=webrtc source_name=mic source_properties=device.description=MicHD
set-default-source "mic"
.endif
```
重启电脑
```
reboot
```
去到ubuntu的setting->sound->input更改音源为MicHD(貌似会自动设置)
录屏软件kazam的file->preferences->General更改麦克风选项的音源为MicHD,这里也是可以更改录屏声音的(麦克风和喇叭)

# 48,markdown(缩写为md)文件转docx或pdf工具
```
sudo apt install pandoc texlive-xetex texlive-luatex pandoc-citeproc texlive-pstricks -y
```
md转docx：
```
pandoc linux.md -o linux.docx
```
html转docx：
```
pandoc http://ip.yeyese.top/  -o aa.docx
```
markdown转pdf：
```
pandoc linux.md --latex-engine=xelatex  -o linux.pdf
```
如果没用tex公式可以换成一下命令
```
pandoc linux.md -o linux.pdf
```

# 49,sudo update-initramfs -u报UUID RESUME
首先使用如下命令打印/swap分区的UUID号,比对一下确认和上面的系统打印输出一致,锁定为该问题
```
blkid | awk -F\" '/swap/ {print $2}'
```
然后使用如下命令写入/swap分区的UUID号
```
printf "RESUME=UUID=$(blkid | awk -F\" '/swap/ {print $2}')\n" | sudo tee /etc/initramfs-tools/conf.d/resume
sudo gvim /etc/initramfs-tools/conf.d/resume
```
最后更新内核文件
```
sudo update-initramfs -u
```

# 50,出现的错误 W: Possible missing firmware /lib/firmware/rtl_nic/rtl8125a-3.fw for…
解决的方法：
```
cd /lib/firmware/rtl_nic/
sudo wget https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/tree/rtl_nic/rtl8125a-3.fw
```
结论：缺啥补啥

# 51,开机自动挂载win10硬盘
```
sudo blkid
sudo gvim /etc/fstab
UUID=CC9071EB9071DC80 /home/banana/win10store ntfs uid=banana,gid=banana   0       2
```

# 52,关于ubuntu18掉帧的解决方法
去到setting的显示器设置把帧率设置到59附近(小于60）
# 中文字体渲染问题解决方法：
```
sudo su
cd /etc/fonts/conf.avail/
gvim 64-language-selector-prefer.conf
# JP －日文
# KR － 韩文
# SC － 简体中文
# TC － 繁体中文
# HK －香港字体
# 修改上面的文件,将顺序改成SC TC HK JP KR。
```

# 53,关于vim离开搜索模式取消中文输入法
```
" 离开命令行时,关闭输入法,CmdLineLeave无法在vim8.2终端正常使用,会造成状态行显示乱码,
" 触发coc的补全或触发coc#on_enter()会导致下面的命令也被触发,CmdLineLeave会经常触发导致
" 部分快捷键或者命令执行时有问题,也无法利用AsyncRun!分流会导致AsyncRun异常。
" if has("gui_running")
"   autocmd CmdLineLeave * :AsyncRun! -silent fcitx-remote -c
" elseif has("nvim")
"   autocmd CmdLineLeave * :AsyncRun! -silent fcitx-remote -c
" endif
```

# 54,解决ubuntu18,remmina经常崩溃的办法
```
sudo apt purge remmina
sudo apt autoremove
sudo apt autoclean
reboot
sudo apt-add-repository ppa:remmina-ppa-team/remmina-next
sudo apt update
sudo apt install remmina
#去remmina的preference里面删除所有快捷键,在使用时也别按win键
#如果remmina崩溃从而导致整个ubuntu18卡机,此时只能使用ctrl+alt+<F2>切换到tty2,登录个人用户后使用如下命令
killall remmina
exit
#切换回tty1
```
配置文件中关闭通过ssh tunnel链接vnc
新版remmina的桌面图标可能没有图案,可以根据下面旧版的桌面图标信息改一下
```
[Desktop Entry]
Name=Remmina Remote File
Comment=Access remote desktops with Remmina
Exec=/usr/bin/remmina --connect %U
Icon=remmina
Terminal=false
Type=Application
StartupNotify=true
MimeType=application/x-remmina;
NoDisplay=true
```
也可能在打开后无法编辑已有配置,把remmina-gnome改为remmina

# 55,关于vim显示符号乱码问题
安装nerd系列的字体即可。https://www.nerdfonts.com/


# 56,如果因为indentLine插件导致json文件的引号被隐藏,可以做以下操作
```
sudo gvim /usr/share/vim/vim82/syntax/json.vim
:g/if has('conceal')/s//& \&\& 0/
:wq
```

# 57,install go language and goneovim
## install go language
```
sudo apt install software-properties-common
sudo add-apt-repository ppa:longsleep/golang-backports
sudo apt update
sudo apt install golang-go
#Set $GOPATH
mkdir -p ~/.local/.go/{bin,pkg,src}
echo 'export GOPATH="$HOME/.local/.go"' >> ~/.bashrc
echo 'export PATH="$PATH:${GOPATH//://bin:}/bin"' >> ~/.bashrc
source ~/.bashrc
```
## 更换go的镜像源,在.bashrc或.zshrc中加入下面这个
```
export GO111MODULE=on
# Set the GOPROXY environment variable
export GOPROXY=https://goproxy.io,direct
# Set environment variable allow bypassing the proxy for specified repos (optional)
# export GOPRIVATE=git.mycompany.com,github.com/my/private
```
## install goneovim
去这里(goneovim)[https://github.com/akiyosi/goneovim/releases]下载编译好的包然后
```
cd ~/.config
mkdir goneovim
gvim settings.toml
```
然后
```
cd /bin
sudo ln -s /path/to/goneovim goneovim
```
or if you use zshell
```
echo 'export PATH=/paht/to/goneovim_folder:$PATH' >> ~/.zshrc
```
else
```
echo 'export PATH=/paht/to/goneovim_folder:$PATH' >> ~/.bashrc
```
or if you use zshell
```
echo 'alias goneovim='/path/to/goneovim' >> ~/.zshrc
```
else
```
echo 'alias goneovim='/path/to/goneovim' >> ~/.bashrc
```

# 58,卸载envice,因为有时候会莫名奇妙在后台跑起来,占用大量cpu。
```
sudo apt purge envice
```

# 59,一些小工具
## 查看cpp手册工具
```
python3 -m pip install cppman
```
## 类图生成工具
```
sudo apt install doxygen doxygen-gui doxygen-latex graphviz plantuml
doxywizard
#用法看https://blog.csdn.net/ZeroLiko/article/details/78162408
```
## ipad通过airplay投屏到ubuntu18
[Uxplay](https://github.com/FDH2/UxPlay)
```
git clone https://github.com/FDH2/UxPlay.git
sudo apt-get install libssl-dev libplist-dev libavahi-compat-libdnssd-dev libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev gstreamer1.0-libav gstreamer1.0-plugins-bad
sudo apt-get install libx11-dev #(for the "ZOOMFIX" X11_display name fix for screen-sharing with e.g., ZOOM)
sudo apt remove gstreamer1.0-vaapi #NVIDIA系列显卡如果不卸载这个会出现花屏问题,不过goodnote不会有这个问题。在没有NVIDIA显卡的情况下,因特尔的核显可以下载用来做硬件加速
cmake . #(or "cmake -DZOOMFIX=ON ." to get a screen-sharing fix to make X11 mirror display windows visible to screen-sharing applications such as Zoom, see below).我选择了"cmake -DZOOMFIX=ON ."
make
./uxplay #先进行测试再决定是否安装
sudo make install #(you can afterwards uninstall with sudo make uninstall in the same directory in which this was run)
```
## ubuntu18投屏到ipad（还没进行测试）
[Deskcreen](https://github.com/pavlobu/deskreen)
## 安装下载B站视频小工具you-get
```
python3 -m pip install you-get
```
## 钉钉
[Dingding](https://alidocs.dingtalk.com/i/p/nb9XJlJ7QbxN8GyA/docs/nb9XJOPQ3K25LmyA)
## rst file to html file
```
sudo python3 -m pip install sphinx sphinx-rtd-theme
```
## use httpie to replace replace curl and wget
```
python3 -m pip install httpie # command: http/https
```

# 60,安装rust和一些新的命令行工具
```
sudo apt install rustc
cd ~
mkdir .cargo
cd .cargo
gvim config
```
复制下面这段到config里面以更换cargo镜像源
```
[source.crates-io]
registry = "https://github.com/rust-lang/crates.io-index"
replace-with = 'ustc'
[source.ustc]
registry = "git://mirrors.ustc.edu.cn/crates.io-index"
# 如果所处的环境中不允许使用 git 协议,可以把上面的地址改为
# registry = "https://mirrors.ustc.edu.cn/crates.io-index"
#[http]
#check-revoke = false
```
```
cargo install exa # replace ls, command: exa
cargo install fd-find # replace find, command: fd
cargo install du-dust # replace du, command: dust
cargo install procs # replace ps, command: procs
cargo install bottom # replace top, command: btm
cargo install zoxide # replace cd, command: z
cargo install ripgrep # replace grep, command: rg
cargo install bat # replace cat, command: bat
cargo install hyperfine # replace time, command: hyperfine
```
添加下面这句环境路径到.bashrc或者.zshrc中
```
export PATH=$PATH:~/.cargo/bin
```
add the following content to .zshrc
```
if command -v zoxide >/dev/null 2>&1;then
  eval "$(zoxide init zsh)"
fi
```
add the following content to .bashrc
```
if command -v zoxide >/dev/null 2>&1;then
  eval "$(zoxide init bash)"
fi
```
root和user用户通过cargo安装的软件不一定通用,具体看PATH的设置。
我这里是单独分开来设置的,因此我进入了root用户,去到root文件夹配置了
cargo的镜像源,安装了exa以及添加了root用户自己的cargo路径到root的shell
配置文件中。
# 61,修复sudo apt update出现错误：
W: GPG error: http://security.ubuntu.com trusty-security Release: The following signatures couldn't be verified because the public key is not available: NO_PUBKEY 40976EAF437D05B5 NO_PUBKEY 3B4FE6ACC0B21F32
```
# 缺少公钥8D5A09DC9B929006
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 3B4FE6ACC0B21F32
```

# 62,如何确定系统所用屏保软件
```
ps aux | grep screen
```
然后搜索linux如何关闭xxx的屏保，例如xscreensaver

# 63,gnome文件的默认打开方式的配置文件
```
gvim /etc/gnome/defaults.list
```

# 64,解决nfs挂载硬盘普通用户没有访问权限问题
(1)查看可以访问nfs挂载的硬盘的用户组的gid \
(2)使用sudo groupadd -g gid group_name创建一个gid存在于所查结果的用户组(如果已存在，步骤2变为查询gid对应的group_name) \
(3)使用命令sudo gpasswd -a user group_name将user用户加入到group_name用户组中 \
(4)重启(也可以使用newgrp group_name更新用户组,但是打开新终端可能会失效)

# 65,使独立显卡仅用于计算，显示全交给英特尔集显
```
lspci | grep intel #获取BusID，我这里的BusID为00:02.0,填写时要写成PCI:0:2:0
sudo gvim /etc/X11/xorg.conf #一般没有这个文件，如果存在，请自行备份
```
添加如下内容,其中BusID根据lspci | grep intel查询结果进行修改
```
Section "ServerLayout"
    Identifier "layout"
    Screen 0 "intel"
    Screen 1 "intel"
EndSection

Section "Device"
    Identifier "intel"
    Driver "intel"
    BusID "PCI:0:2:0"
EndSection

Section "Screen"
    Identifier "intel"
    Device "intel"
EndSection

Section "Device"
    Identifier "intel"
    Driver "intel"
    BusID "PCI:0:2:0"
EndSection

Section "Screen"
    Identifier "intel"
    Device "intel"
EndSection
```
然后重启
```
reboot
nvidia-smi #xorg任务消失了
```
Note:调用集显,终端有时会显示异常。

# 66,更新git
```
sudo add-apt-repository ppa:git-core/ppa
sudo apt update
sudo apt upgrade -y
```

# 67,add new dynamic library
add the following content to your .bashrc or .zshrc
```
LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib
```

# 68,install rr debugger
```
sudo apt-get install ccache cmake make g++-multilib gdb \
  pkg-config coreutils python3-pexpect manpages-dev git \
  ninja-build capnproto libcapnp-dev
sudo apt install linux-tools-common
sudo apt install linux-tools-generic linux-cloud-tools-generic
sudo apt install linux-tools-"$(uname -r)" linux-cloud-tools-"$(uname -r)"
cd ~/Downloads/program
git clone https://github.com/rr-debugger/rr.git
cd rr
mkdir obj && cd obj
cmake .. -Ddisable32bit=ON -DCMAKE_BUILD_TYPE=Release
make
sudo make install
perf stat -e br_inst_retired.conditional true
```
on Intel CPUs, the good result is like the following content:
```
$ perf stat -e br_inst_retired.conditional true

 Performance counter stats for 'true':

            95,027      br_inst_retired.conditional

       0.003255114 seconds time elapsed

       0.003127000 seconds user
       0.000000000 seconds sys
```
on AMD Ryzen CPUs, the good result is like the following content:
```
$ perf stat -e ex_ret_cond true

 Performance counter stats for 'true':

            17.525      ex_ret_cond:u

       0,002422402 seconds time elapsed

       0,002737000 seconds user
       0,000000000 seconds sys
```
Otherwise, execute the following command
```
sudo gvim /etc/sysctl.conf
```
add the following content to sysctl.conf
```
kernel.perf_event_paranoid = -1
```
then execute the following command
```
sudo sysctl -p /etc/sysctl.conf
```

# 69,解决有线网无法正常使用的问题
##(1) netword-managed无法正常使用
打开 /etc/NetworkManager/NetworkManager.conf， 将managed=false改为managed=true即可。
这会导致有线网络完全受系统管理，个人无法管理。
##(2) ubuntu 18.04系统，有线网无法连接，无线网可以正常连接；
与该系统装在同一台电脑上的win10有线网可正常连接。进行以下测试：
```
运行ifconfig，只显示lo或wifi网卡
运行ifconfig -a，能显示有线网卡
运行ifconfig enp7s0 up后使用ifconfig能显示有线网卡，但是仍然没有有线网络
```
```
sudo gvim /usr/lib/NetworkManager/conf.d/10-globally-managed-devices.conf
```
将
```
[keyfile]
unmanaged-devices=*,except:type:wifi,except:type:wwan
```
替换为
```
[keyfile]
unmanaged-devices=*,except:type:ethernet,except:type:wifi,except:type:wwan
```
执行
```
sudo service network-manager restart
```

# 70,install opencl intel runtime(2.0)
```
sudo apt install ocl-icd-opencl-dev ocl-icd-libopencl1
<!-- sudo apt install ocl-icd-dev beignet-opencl-icd opencl-headers -->
```

# 71,install opencl intel runtime(2.2)(21.38.21026)
```
cd ~/Downloads/program
mkdir neo
cd neo
wget https://github.com/intel/compute-runtime/releases/download/21.38.21026/intel-gmmlib_21.2.1_amd64.deb
wget https://github.com/intel/intel-graphics-compiler/releases/download/igc-1.0.8708/intel-igc-core_1.0.8708_amd64.deb
wget https://github.com/intel/intel-graphics-compiler/releases/download/igc-1.0.8708/intel-igc-opencl_1.0.8708_amd64.deb
wget https://github.com/intel/compute-runtime/releases/download/21.38.21026/intel-opencl_21.38.21026_amd64.deb
wget https://github.com/intel/compute-runtime/releases/download/21.38.21026/intel-ocloc_21.38.21026_amd64.deb
wget https://github.com/intel/compute-runtime/releases/download/21.38.21026/intel-level-zero-gpu_1.2.21026_amd64.deb
wget https://github.com/intel/compute-runtime/releases/download/21.38.21026/ww38.sum
sha256sum -c ww38.sum
sudo dpkg -i *.deb
```
Got to intel opencl official website to download l_opencl_p_18.1.0.015.tgz.
```
x l_opencl_p_18.1.0.015.tgz
cd l_opencl_p_18.1.0.015
sudo ./install.sh
#It will tell you, it not supports your device and some dependencies you should install manually.
#Don't worry about that, we just need installing all dependencies and ignore the warning then continue installing it.
```

# 72,add shell environment variables
PATH: bin \
LD_LIBRARY_PATH: lib or lib64 \
XDG_DATA_DIRS: share \
C_INCLUDE_PATH: include \
CPLUS_INCLUDE_PATH: include \

# 73,compile duf to replace df
```
git clone https://github.com/muesli/duf.git
cd duf
go build
go install
```

# 74,configure multiple ssh keys
##(1) execute the following commands.
```
mkdir ~/.ssh -p
cd ~/.ssh
ssh-keygen -t rsa -b 4096 -f id_rsa.github -C "YourEmail"
ssh-keygen -t rsa -b 4096 -f id_rsa.gitee -C "YourEmail"
gvim config
```
##(2) add the following content to config file.
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
##(3) execute the following commands.
```
chmod 700 ~/.ssh
chmod 600 config id_rsa.gitee id_rsa.github
chmod 644 id_rsa.gitee.pub id_rsa.github.pub
```
##(4) add the content of id_rsa.gitee to your gitee accout.
##(5) add the content of id_rsa.github to your github accout.

# 75 关于主目录下突然出现一个javasharedresources目录
存放共享java类文件的目录。所有用java编写的软件执行时jvm都可能会生成这个目录。
执行java时加上 -Xshareclasses:cacheDir=/path/to/other/dir 参数可以指定到其他目录，
加上 -Xshareclasses:none可以完全禁止这个特性

# 76 install and use kvm
##(1) install kvm
```
sudo apt install qemu-kvm libvirt-bin bridge-utils virtinst virt-manager qemu ovmf
sudo systemctl is-active libvirtd
sudo usermod -aG libvirt $USER
sudo usermod -aG kvm $USER
brctl show
sudo chmod 666 /var/run/libvirt/libvirt-sock
```
##(2) create a virtual machine
```
virt-manager
```

# 77 configure perl LSP
```
sudo apt install libdb-dev
sudo su
cpan Perl::LanguageServer #sudo
cpan install CPAN
cpan App::cpanminus
cpan Spreadsheet::ParseExcel Spreadsheet::WriteExcel #for xls
cpan Excel::Writer::XLSX Spreadsheet::ParseXLSX #for xlsx
cpanm --uninstall Spreadsheet::Read Spreadsheet::Write Spreadsheet::XLSX
exit
```

# 78 configure fcitx
使得wps可以正常使用输入法
```
sudo gvim /etc/profile
```
add the following content to it
```
# configure fcitx
export XMODIFIERS="@im=fcitx"
export QT_IM_MODULE="fcitx"
```

# 79 install YaHeiConsolas
Download fonts
```
sudo apt install ttf-mscorefonts-installer
x YaHeiConsolas.tar.gz
mkdir YaHeiConsolas
mv YaHeiConsolas.ttf YaHeiConsolas
sudo mv YaHeiConsolas /usr/share/fonts
sudo chown root:root /usr/share/fonts/YaHeiConsolas
sudo chmod 755 /usr/share/fonts/YaHeiConsolas -R
sudo fc-cache -f -v
```

# 80 install brave browser
```
sudo apt install curl
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
sudo apt update
sudo apt install brave-browser
```

# 81 install zotero
Download zotero from it official website to ~/Download/program
```
x Zotero-6.0.26_linux-x86_64.tar.bz2
sudo mkdir /opt/zotero
sudo mv Zotero_linux-x86_64/* /opt/zotero
cd /opt/zotero
sudo ./set_launcher_icon
ln -s /opt/zotero/zotero.desktop ~/.local/share/applications/zotero.desktop
sudo ln -s /opt/zotero/zotero /usr/bin/zotero
```

# 82 install a json formatter
```
sudo npm install -g js-beautify
```

# 83 use neovim as a backend of vscode
（1）在vscode插件中心或扩展中心下载VSCode Neovim插件。 \
（2）打开Linux终端，执行命令mkdir ~/.config/nvim -p命令，
接着执行gvim ~/.config/nvim/init.vim命令，并将如下内容添加到init.vim文件中：
```
if exists('g:vscode')
    " VSCode extension
else
    " ordinary neovim
endif
```
最后执行gvim ~/.config/Code/User/settings.json命令，并将如下内容添加到settings.json文件的{}里面：
```
   "vscode-neovim.neovimExecutablePaths.darwin": "/usr/local/bin/nvim",
   "vscode-neovim.neovimInitVimPaths.darwin": "~/.config/nvim/init.vim",
```


# 83 latexmk
```
sudo apt install latexmk
```
