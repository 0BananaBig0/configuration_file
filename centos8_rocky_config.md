<!-- vim-markdown-toc GFM -->

* [1,为用户添加超级用户权限](#1为用户添加超级用户权限)
* [2,安装nodejs和yarn](#2安装nodejs和yarn)
* [3,安装valgrind和cmake](#3安装valgrind和cmake)
* [4,安装zsh,omz,zinit,ksh](#4安装zshomzzinitksh)
* [5,安装pip等](#5安装pip等)
* [6,从源码编译安装vim和neovim](#6从源码编译安装vim和neovim)
* [7,解决lsb_release command not found](#7解决lsb_release-command-not-found)
* [8,安装ripgrep(命令:rg)代替grep](#8安装ripgrep命令rg代替grep)
* [9,yum update失败,提示:(rocky linux没这个问题，所以没换源)](#9yum-update失败提示rocky-linux没这个问题所以没换源)
* [10,在CentOS下有的时候用yum安装软件的时候最后会提示：](#10在centos下有的时候用yum安装软件的时候最后会提示)
* [11,解决hds和vsim字体缺失问题](#11解决hds和vsim字体缺失问题)
* [12,goldendic配置大全(这个没有弄)](#12goldendic配置大全这个没有弄)
* [13,markdown(缩写为md)文件转docx或pdf工具](#13markdown缩写为md文件转docx或pdf工具)
* [14,安装xfce4,neovim剪贴板，terminator，rlwrap](#14安装xfce4neovim剪贴板terminatorrlwrap)
* [15,安装centos8注意事项](#15安装centos8注意事项)
* [16,安装go，goneovim](#16安装gogoneovim)
  * [install go language](#install-go-language)
  * [更换go的镜像源,在.bashrc或.zshrc中加入下面这个](#更换go的镜像源在bashrc或zshrc中加入下面这个)
  * [install goneovim](#install-goneovim)
* [安装配置文件](#安装配置文件)
* [17,安装ttf字体和字体管理工具](#17安装ttf字体和字体管理工具)
* [18,git配置](#18git配置)
* [19,ale找不到头文件的解决办法：](#19ale找不到头文件的解决办法)
  * [对于cmake和catkin:](#对于cmake和catkin)
  * [对于make:](#对于make)
    * [Installation](#installation)
    * [Usage](#usage)
* [20,安装多个gcc版本并临时切换](#20安装多个gcc版本并临时切换)
* [21,安装bazel和svlangserver和verible](#21安装bazel和svlangserver和verible)
  * [Install bazel](#install-bazel)
  * [Install svlangserver](#install-svlangserver)
* [22,解决verilog找不到模块问题,ale使用iverilog,verilator](#22解决verilog找不到模块问题ale使用iverilogverilator)
* [23,编译安装verilator](#23编译安装verilator)
* [24,安装rust和exa,使用exa代替ls](#24安装rust和exa使用exa代替ls)
* [25,安装gdb-11](#25安装gdb-11)
* [26,安装显卡驱动和cuda](#26安装显卡驱动和cuda)
* [27,安装vncserver](#27安装vncserver)
* [28,更改时区](#28更改时区)
* [29,默认浏览器和终端不需要vpn快速链接github](#29默认浏览器和终端不需要vpn快速链接github)
  * [也可以使用github代理](#也可以使用github代理)
* [30,允许程序使用sudo，允许root使用celab106_z2mini的exa程序，允许root使用/usr/local/bin的程序](#30允许程序使用sudo允许root使用celab106_z2mini的exa程序允许root使用usrlocalbin的程序)
* [31,安装cudnn和tensorrt](#31安装cudnn和tensorrt)
  * [install cudnn](#install-cudnn)
  * [install tensorrt](#install-tensorrt)
* [32,设置默认python](#32设置默认python)
* [33,安装opencv4](#33安装opencv4)
  * [由于某些未知力量的原因，可能会导致opencv4某些模块下载失败，要多次进行cmake，但是这样太过费时，所以可以使用代理解决，这里以常见的失败模块IPPICV为例子](#由于某些未知力量的原因可能会导致opencv4某些模块下载失败要多次进行cmake但是这样太过费时所以可以使用代理解决这里以常见的失败模块ippicv为例子)
  * [由于某些未知力量，face_landmark_model.dat可能会下载失败，解决办法:](#由于某些未知力量face_landmark_modeldat可能会下载失败解决办法)
* [34,安装7z解压软件](#34安装7z解压软件)
* [35,安装opencl和clinfo，这个和cuda提供的有点不同](#35安装opencl和clinfo这个和cuda提供的有点不同)
  * [安装opencl](#安装opencl)
  * [安装clinfo](#安装clinfo)
* [36,64位系统执行32位程序报错:缺少相关32位程序的库](#3664位系统执行32位程序报错缺少相关32位程序的库)
* [37,安装sublime text最新版](#37安装sublime-text最新版)
* [38,如何确定系统所用屏保软件](#38如何确定系统所用屏保软件)
* [39,更改权限，方便用户进来复制文件](#39更改权限方便用户进来复制文件)
* [40,解决centos下非root用户频繁出现Authentication is required to set](#40解决centos下非root用户频繁出现authentication-is-required-to-set)
* [41,解决没有root权限的普通用户使用vnc提示:](#41解决没有root权限的普通用户使用vnc提示)
* [42,编译minisat缺少静态库，提示:](#42编译minisat缺少静态库提示)

<!-- vim-markdown-toc -->
# 1,为用户添加超级用户权限
（1）退出当前用户 \
（2）登录根用户 \
（3）chmod u+w /etc/sudoers \
（4）vi /etc/sudoers \
（5）找到这行 root ALL=(ALL) ALL,在他下面添加xxx ALL=(ALL) ALL (这里的xxx是你的用户名) \
（6）chmod u-w /etc/sudoers 
对于z2mini，已经添加celab106_z2mini，hxliang，lylai，xzlin可以使用超级管理员权限。
# 2,安装nodejs和yarn
```
curl -sL https://rpm.nodesource.com/setup_16.x | sudo bash -
curl -sL https://dl.yarnpkg.com/rpm/yarn.repo | sudo tee /etc/yum.repos.d/yarn.repo
sudo yum update
sudo yum install nodejs -y
sudo npm install -g yarn
```
如果出现Invalid configuration value: failovermethod=priority in /etc/yum.repos.d/nodesource-el8.repo; Configuration: OptionBinding with id "failovermethod" does not exist,那么添加#注释掉/etc/yum.repos.d/nodesource-el8.repo的failovermethod=priority
# 3,安装valgrind和cmake
```
sudo yum install valgrind* -y
sudo yum install cmake -y
```
# 4,安装zsh,omz,zinit,ksh
已为celab106_z2min和root用户执行
```
sudo yum install zsh ksh -y
chsh -s /bin/zsh
reboot
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
sh -c "$(curl -fsSL https://git.io/zinit-install)"
```
# 5,安装pip等
```
sudo dnf install python3-pip
sudo su
python3 -m pip install pip –-upgrade
python3 -m pip config set global.index-url https://mirrors.cloud.tencent.com/pypi/simple
exit
python3 -m pip config set global.index-url https://mirrors.cloud.tencent.com/pypi/simple
pip install pysnooper ipdb
pip install compiledb #(a tool for you to create a compile_commands.json if you use make to manage your c/c++ project)
pip install pylint yapf futures isort pygments cmake_format hdl_checker vim-vint cmakelang pyright
pip install cppman you-get
```
# 6,从源码编译安装vim和neovim
（1）卸载原来的vim
```
yum list installed | grep -i vim
sudo rm /usr/share/vim -r
```
卸载除了vim-minimal以外的vim相关工具
Note: Even though vim-minimal is on the list, do not remove it. Functions of sudo are dependent on vim-minimal.
（2）先安装ctags和gtags
```
sudo yum -y install autoconf automake libtool
git clone https://github.com/universal-ctags/ctags.git
cd ctags
./autogen.sh
./configure --prefix=/where/you/want # defaults to /usr/local
make
sudo make install # may require extra privileges depending on where to install
cd ~/Downloads/program
#去https://mirrors.aliyun.com/gnu/global/下载global-6.6.8.tar.gz
x global-6.6.8.tar.gz #x为解压命令
cd global-6.6.8
sudo yum install ncurses-devel -y 
./configure
make
make check
sudo make install
make installcheck
```
（3）编译安装vim
```
cd ~/Downloads/program
sudo yum -y install ncurses* tcl-devel git ruby ruby-devel
sudo yum -y install lua luajit luajit-devel
sudo yum -y install python3 python3-devel perl perl-devel
sudo yum -y install perl-ExtUtils-ParseXS 
sudo yum -y install perl-ExtUtils-CBuilder perl-ExtUtils-Embed
sudo dnf --enablerepo=powertools -y install lua-devel
sudo yum -y install gtk2-devel.x86_64 libXt-devel.x86_64 libX11-devel.x86_64
sudo yum -y install libcanberra-gtk2.x86_64
git clone https://github.com/vim/vim.git
cd vim
./configure --with-features=huge \
            --enable-fail-if-missing \
            --enable-luainterp=yes \
            --enable-mzschemeinterp \
            --with-python-config-dir=/usr/lib64/python3.6/config-3.6m-x86_64-linux-gnu \
            --enable-python3interp=yes \
            --enable-tclinterp=yes \
            --enable-cscope \
            --enable-multibyte \
            --enable-gui=gtk2 \
            --enable-rubyinterp=yes \
            --enable-perlinterp # 进行configure时，即使安装了ncurses，也报错checking for tgetent()... configure: error : NOT FOUND!这是因为最下面两个enable的环境没配置好，要么取消这两个enable要么配置好环境。我取消了这两个配置。
make
sudo make install
```
（4）从源码编译neovim
```
cd ~/Downloads/program
git clone https://github.com/neovim/neovim
cd neovim
git checkout stable
sudo dnf -y install ninja-build libtool autoconf automake cmake gcc gcc-c++ make pkgconfig unzip patch gettext curl --enablerepo=powertools
make CMAKE_BUILD_TYPE=Release #repeat until success
sudo make install
sudo su
python3 -m pip install neovim
exit
```
（5）分别为vim和neovim安装vim-plug(根用户和其它用户需要自己执行，这里我已为celab106_z2min执行) 
```
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://ghproxy.com/https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://ghproxy.com/https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
```
（6）sudo su进入的root用户可能无法使用vim和nvim，这是因为它们是被安装在/usr/local/bin中，如果想要sudo su进入的root用户使用，可以在.bashrc或.zshrc中添加下面这句话
```
export PATH=$PATH:/usr/local/bin
```
（7）安装coc插件和配置coc-settings.json \
  1)coc-omni,coc-word,coc-markdownlint coc-vimlsp,coc-dictionary,coc-tag,coc-cmake,coc-sh,coc-css,coc-json,coc-pyright,coc-yaml,coc-cl,coc-clangd,coc-snippets (第一个补全选项要么直接按enter要么按了tab一会儿后再按enter否则补全会有问题)
  如果想添加coc的补全拥有机械学习能力请参考coc-tabnine,缺点：耗内存和GPU,可能要钱。\
  2)去[配置文件](https://github.com/0BananaBig0/configuration_file)网站下载.vimrc文件并迁移到~里面 \
  3)去[配置文件](https://github.com/0BananaBig0/configuration_file)网站下载coc-settings.json文件并迁移到~/.vim里面 \
  4)去[配置文件](https://github.com/0BananaBig0/configuration_file)网站下载.vimspectorjson文件并迁移到~/.vim里面 \
  5)如果同时安装了vim和nvim还需要建立符号链接:
使nvim和vim共享配置,注意在判断文件类型哪里nvim不允许==两边参数存在空格,vim和nvim的set配置也不许=左右两边的参数存在空格,但是let的语法允许
```
cd ~/.config
mkdir nvim
ln -s /home-local/celab106_z2mini/.vim/coc-settings.json /home-local/celab106_z2mini/.config/nvim/coc-settings.json
ln -s /home-local/celab106_z2mini/.vimrc /home-local/celab106_z2mini/.config/nvim/init.vim     
```
# 7,解决lsb_release command not found
```
sudo dnf -y install redhat-lsb-core
```
# 8,安装ripgrep(命令:rg)代替grep
```
sudo yum install -y yum-utils device-mapper-persistent-data lvm2
sudo yum-config-manager --add-repo=https://copr.fedorainfracloud.org/coprs/carlwgeorge/ripgrep/repo/epel-7/carlwgeorge-ripgrep-epel-7.repo
sudo yum update
sudo yum install ripgrep -y
```
# 9,yum update失败,提示:(rocky linux没这个问题，所以没换源)
Error: Failed to download metadata for repo 'AppStream': Cannot prepare internal mirrorlist: No URLs in mirrorlist但可以正常上网，解决方法或者换源：
```
sudo su
cd /etc
cp yum.repos.d yum.repos.d.backup -r #backup
cd yum.repos.d
sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*
sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*
yum update
exit
```
换源
```
cd /etc
sudo cp yum.repos.d yum.repos.d.bak -r #backup
cd yum.repos.d
sudo rm CentOS-*.repo
sudo wget -O /etc/yum.repos.d/CentOS-Base-tencent.repo http://mirrors.cloud.tencent.com/repo/centos8_base.repo #Download source from tencent
sudo vim CentOS-Base-tencent.repo
#分别把[]里面的BaseOS，AppStream和PowerTools替换为baseos，appstream和powertools
cd ../yum.repos.d.backup
sudo cp CentOS-Linux-ContinuousRelease.repo CentOS-Linux-Devel.repo CentOS-Linux-Debuginfo.repo CentOS-Linux-HighAvailability.repo CentOS-Linux-Media.repo CentOS-Linux-Sources.repo ../yum.repos.d #copy sources that tencent not support
sudo yum clean all
sudo yum makecache
```
# 10,在CentOS下有的时候用yum安装软件的时候最后会提示：
warning: rpmts_HdrFromFdno: Header V3 DSA signature: NOKEY, key ID***** \
这是由于yum安装了旧版本的GPG keys造成的,解决办法就是
```
rpm --import /etc/pki/rpm-gpg/RPM*
```
再安装软件就不会有这个错误提示了。
# 11,解决hds和vsim字体缺失问题
```
sudo yum install xorg*fonts* -y
```
# 12,goldendic配置大全(这个没有弄)
https://zhuanlan.zhihu.com/p/344770839
# 13,markdown(缩写为md)文件转docx或pdf工具
```
sudo dnf install pandoc texlive-xetex texlive-luatex texlive-pstricks -y --enablerepo=powertools
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
# 14,安装xfce4,neovim剪贴板，terminator，rlwrap
```
\# if you are not a root, please add sudo for all command.
sudo dnf install epel-release -y
sudo dnf groupinstall Xfce -y
sudo systemctl disable gdm
sudo dnf install sddm -y
sudo systemctl enable sddm
sudo systemctl set-default graphical.target
reboot
sudo dnf install xclip terminator
sudo yum install rlwrap -y
```
After rebooting, Select “Xfce session” from the Session dropdown menu which may be on the upper-left corner and login.
# 15,安装centos8注意事项
（1）记得打开网络再安装。
（2）使用linux的dd制作U盘启动盘
（3）记得把用户的home改成home-local
# 16,安装go，goneovim
## install go language
```
sudo yum install golang
#Set $GOPATH 下面这个貌似没有也可以
mkdir -p ~/go/{bin,pkg,src}
echo 'export GOPATH="$HOME/go"' >> ~/.bashrc
echo 'export PATH="$PATH:${GOPATH//://bin:}/bin"' >> ~/.bashrc
source ~/.bashrc
```
## 更换go的镜像源,在.bashrc或.zshrc中加入下面这个
```
# Set the GOPROXY environment variable
export GOPROXY=https://goproxy.io,direct
# Set environment variable allow bypassing the proxy for specified repos (optional)
export GOPRIVATE=git.mycompany.com,github.com/my/private
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
# 安装配置文件
去[配置文件](https://github.com/0BananaBig0/configuration_file)下载settings.toml并迁移到~/.config/goneovim
# 17,安装ttf字体和字体管理工具
```
sudo yum install fontconfig ttmkfdir #去https://www.nerdfonts.com/font-downloads下载DejaVuSansMono,FantasqueSansMono,InconsolataLGC字体
x DejaVuSansMono.zip FantasqueSansMono.zip InconsolataLGC.zip #解压文件
cd /usr/share/fonts
sudo cp -r ~/Downloads/program/font/FantasqueSansMono ~/Downloads/program/font/DejaVuSansMono ~/Downloads/program/font/InconsolataLGC .
sudo chown root:root DejaVuSansMono FantasqueSansMono InconsolataLGC -R
sudo chmod 755 DejaVuSansMono FantasqueSansMono InconsolataLGC -R
sudo fc-cache
```
# 18,git配置
```
sudo dnf install git
git config --global user.name "0BananaBig0"
git config --global user.email "1184903633@qq.com"
git config --global alias.logline "log --graph --abbrev-commit"
git config --global core.editor gvim
git config --global url."https://hub.fastgit.xyz/".insteadOf "https://github.com/"
git config --global protocol.https.allow always
```
# 19,ale找不到头文件的解决办法：
## 对于cmake和catkin:
(1)把set(CMAKE_EXPORT_COMPILE_COMMANDS 1)添加到在CMakeList.txt的project语句下面然后编译,再把生成的compile_commands.json复制到工程目录；\
(2)把build的compile_commands.json复制到工程目录；\
(3)自己写compile_commands.json \
(4)catkin_make -DCMAKE_EXPORT_COMPILE_COMMANDS=YES \
(5)建立compile_commands.json硬链接/ 软连接,也可以修改.vimrc的g:ale_c_build_dir_names \
(6)写compile_flags.txt \
## 对于make:
为基于GNUmake的构建系统生成Clang的JSON编译数据库文件的工具。\
它主要针对non-cmake(cmake已经生成了编译数据库)的大型代码库。受YCM-Generator和Bear这样的项目的启发,但是速度更快(主要是大型项目),因为在大多数情况下,它不需要一个干净的构建(如前面提到的工具那样)来生成编译数据库文件,为了实现这一点,它使用make选项,比如-n/--dry-run和-k/--keep-going来提取编译命令。而且,与YCM-generator'sfake-toolchanin方法相比,cross-compiling更友好。\
### Installation
```
sudo su
python3 -m pip install compiledb
exit
```
支持Python2.x和3.x(目前,仅在2.7和3.6版本中测试) \
例如,对于bash完成支持,可以将sh-completion/compiledb.bash文件的内容添加到.bashrc文件中。 \
ZSH即将完成：\
### Usage 
compiledb提供了一个makepython包装器脚本,除了执行makebuild命令外,它还更新与该构建相对应的JSON编译数据库文件,从而产生一个类似于Bear的command-line接口。\
要使用compiledb的“make wrapper”脚本生成compile_commands.json文件,请执行Makefile targetall： 
```
 compiledb make
```
compiledb将make子命令后传递的所有选项/参数转发给gnumake,因此可以使用core/main.mk作为主makefile(-f标志)生成compile_commands.json,从build目录(-C标志)开始构建：
```
 compiledb make -f core/main.mk -C build
```
默认情况下,compiledb make生成编译数据库并运行请求的实际构建命令(充当make包装器),可以使用-n或--no-build选项跳过构建步骤。
```
 compiledb -n make
```
compiledbbase命令被设计成可以用来解析来自任意文本文件(或stdin)的编译命令,假设它有一个构建日志(理想情况下使用make -Bnwk命令生成),并生成相应的JSON编译数据库。\
例如,要从build-log.txt文件生成编译数据库,请使用以下命令。
```
 compiledb --parse build-log.txt
```
或其等效物：
```
 compiledb < build-log.txt
```
甚至可以通过管道make的输出并将编译数据库打印到标准输出：
```
 make -Bnwk | compiledb -o-
```
默认情况下,compiledb以“参数”列表格式生成一个JSON编译数据库。使用--command-style标志也支持“命令”字符串格式：
```
 compiledb --command-style make
```
# 20,安装多个gcc版本并临时切换
```
sudo dnf -y install gcc-toolset-11 
source /opt/rh/gcc-toolset-11/enable
sudo dnf -y install gcc-toolset-9*
source /opt/rh/gcc-toolset-9/enable
```
# 21,安装bazel和svlangserver和verible
## Install bazel
```
sudo dnf install dnf-plugins-core -y
sudo dnf copr enable vbatts/bazel -y
sudo dnf install bazel3 -y
```
## Install svlangserver
```
sudo npm install -g @imc-trading/svlangserver
```
https://github.com/chipsalliance/verible  \
看bazel官网,看imc-trading/svlangserver的github,看chipsalliance/verible的github\
注意gcc的版本，如果切换了gcc的版本再编译会出现bug，需要删除~/.cache/bazel里面对应的文件夹重新编译才行。
```
cd ~/Downloads/program
git clone https://github.com/chipsalliance/verible  \
cd verible
source /opt/rh/gcc-toolset-9/enable
BAZEL_LINKOPTS="-static-libstdc++:-lm" BAZEL_LINKLIBS="-l%:libstdc++.a" bazel build --cxxopt='-std=c++17' //...
BAZEL_LINKOPTS="-static-libstdc++:-lm" BAZEL_LINKLIBS="-l%:libstdc++.a" bazel test -c opt --cxxopt='-std=c++17' //...
BAZEL_LINKOPTS="-static-libstdc++:-lm" BAZEL_LINKLIBS="-l%:libstdc++.a" bazel run -c opt :install -- -s /usr/local/bin --cxxopt='-std=c++17' //...
```
# 22,解决verilog找不到模块问题,ale使用iverilog,verilator
使用语法
```
`include "xxx.v"
```
包含模块所在v文件
# 23,编译安装verilator
```
cd ~/Downloads/program
git clone https://github.91chi.fun//https://github.com/verilator/verilator.git
sudo dnf -y --enablerepo=powertools install git perl python3 make ccache numactl autoconf flex bison
cd verilator
unset VERILATOR_ROOT
git checkout stable
autoconf
./configure
make
make test
sudo make install
```
# 24,安装rust和exa,使用exa代替ls
```
sudo yum install rustc
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
sudo yum -y install cargo
cargo install exa
```
添加下面这句环境路径到.bashrc或者.zshrc中
```
export PATH=$PATH:~/.cargo/bin
```
root和user用户通过cargo安装的软件不一定通用,具体看PATH的设置。
我这里是单独分开来设置的,因此只对celab106_z2mini用户进行了配置。
# 25,安装gdb-11
在https://ftp.gnu.org/gnu/gdb/下载gdb-11.2.tar.xz到/home-local/celab106_z2mini/Downloads/program
```
cd ~/Downloads/program
sudo dnf remove gdb-gdbserver.x86_64 gdb.x86_64 gdb-doc.noarch gdb-headless.x86_64
sudo dnf clean all
sudo yum install gmp-c++.x86_64 gmp-devel.x86_64
x gdb-11.2.tar.xz
cd gdb-11.2
./configure
make
sudo make install
```
# 26,安装显卡驱动和cuda
```
wget https://developer.download.nvidia.com/compute/cuda/11.6.0/local_installers/cuda-repo-rhel8-11-6-local-11.6.0_510.39.01-1.x86_64.rpm 
sudo rpm -i cuda-repo-rhel8-11-6-local-11.6.0_510.39.01-1.x86_64.rpm 
sudo dnf clean all
sudo dnf -y module install nvidia-driver:latest-dkms 
sudo dnf -y install cuda
reboot
nvidia-smi
nvcc -V
```
开机时见到HP的标志立刻按F10，进入bios设置（或者按Esc再选择bios设置），然后关闭secure boot（仅关闭该选项即可，如果不懂其它选项，别关闭其它选项，否则可能会导致无法正常开机），否则会导致图形界面无法启动。
同时也要去到bios的高级选项的电源管理哪里打开支持键盘唤醒。
# 27,安装vncserver
```
sudo dnf -y install libvncserver.x86_64
sudo dnf -y install tigervnc-server
vim ~/.vnc/xstartup
```
把原来的内容注释掉更改为（或者使用老师提供的xstartup）：
```
#!/bin/sh
unset SESSION_MANAGER
unset DBUS_SESSION_BUS_ADDRESS
exec startxfce4 
```
新的vncserver使用方法
```
gvim /usr/share/doc/tigervnc/HOWTO.md
```
添加用户到固定的端口
```
sudo vim /etc/tigervnc/vncserver.users
```
添加以下内容
```
:3=hxliang
```
修改vnc默认配置
```
sudo vim /etc/tigervnc/vncserver-config-defaults
```
注释掉vncserver-config-defaults的session=gnome \
添加以下内容到vncserver-config-defaults
```
sesssion=xfce4
geometry=1920x1080
```
执行以下命令
```
sudo su
vncpasswd #为每个用户设置通用密码，需要用户自己后续更改，默认123456
systemctl enable vncserver@:3
systemctl start vncserver@:3
```
开启防火墙端口
```
ps -ef | grep vnc #查看需要开启那个端口
firewall-cmd --zone=public --add-port=5903/tcp --permanent #5903这个端口是我用的，我没有开启，但是我能正常使用vnc，可能因为remmina使用vnc时是通过ssh链接的所以不需要开启，但是非remmina用户可能需要开启
firewall-cmd --reload
exit
```
# 28,更改时区
```
sudo dnf -y install chrony
systemctl enable chronyd
systemctl start chronyd
timedatectl set-timezone Asia/Shanghai
```
# 29,默认浏览器和终端不需要vpn快速链接github
（1）默认浏览器在linux使用firefox，在win10使用edge因为不用翻墙就能下载插件。
（2）浏览器下载“Hoxx VPN Proxy”插件，这个插件可以帮助浏览器翻墙。
（3）浏览器下载“GitHub加速”插件，这个插件可以提供不需要翻墙就能快速链接github的网址：
      1）打开某一github仓库
      2）点击网页上的加速按钮，这个按钮会提供四个网址，前三个是用于克隆别人的仓库的，使用的是HTTPS协议。由于github现在只允许使用SSH协议上传仓库，所以前三个网址只能用于克隆仓库，如果既需要克隆仓库也需要上传文件到仓库，需要使用第四个网址，第四个网址用于代替github的code按钮所提供的网址。
      3）因为加速按钮前三个网址是别人提供的，有时由于未知力量可能会导致某一个或者某两个网址用不了，此时只需要把已克隆的本地仓库文件里面的.git/config的url更改为可以用的那个网址即可。
## 也可以使用[github代理](https://ghproxy.com/)
# 30,允许程序使用sudo，允许root使用celab106_z2mini的exa程序，允许root使用/usr/local/bin的程序
对于需要sudo以及允许root使用的/usr/local/bin的命令可以使用ln建立软连接到/usr/bin
```
#对于bash
vim /root/.bashrc
#对于zsh
vim /root/.zshrc
```
添加
```
export PATH=$PATH:/home-local/celab106_z2mini/.cargo/bin
```
# 31,安装cudnn和tensorrt
## install cudnn
```
cd ~/Downloads/program/
x cudnn-linux-x86_64-8.3.2.44_cuda11.5-archive.tar.xz
cd cudnn-linux-x86_64-8.3.2.44_cuda11.5-archive
sudo cp include/cudnn*.h /usr/local/cuda/include 
sudo cp -P lib/libcudnn* /usr/local/cuda/lib64 
sudo chmod a+r /usr/local/cuda/include/cudnn*.h /usr/local/cuda/lib64/libcudnn*
```
## install tensorrt
```
cd ~/Downloads/program/
sudo rpm -Uvh nv-tensorrt-repo-rhel8-cuda11.4-trt8.2.3.0-ga-20220113-1-1.x86_64.rpm
sudo yum clean expire-cache
sudo yum -y install tensorrt
sudo yum -y install python3-libnvinfer-devel
sudo yum -y install uff-converter-tf
sudo yum -y install onnx-graphsurgeon
sudo su
python3 -m pip install protobuf
python3 -m pip install numpy onnx
exit
rpm -qa | grep tensorrt
```
# 32,设置默认python
```
sudo alternatives --set python /usr/bin/python3
```
# 33,安装opencv4
```
cd ~/Downloads/program
mkdir opencv4
cd opencv4
git clone https://github.com/opencv/opencv
git clone https://github.com/opencv/opencv_contrib
sudo dnf -y --enablerepo=powertools install epel-release git qt5-qtbase-devel \
 python3-devel cmake python3-numpy \
 gtk2-devel libpng-devel jasper-devel openexr-devel libwebp-devel \
 libjpeg-turbo-devel libtiff-devel tbb-devel libv4l-devel \
 freeglut-devel mesa-libGL mesa-libGL-devel \
 boost boost-thread boost-devel gstreamer1-plugins-base \
 eigen3-devel openblas-devel.x86_64 openjpeg2-devel.x86_64 libva-devel.x86_64
mkdir build
cd build
cmake -DOPENCV_EXTRA_MODULES_PATH=../opencv_contrib/modules ../opencv -D CMAKE_BUILD_TYPE=RELEASE -D WITH_CUDA=ON -D WITH_CUBLAS=ON -D CUDA_ARCH_BIN='7.5' -D OPENCV_GENERATE_PKGCONFIG=YES  -D CUDA_FAST_MATH=Yes -D WITH_OPENCL=ON -D ENABLE_FAST_MATH=ON
make -j20
sudo make install
sudo ln -s /usr/local/lib64/pkgconfig/opencv4.pc /usr/share/pkgconfig/
sudo ldconfig
pkg-config --modversion opencv4
python3 -c "import cv2; print(cv2.__version__)"
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
# 34,安装7z解压软件
```
sudo dnf -y install p7zip.x86_64 p7zip-plugins.x86_64
```
# 35,安装opencl和clinfo，这个和cuda提供的有点不同
## 安装opencl
```
sudo dnf --enablerepo=powertools install opencl-headers.noarch
yum provides '*/libOpenCL.so' --enablerepo=powertools
sudo dnf install ocl-icd-devel-2.2.12-1.el8.x86_64 --enablerepo=powertools -y
sudo dnf install ocl-icd.x86_64 -y
```
## 安装clinfo
```
cd ~/Downloads/program
git clone https://github.91chi.fun//https://github.com/Oblomov/clinfo.git
cd clinfo
make
sudo make install
```
# 36,64位系统执行32位程序报错:缺少相关32位程序的库
/cadtools/Mentor/QuestaSim/2020.3/bin/vsim: line 182: /cadtools/Mentor/QuestaSim/2020.3/bin/../linux/vsim: No such file or directory
```
sudo dnf install --enablerepo=powertools glibc.i686 libstdc++-devel.i686 libXext-devel-1.3.4-1.el8.i686 libXft-devel-2.3.3-1.el8.i686 glibc-devel redhat-lsb-core.i686
```
# 37,安装sublime text最新版
```
sudo rpm -v --import https://download.sublimetext.com/sublimehq-rpm-pub.gpg
sudo wget -P /etc/yum.repos.d/ https://download.sublimetext.com/rpm/stable/x86_64/sublime-text.repo
sudo dnf install sublime-text
```
# 38,如何确定系统所用屏保软件
```
ps aux | grep screen
```
然后搜索linux如何关闭xxx的屏保，例如xscreensaver
# 39,更改权限，方便用户进来复制文件
```
cd ~
chmod 755 .vimrc .zshrc
chmod 755 .config/nvim -R
chmod 755 .vim -R
chmod 755 Documents/configuration_file -R
chmod 755 Downloads/program/Goneovim-v0.5.1-linux -R
chmod 755 .vnc -R
cd ..
chmod 755 celab106_z2mini
```
# 40,解决centos下非root用户频繁出现Authentication is required to set
  非root用户登陆linux服务器，总是弹出一个对话框，而且关闭之后，过一段时间还会弹出来。对话框的内容是：Authentication is required to set the network proxy used for downloading packages。然后提示你输入root密码。 \
  解决办法：在终端窗口（右键，open in terminal）输入“gnome-session-properties”。然后把“PackageKit Update Applet”前面的勾去掉就行了或者换成xfce
# 41,解决没有root权限的普通用户使用vnc提示:
XFCE PolicyKit Agent \
GDBus.Error:org.freedesktop.PolickKit1.Error.Failed:An authentication agent already exists for the given subject.
```
open Setting > Session and Startup > Application Autostart
Remove the check mark(√) of XFCE PolKit(Policykit Authentication Agent)[In other systems, it may be called PolicyKit Authentication Agent(Policykit Authentication Agent)]
```
# 42,编译minisat缺少静态库，提示:
/usr/bin/ld: cannot find -lz \
/usr/bin/ld: cannot find -lstdc++ \
/usr/bin/ld: cannot find -lm \
/usr/bin/ld: cannot find -lc \
```
sudo dnf install glibc-static libstdc++-static zlib-static --enablerepo=powertools
```
