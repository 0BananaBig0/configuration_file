<!-- vim-markdown-toc GFM -->

* [NOTE](#note)
* [0,Precautions for making centos7 U disk and startup disk](#0precautions-for-making-centos7-u-disk-and-startup-disk)
* [1,install the driver of Ethernet](#1install-the-driver-of-ethernet)
* [2,Change the mount point of /home (Only when we create a user in /home-local, it works)](#2change-the-mount-point-of-home-only-when-we-create-a-user-in-home-local-it-works)
* [3,install nodejs and yarn](#3install-nodejs-and-yarn)
* [4,install the third part software soure](#4install-the-third-part-software-soure)
* [5,install gcc7,gcc9,gcc11,cmake3](#5install-gcc7gcc9gcc11cmake3)
* [6,install different verisons and config git](#6install-different-verisons-and-config-git)
* [add the following content to your .bashrc or .zshrc](#add-the-following-content-to-your-bashrc-or-zshrc)
* [execute the following command](#execute-the-following-command)
* [7,Synchronization time](#7synchronization-time)
* [8,Complie and install LLVM13](#8complie-and-install-llvm13)
* [9,install zsh,omz,zinit,ksh](#9install-zshomzzinitksh)
* [10,install fce4,terminator,rlwrap,doxygen](#10install-fce4terminatorrlwrapdoxygen)
* [11,install nvidia driver and cuda](#11install-nvidia-driver-and-cuda)
* [12,install python3,pip and some python3 tools](#12install-python3pip-and-some-python3-tools)
* [13,compile and install gdb, configure .gdbinit](#13compile-and-install-gdb-configure-gdbinit)
* [14,compile and install valgrind](#14compile-and-install-valgrind)
* [15 compile git](#15-compile-git)
* [16,install ttf fonts and font manage tool](#16install-ttf-fonts-and-font-manage-tool)
* [17,compile and installl vim and neovim](#17compile-and-installl-vim-and-neovim)
* [18,install rust and some new command tools](#18install-rust-and-some-new-command-tools)
* [19,install go，goneovim](#19install-gogoneovim)
    * [install go language](#install-go-language)
    * [replace the morror source of go:](#replace-the-morror-source-of-go)
    * [install goneovim](#install-goneovim)
    * [install configuration files](#install-configuration-files)
* [20,install and configure vncserver and cockpit](#20install-and-configure-vncserver-and-cockpit)
    * [install vncserver](#install-vncserver)
    * [如果用户无法登录vnc，开启防火墙端口](#如果用户无法登录vnc开启防火墙端口)
    * [对于普通用户，先使用ssh登录自己的账户，再执行以下命令](#对于普通用户先使用ssh登录自己的账户再执行以下命令)
    * [关闭vnc的屏保](#关闭vnc的屏保)
    * [解决centos下非root用户频繁出现Authentication is required to set](#解决centos下非root用户频繁出现authentication-is-required-to-set)
    * [解决没有root权限的普通用户使用vnc提示:](#解决没有root权限的普通用户使用vnc提示)
    * [install cockpit](#install-cockpit)
* [21,编译minisat缺少静态库，提示:](#21编译minisat缺少静态库提示)
* [22,64位系统执行32位程序报错:缺少相关32位程序的库](#2264位系统执行32位程序报错缺少相关32位程序的库)
* [23,安装7z解压软件](#23安装7z解压软件)
* [24,安装sublime text最新版](#24安装sublime-text最新版)
* [25,解决hds和vsim字体缺失问题](#25解决hds和vsim字体缺失问题)
* [26,安装cudnn和tensorrt](#26安装cudnn和tensorrt)
    * [install cudnn](#install-cudnn)
    * [install tensorrt](#install-tensorrt)
* [27,安装opencl和clinfo，这个和cuda提供的有点不同](#27安装opencl和clinfo这个和cuda提供的有点不同)
    * [安装opencl](#安装opencl)
    * [安装clinfo](#安装clinfo)
* [28,安装opencv4](#28安装opencv4)
    * [由于某些未知力量的原因，可能会导致opencv4某些模块下载失败，要多次进行cmake，但是这样太过费时，所以可以使用代理解决，这里以常见的失败模块IPPICV为例子](#由于某些未知力量的原因可能会导致opencv4某些模块下载失败要多次进行cmake但是这样太过费时所以可以使用代理解决这里以常见的失败模块ippicv为例子)
    * [由于某些未知力量，face_landmark_model.dat可能会下载失败，解决办法:](#由于某些未知力量face_landmark_modeldat可能会下载失败解决办法)
* [29,markdown(缩写为md)文件转docx或pdf工具](#29markdown缩写为md文件转docx或pdf工具)
* [30,coc.nvim找不到头文件的解决办法：](#30cocnvim找不到头文件的解决办法)
    * [对于cmake和catkin:](#对于cmake和catkin)
    * [对于make:](#对于make)
        * [Installation](#installation)
* [31,安装bazel和svlangserver和verible](#31安装bazel和svlangserver和verible)
    * [Install bazel](#install-bazel)
    * [Install svlangserver](#install-svlangserver)
* [32,编译安装verilator](#32编译安装verilator)
    * [解决verilog找不到模块问题,coc.nvim使用iverilog,verilator](#解决verilog找不到模块问题cocnvim使用iverilogverilator)
* [33,更改权限，方便用户进来复制文件](#33更改权限方便用户进来复制文件)
* [34,安装virtual box6.1](#34安装virtual-box61)
* [35,解决nfs挂载硬盘普通用户没有访问权限问题](#35解决nfs挂载硬盘普通用户没有访问权限问题)
* [36,安装lace的依赖](#36安装lace的依赖)
* [37,安装intel核显驱动相关文件](#37安装intel核显驱动相关文件)
* [38,配置免密登录](#38配置免密登录)
* [39,安装vscode](#39安装vscode)
* [40,为ldap用户在特定ip的服务器更换shell，以hxliang用户和10.34.24.11为例](#40为ldap用户在特定ip的服务器更换shell以hxliang用户和10342411为例)
* [41,安装批量文件编码转换工具，以及解决windows文件名在linux显示乱码的工具](#41安装批量文件编码转换工具以及解决windows文件名在linux显示乱码的工具)
* [42,更换python的方法](#42更换python的方法)
* [43,add shell environment variables](#43add-shell-environment-variables)
* [compile duf to replace df](#compile-duf-to-replace-df)
* [44,configure multiple ssh keys](#44configure-multiple-ssh-keys)
    * [(1) execute the following commands.](#1-execute-the-following-commands)
    * [(2) add the following content to config file.](#2-add-the-following-content-to-config-file)
    * [(3) execute the following commands.](#3-execute-the-following-commands)
    * [(4) add the content of id_rsa.gitee to your gitee accout.](#4-add-the-content-of-id_rsagitee-to-your-gitee-accout)
    * [(5) add the content of id_rsa.github to your github accout.](#5-add-the-content-of-id_rsagithub-to-your-github-accout)
* [45 服务器开启后再接入显示器无信号需要重启的解决方法：](#45-服务器开启后再接入显示器无信号需要重启的解决方法)
* [46 服务器的Vivado无法识别fpga板子的解决方法：](#46-服务器的vivado无法识别fpga板子的解决方法)
* [47 close pulseaudio](#47-close-pulseaudio)
* [48 configure perl LSP](#48-configure-perl-lsp)
* [49 install a json formatter](#49-install-a-json-formatter)
* [50 use neovim as a backend of vscode](#50-use-neovim-as-a-backend-of-vscode)
* [51 latexmk](#51-latexmk)

<!-- vim-markdown-toc -->
# NOTE
All programs which are installed by the command "sudo make install" will be backup to /home/hxliang/Downloads/celab106_z2mini/program.
# 0,Precautions for making centos7 U disk and startup disk
(1) The size of U disk must be smaller than 32GB. \
(2) The format of U disk must be fat32. \
(3) We must use dd in a linux system to make centos& U disk and startup disk. \
(4) If we want to remain win10 systems, before install centos7, we shoule compress some storeage that you want to install centos7 in win10. \
(5) Close the fast startup in win10. \
(6) (Note, press ESC to enter the bios.)Enable USB boot in bios and disable fast boot and secure boot, also should change the boot order(make USB to be the first). \
(7) When install Centos7, we must partiton the storeage manually.(My partiton:[/,133G],[/home,/133G],[/boot/,1G],[/boot/efi,512M],[/var,132.5G],[/swap,64G]) \
(8) If we want to create a common user, we must let it in /home-local. so that we can mount our file system easily. \
(9) After finishing installation,reboot system, pull out the USB disk and enter the bios to change the boot order(make centos to be the first) and enable fast boot.

# 1,install the driver of Ethernet
Downloads the driver from the [intel](https://www.intel.com/content/www/us/en/download/14611/15817/intel-network-adapter-driver-for-pcie-intel-gigabit-ethernet-network-connections-under-linux.html?) to ~/Downloads/program, you will see it support our Ethernet hardware I219-LM.
```
tar xzvf e1000e-xxx.tar.gz
cd e1000e-xxx/src
make
sudo make install
sudo depmod -a #load the driver
sudo modprobe e1000e #test the driver. If correct, nothing happen.
lsmod #check if it had been loaded.
service network restart #restart network
```
Note: If you update your kernel, maybe you need to reinstall it. More detailed information, you can read its README file. But we can use its wifi. Its wifi ip is 172.22.174.43. Gcc version > 7.0

# 2,Change the mount point of /home (Only when we create a user in /home-local, it works)
```
ssh -X root@10.34.24.11
vim /etc/fstab
```
Use /home-local to replace /home in etc fstab
```
cd /
mkdir home-backup
mv /home-local/celab106_z2mini /home-backup
reboot
ssh -X root@10.34.24.11
cd /
mv /home-backup/celab106_z2mini /home-local
rm /home-backup -r
reboot
```

# 3,install nodejs and yarn
```
sudo yum remove -y nodejs npm
curl -sL https://rpm.nodesource.com/setup_16.x | sudo bash -
curl -sL https://dl.yarnpkg.com/rpm/yarn.repo | sudo tee /etc/yum.repos.d/yarn.repo
sudo yum install -y nodejs
npm config set registry https://registry.npm.taobao.org/
sudo npm install -g yarn
sudo npm install -g npm
```
如果出现Invalid configuration value: failovermethod=priority in /etc/yum.repos.d/nodesource-el7.repo; Configuration: OptionBinding with id "failovermethod" does not exist,那么添加#注释掉/etc/yum.repos.d/nodesource-el7.repo的failovermethod=priority

# 4,install the third part software soure
```
ssh -X celab106_z2mini@10.34.24.11
sudo su
cd /etc
cp yum.repos.d yum.repos.d.backup -r
yum install epel-release -y
yum install -y centos-release-scl #gcc source
rpm -Uvh http://rpms.remirepo.net/enterprise/remi-release-7.rpm
rpm -Uvh http://li.nux.ro/download/nux/dextop/el7/x86_64/nux-dextop-release-0-5.el7.nux.noarch.rpm
exit
sudo yum clean all
sudo yum makecache
```

# 5,install gcc7,gcc9,gcc11,cmake3
```
sudo yum install -y cmake3 devtoolset-9* cmake3-gui
sudo yum install -y devtoolset-7 devtoolset-11*
sudo yum remove cmake
sudo update-alternatives --install /usr/bin/cmake cmake /usr/bin/cmake3 3
sudo update-alternatives --install /usr/bin/ctest ctest /usr/bin/ctest3 3
sudo update-alternatives --install /usr/bin/cmake-gui cmake-gui /usr/bin/cmake3-gui 3
#add the following content to your .bashrc or .zshrc
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
系统永久更换gcc版本
```
sudo su
vim /etc/bashrc /etc/zshrc
#在这个文件添加后会导致omz的ZSH_CACHE_DIRECTORY环境变量切换出现问题。
```
在这两个文件添加如下内容
```
if [ -f "/opt/rh/devtoolset-9/enable" ]; then
  source /opt/rh/devtoolset-9/enable #or scl enable devtoolset-9 bash #only for .bashrc 
fi
```

# 6,install different verisons and config git
```
sudo yum install -y git rh-git227
```
#add the following content to your .bashrc or .zshrc
```
if [ -f "/opt/rh/rh-git227/enable" ]; then
  source /opt/rh/rh-git227/enable
fi
```
#execute the following command
```
git config --global user.name "Huaxiao Liang"
git config --global user.email "1184903633@qq.com"
git config --global alias.logline "log --graph --abbrev-commit"
git config --global core.editor gvim
#23年后下面这个梯子不知为啥挂掉了，请别执行下面这条命令，除非你尝试过梯子复活了
#git config --global url."https://github.91chi.fun//https://github.com/".insteadOf "https://github.com/"
git config --global protocol.https.allow always
git config --global push.default "current"
git config --global diff.tool gvimdiff
```
系统永久更换git版本
```
sudo su
vim /etc/bashrc /etc/zshrc
```
在这两个文件添加如下内容
```
if [ -f "/opt/rh/rh-git227/enable" ]; then
  source /opt/rh/rh-git227/enable
fi
```

# 7,Synchronization time
(1) Enter into centos7 and execute the following command:
```
sudo yum install –y chrony
timedatectl set-local-rtc 0
timedatectl set-timezone Asia/Shanghai
systemctl enable chronyd
systemctl start chronyd
sudo firewall-cmd --add-service=ntp --permanent
sudo firewall-cmd --reload
```
(2) Enter into win10 and synchronize time and do the following things
更改Windows注册表，使Windows用UTC标准存储硬件时钟。\
1.Win+R 打开“运行”,输入 regedit 打开注册表 \
2.在注册表钟找到HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\TimeZoneInformation文件夹 \
3.右键TimeZoneInformation----新建----DWORD(32)位值，名称：RealTimeIsUniversal ，再右键新建的DWORD----修改---值改为1，重启即可。\
(Referencee)[https://zhuanlan.zhihu.com/p/81895948]

# 8,Complie and install LLVM13
```
sudo yum install -y glibc.i686 glibc-devel.i686 zlib-devel libxml2-devel
cd ~/Downloads/program
git clone https://github.com/llvm/llvm-project/tree/main
cd llvm-project
git checkout release/13.x
source /opt/rh/devtoolset-9/enable
cmake -S llvm -B build -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=Release llvm -DLLVM_ENABLE_PROJECTS="clang;clang-tools-extra;flang;libclc;lld;lldb;polly;pstl;mlir" -DLLVM_ENABLE_RUNTIMES="libcxx;libcxxabi;libunwind;compiler-rt;libc;openmp" # projects/cross-project-tests/CMakeFiles/check-gdb-mlir-support.dir/all] Error
cd build
make -j20
sudo make install
```

# 9,install zsh,omz,zinit,ksh
has installed for celab106_z2min and root \
download source code of zsh from http://zsh.sourceforge.net/Arc/source.html to ~/Downloads/program
```
source /opt/rh/devtoolset-9/enable
sudo yum install zsh ksh -y
cd ~/Downloads/program
sudo yum -y install gcc perl-ExtUtils-MakeMaker
sudo yum -y install ncurses-devel
tar xvf zsh-5.9.tar.xz
cd zsh-5.9
./configure
make
sudo make install
sudo vim /etc/shells #add /usr/local/bin/zsh to /etc/shells
reboot
chsh -s /usr/local/bin/zsh
reboot
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
sh -c "$(curl -fsSL https://git.io/zinit-install)"
```

# 10,install fce4,terminator,rlwrap,doxygen
```
sudo yum groupinstall Xfce -y
sudo systemctl disable gdm
sudo yum install sddm -y
sudo systemctl enable sddm
sudo systemctl set-default graphical.target
reboot
sudo yum install xclip terminator doxygen* graphviz
sudo yum install rlwrap -y
```

# 11,install nvidia driver and cuda
Look at cuda website.
```
cd ~/Downloads/program
wget https://developer.download.nvidia.com/compute/cuda/11.4.0/local_installers/cuda-repo-rhel7-11-4-local-11.4.0_470.42.01-1.x86_64.rpm
sudo rpm -i cuda-repo-rhel7-11-4-local-11.4.0_470.42.01-1.x86_64.rpm
sudo yum clean all
sudo yum makecache
sudo yum -y install nvidia-driver-latest-dkms cuda-11-4
sudo yum -y install cuda-drivers
reboot
```

# 12,install python3,pip and some python3 tools
```
sudo yum install python3 python3-pip
sudo su
python3 -m pip install pip --upgrade
python3 -m pip config set global.index-url https://mirrors.cloud.tencent.com/pypi/simple
exit
python3 -m pip config set global.index-url https://mirrors.cloud.tencent.com/pypi/simple
python3 -m pip install pysnooper ipdb
python3 -m pip install pylint yapf futures isort pygments cmake_format vim-vint cmakelang pyright
python3 -m pip install cppman you-get sphinx sphinx-rtd-theme
# use httpie to replace replace curl and wget
python3 -m pip install httpie # command: http/https
```

# 13,compile and install gdb, configure .gdbinit
Download gdb-11.2.tar.xz from https://ftp.gnu.org/gnu/gdb/ to /home-local/celab106_z2mini/Downloads/program \
<!-- Download six-1.16.0 from https://files.pythonhosted.org/packages/source/s/six/six-1.16.0.tar.gz \ -->
<!-- Download gdb-11.2-upstream_fixes-1.patch from https://www.linuxfromscratch.org/patches/blfs/svn/gdb-11.2-upstream_fixes-1.patch \ -->
<!-- [reference](https://www.linuxfromscratch.org/blfs/view/svn/general/gdb.html) -->
```
source /opt/rh/devtoolset-9/enable
cd ~/Downloads/program
yum list installed | grep -i gdb
sudo yum remove gdb.x86_64 #not remove gdbm.x86_64
sudo yum install -y gmp-c++.x86_64 gmp-devel.x86_64
sudo yum -y install texinfo readline-devel
x gdb-11.2.tar.xz
cd gdb-11.2
./configure --enable-pretty-printer --enable-vtable-verify --with-python='/usr/bin/python3'
make
sudo make install
sudo update-alternatives --install /usr/bin/gdb gdb /usr/local/bin/gdb 3
sudo update-alternatives --install /usr/bin/gdb-add-index gdb-add-index /usr/local/bin/gdb-add-index 3
sudo update-alternatives --install /usr/bin/gdbserver gdbserver /usr/local/bin/gdbserver 3
sudo su
cd /opt/rh/devtoolset-9/root/usr/bin
mv gdb gdb-9
mv gdbserver gdbserver-9
mv gdb-add-index gdb-add-index-9
exit
sudo ln -s /usr/local/bin/gdb /opt/rh/devtoolset-9/root/usr/bin/gdb
sudo ln -s /usr/local/bin/gdb-add-index /opt/rh/devtoolset-9/root/usr/bin/gdb-add-index
sudo ln -s /usr/local/bin/gdbserver /opt/rh/devtoolset-9/root/usr/bin/gdbserver
```
移除方法
```
sudo update-alternatives --remove gdb /usr/local/bin/gdb
sudo update-alternatives --remove gdb-add-index /usr/local/bin/gdb-add-index
sudo update-alternatives --remove gdbserver /usr/local/bin/gdbserver
sudo rm /opt/rh/devtoolset-9/root/usr/bin/gdbserver
sudo rm /opt/rh/devtoolset-9/root/usr/bin/gdb-add-index
sudo rm /opt/rh/devtoolset-9/root/usr/bin/gdb
mv /opt/rh/devtoolset-9/root/usr/bin/gdb-9 /opt/rh/devtoolset-9/root/usr/bin/gdb
mv /opt/rh/devtoolset-9/root/usr/bin/gdbserver-9 /opt/rh/devtoolset-9/root/usr/bin/gdbserver
mv /opt/rh/devtoolset-9/root/usr/bin/gdb-add-index-9 /opt/rh/devtoolset-9/root/usr/bin/gdb-add-index
```
configure .gdbinit
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
sys.path.insert(0, '/opt/rh/devtoolset-9/root/usr/share/gdb/python')
from libstdcxx.v6.printers import register_libstdcxx_printers
register_libstdcxx_printers (None)
end



# // Add function to change string pointer to char pointer
# // so that we can print map[xxx] elements by gdb.
# // For example,std::unordered_map<std::string, std::string> map_test = {{"Hello","Mike"}},
# // we can print map_test[spToCp("Hello")]. Add the following content to your C/C++ source codes.
# std::string spToCp(const char *x) { return x; };
```
configure gef # only use for gdb command line.
```
gvim ~/.gdbgef #add the following content, do not add the following content to .gdbinit, it will affect vimspector.
```
```
source ~/Downloads/program/gef/gef.py
```
note:'/opt/rh/devtoolset-9/root/usr/share/gdb/python' is the path of libstdcxx

# 14,compile and install valgrind
Downloads valgrind from https://sourceware.org/pub/valgrind/ to /home-local/celab106_z2mini/Downloads/program
```
source /opt/rh/devtoolset-9/enable
cd ~/Downloads/program
x valgrind-3.18.1.tar.bz2
cd valgrind-3.18.1
./autogen.sh
./configure
make
sudo make install
sudo update-alternatives --install /usr/bin/valgrind valgrind /usr/local/bin/valgrind 3
sudo update-alternatives --install /usr/bin/valgrind-di-server valgrind-di-server /usr/local/bin/valgrind-di-server 3
sudo update-alternatives --install /usr/bin/valgrind-listener valgrind-listener /usr/local/bin/valgrind-listener 3
```

# 15 compile git
```
cd ~/Downloads/program
sudo yum install docbook2X xmlto asciidoc
git clone https://github.com/git/git.git
cd git
sudo make prefix=/cadtools/optional_program/git238 install install-doc install-html install-info
```

# 16,install ttf fonts and font manage tool
```
sudo yum install fontconfig ttmkfdir #去https://www.nerdfonts.com/font-downloads下载DejaVuSansMono,FantasqueSansMono,InconsolataLGC字体
x DejaVuSansMono.zip FantasqueSansMono.zip InconsolataLGC.zip #解压文件
cd /usr/share/fonts
sudo cp -r ~/Downloads/program/font/FantasqueSansMono ~/Downloads/program/font/DejaVuSansMono ~/Downloads/program/font/InconsolataLGC .
sudo chown root:root DejaVuSansMono FantasqueSansMono InconsolataLGC -R
sudo chmod 755 DejaVuSansMono FantasqueSansMono InconsolataLGC -R
sudo fc-cache
```

# 17,compile and installl vim and neovim
（1）remove the original vim
```
yum list installed | grep -i vim
sudo yum remove vim-common vim-enhanced vim-filesystem
```
remove all tools about vim except vim-minimal
Note: Even though vim-minimal is on the list, do not remove it. Functions of sudo are dependent on vim-minimal.
（2）先安装ctags和gtags
```
yum list installed | grep -i ctags
sudo yum remove ctags
sudo yum -y install autoconf automake libtool
cd ~/Downloads/program
git clone https://github.com/universal-ctags/ctags.git
cd ctags
source /opt/rh/devtoolset-9/enable
./autogen.sh
./configure --prefix=/where/you/want # defaults to /usr/local
make
sudo make install # may require extra privileges depending on where to install
cd ~/Downloads/program
#去https://mirrors.aliyun.com/gnu/global/下载global-6.6.8.tar.gz
cd ~/Downloads/program
x global-6.6.8.tar.gz # x为解压命令
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
sudo yum install -y ruby ruby-devel lua lua-devel luajit \
luajit-devel git python python-devel \
python36 python36-devel tcl-devel \
perl perl-devel perl-ExtUtils-ParseXS \
perl-ExtUtils-XSpp perl-ExtUtils-CBuilder \
perl-ExtUtils-Embed libX* ncurses-devel gtk2-devel \
gpm gpm-libs gpm-devel
cd ~/Downloads/program
git clone https://github.com/vim/vim.git
cd vim
source /opt/rh/devtoolset-9/enable
./configure --with-features=huge \
            --enable-fail-if-missing \
            --enable-luainterp=yes \
            --enable-mzschemeinterp \
            --enable-perlinterp=yes \
            --enable-pythoninterp=yes \
            --enable-python3interp=yes \
            --with-python3-config-dir=/usr/lib64/python3.11/config-3.11m-x86_64-linux-gnu \
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
            --with-compiledby="Banana"
make
sudo make install
```
（4）从源码编译neovim
```
cd ~/Downloads/program
source /opt/rh/devtoolset-9/enable
git clone https://github.com/neovim/neovim
cd neovim
git checkout stable
sudo yum install rh-python38 xclip
sudo ln -s /opt/rh/rh-python38/root/usr/bin/python3.8 /usr/bin/
sudo yum -y install ninja-build libtool autoconf automake cmake3 gcc gcc-c++ make pkgconfig unzip patch gettext curl
make CMAKE_BUILD_TYPE=Release #repeat until success
sudo make install
sudo su
python -m pip install neovim
npm install -g neovim
gem sources -r https://rubygems.org/ -a https://gems.ruby-china.com/
#sudo gem install neovim
exit
```
（5）分别为vim和neovim安装vim-plug(根用户和其它用户需要自己执行，这里我已为celab106_z2min执行) 
```
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://ghproxy.com/https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://ghproxy.com/https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
```
（6）创建符号链接到/usr/bin，否则显示器直连服务器时的sudo su进入的root用户以及sudo命令无法使用vim
```
sudo update-alternatives --install /usr/bin/vim vim /usr/local/bin/vim 3
sudo update-alternatives --install /usr/bin/gvim gvim /usr/local/bin/vim 3
sudo update-alternatives --install /usr/bin/nvim nvim /usr/local/bin/nvim 3
sudo update-alternatives --install /usr/bin/eview eview /usr/local/bin/vim 3
sudo update-alternatives --install /usr/bin/evim evim /usr/local/bin/vim 3
sudo update-alternatives --install /usr/bin/ex ex /usr/local/bin/vim 3 # vi also has
sudo update-alternatives --install /usr/bin/gview gview /usr/local/bin/vim 3
sudo update-alternatives --install /usr/bin/gvimdiff gvimdiff /usr/local/bin/vim 3
sudo update-alternatives --install /usr/bin/gvimtutor gvimtutor /usr/local/bin/vim 3
sudo update-alternatives --install /usr/bin/rgview rgview /usr/local/bin/vim 3
sudo update-alternatives --install /usr/bin/rgvim rgvim /usr/local/bin/vim 3 # vi also has
sudo update-alternatives --install /usr/bin/rview rview /usr/local/bin/vim 3
sudo update-alternatives --install /usr/bin/rvim rvim /usr/local/bin/vim 3
sudo update-alternatives --install /usr/bin/view view /usr/local/bin/vim 3 # vi also has
sudo update-alternatives --install /usr/bin/vimdiff vimdiff /usr/local/bin/vim 3
sudo update-alternatives --install /usr/bin/vimtutor vimtutor /usr/local/bin/vim 3
sudo update-alternatives --install /usr/bin/xxd xxd /usr/local/bin/xxd 3
```
（7）安装coc插件和配置coc-settings.json \
  1)coc-word,coc-markdownlint coc-vimlsp,coc-dictionary,coc-tag,coc-cmake,coc-sh,coc-css,coc-json,coc-pyright,coc-yaml,coc-snippets (第一个补全选项要么直接按enter要么按了tab一会儿后再按enter否则补全会有问题)
  如果想添加coc的补全拥有机械学习能力请参考coc-tabnine,缺点：耗内存和GPU,可能要钱。\
  2)去[配置文件](https://github.com/0BananaBig0/configuration_file)网站下载.vimrc文件并迁移到~里面
  3)去[配置文件](https://github.com/0BananaBig0/configuration_file)网站下载coc-settings.json文件并迁移到~/.vim里面 \
  4)去[配置文件](https://github.com/0BananaBig0/configuration_file)网站下载.vimspectorjson文件并迁移到~/.vim里面 \
  5)如果同时安装了vim和nvim还需要建立符号链接:
使nvim和vim共享配置,注意在判断文件类型哪里nvim不允许==两边参数存在空格,vim和nvim的set配置也不许=左右两边的参数存在空格,但是let的语法允许
```
cd ~/.config
mkdir nvim
```

# 18,install rust and some new command tools
```
sudo yum -y install cargo rustc
cd ~
mkdir .cargo
cd .cargo
gvim config
```
add the following content to config for replacing the mirror source of cargo
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
# not do for root
cargo install exa # replace ls, command: exa
cargo install ripgrep # replace grep, command: rg
cargo install fd-find # replace find, command: fd
cargo install du-dust # replace du, command: dust
cargo install procs # replace ps, command: procs
cargo install bottom # replace top, command: btm
cargo install zoxide # replace cd, command: z
cargo install bat #replace cat, command: bat
cargo install hyperfine #replace time, command: hyperfine
```
add the following content .bashrc or .zshrc
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
我这里是单独分开来设置的,因此对celab106_z2mini和root用户都进行了配置。

# 19,install go，goneovim
## install go language
```
sudo yum install -y golang
# Set $GOPATH
mkdir -p ~/.local/.go/{bin,pkg,src}
echo 'export GOPATH="$HOME/.local/.go"' >> ~/.bashrc
echo 'export PATH="$PATH:${GOPATH//://bin:}/bin"' >> ~/.bashrc
source ~/.bashrc
```
## replace the morror source of go:
add the following content to .bashrc or .zshrc
```
export GO111MODULE=on
# Set the GOPROXY environment variable
export GOPROXY=https://goproxy.io,direct
# Set environment variable allow bypassing the proxy for specified repos (optional)
# export GOPRIVATE=git.mycompany.com,github.com/my/private
```
## install goneovim
go here (goneovim)[https://github.com/akiyosi/goneovim/releases] to downloads the package that had been compiled 
to ~/Downloads/program
```
cd ~/.config
mkdir goneovim
gvim settings.toml
```
then
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
## install configuration files
go to [configuration_files](https://github.com/0BananaBig0/configuration_file) to downloads settings.toml and move them to 
~/.config/goneovim

# 20,install and configure vncserver and cockpit
## install vncserver
```
ssh -X root@10.34.24.11
yum install tigervnc-server
gvim /etc/systemd/system/vncserver@:3.service # for port 3
gvim /etc/systemd/system/vncserver@:3.timer # for port 3
```
add the following content for user hxliang to vncserver@:3.service
```
# The vncserver service unit file
#
# Quick HowTo:
# 1. Copy this file to /etc/systemd/system/vncserver@.service
# 2. Replace <USER> with the actual user name and edit vncserver
#    parameters appropriately
#   ("User=<USER>" and "/home/<USER>/.vnc/%H%i.pid")
# 3. Run `systemctl daemon-reload`
# 4. Run `systemctl enable vncserver@:<display>.service`
#
# DO NOT RUN THIS SERVICE if your local area network is
# untrusted!  For a secure way of using VNC, you should
# limit connections to the local host and then tunnel from
# the machine you want to view VNC on (host A) to the machine
# whose VNC output you want to view (host B)
#
# [user@hostA ~]$ ssh -v -C -L 590N:localhost:590M hostB
#
# this will open a connection on port 590N of your hostA to hostB's port 590M
# (in fact, it ssh-connects to hostB and then connects to localhost (on hostB).
# See the ssh man page for details on port forwarding)
#
# You can then point a VNC client on hostA at vncdisplay N of localhost and with
# the help of ssh, you end up seeing what hostB makes available on port 590M
#
# Use "-nolisten tcp" to prevent X connections to your VNC server via TCP.
#
# Use "-localhost" to prevent remote VNC clients connecting except when
# doing so through a secure tunnel.  See the "-via" option in the
# `man vncviewer' manual page.


[Unit]
Description=Remote desktop service (VNC)
After=syslog.target network.target systemd-user-sessions.service

[Service]
Type=forking
User=hxliang

# Clean any existing files in /tmp/.X11-unix environment
ExecStartPre=-/usr/bin/vncserver -kill %i
ExecStart=/usr/bin/vncserver -geometry 1920x1080 %i
PIDFile=/home/hxliang/.vnc/%H%i.pid
ExecStop=-/usr/bin/vncserver -kill %i

[Install]
WantedBy=multi-user.target
```
add the following content for user hxliang to vncserver@:3.time
```
[Timer]
OnBootSec=30sec
```
execute the following commands
```
ls -al #make sure the owner of vncserver@3.service is root otherwise,use chown root:root vncserver@3.service to change it
systemctl daemon-reload
systemctl start vncserver@:3.service
systemctl enable vncserver@:3.service
```
if our server starts the vnc failed, maybe you should execute the following commands for hxliang
```
sudo usermod -a -G video hxliang
```
## 如果用户无法登录vnc，开启防火墙端口
```
ps -ef | grep vnc #查看需要开启那个端口
firewall-cmd --zone=public --add-port=5900-5920/tcp --permanent #通过ssh链接vnc则不需要开启防火墙端口
firewall-cmd --reload
exit
```
## 对于普通用户，先使用ssh登录自己的账户，再执行以下命令
```
mkdir .vnc
cp /home/lylai/.vnc/xstartup ~/.vnc
```
## 关闭vnc的屏保
查看vnc使用什么屏保程序
```
ps aux | grep screen
```
如果有则搜索linux如何关闭xxx的屏保，例如xscreensaver，没有则无需管理。
## 解决centos下非root用户频繁出现Authentication is required to set
  非root用户登陆linux服务器，总是弹出一个对话框，而且关闭之后，过一段时间还会弹出来。对话框的内容是：Authentication is required to set the network proxy used for downloading packages。然后提示你输入root密码。 \
  解决办法：在终端窗口（右键，open in terminal）输入“gnome-session-properties”。然后把“PackageKit Update Applet”前面的勾去掉就行了或者换成xfce
## 解决没有root权限的普通用户使用vnc提示:
XFCE PolicyKit Agent \
GDBus.Error:org.freedesktop.PolickKit1.Error.Failed:An authentication agent already exists for the given subject.
```
open Setting > Session and Startup > Application Autostart
Remove the check mark(√) of XFCE PolKit(Policykit Authentication Agent)[In other systems, it may be called PolicyKit Authentication Agent(Policykit Authentication Agent)]
```
## install cockpit
not do now
```
sudo yum install cockpit
sudo systemctl enable --now cockpit.socket
sudo systemctl start --now cockpit.socket
sudo firewall-cmd --permanent --zone=public --add-service=cockpit
sudo firewall-cmd --reload
```


# 21,编译minisat缺少静态库，提示:
/usr/bin/ld: cannot find -lz \
/usr/bin/ld: cannot find -lstdc++ \
/usr/bin/ld: cannot find -lm \
/usr/bin/ld: cannot find -lc \
```
sudo yum install -y glibc-static libstdc++-static zlib-static
```

# 22,64位系统执行32位程序报错:缺少相关32位程序的库
/cadtools/Mentor/QuestaSim/2020.3/bin/vsim: line 182: /cadtools/Mentor/QuestaSim/2020.3/bin/../linux/vsim: No such file or directory
```
sudo yum install -y glibc.i686 libstdc++-devel.i686 libX*.i686 glibc-devel*.i686 redhat-lsb-core.i686
```

# 23,安装7z解压软件
```
sudo yum -y install p7zip.x86_64 p7zip-plugins.x86_64
```

# 24,安装sublime text最新版
```
sudo rpm -v --import https://download.sublimetext.com/sublimehq-rpm-pub.gpg
sudo wget -P /etc/yum.repos.d/ https://download.sublimetext.com/rpm/stable/x86_64/sublime-text.repo
sudo yum install -y sublime-text
```

# 25,解决hds和vsim字体缺失问题
```
sudo yum install xorg*fonts* -y
```

# 26,安装cudnn和tensorrt
## install cudnn
```
cd ~/Downloads/program/
x cudnn-11.4-linux-x64-v8.2.4.15.tgz
cd cuda
sudo cp include/cudnn*.h /usr/local/cuda/include 
sudo cp -P lib64/libcudnn* /usr/local/cuda/lib64 
sudo chmod a+r /usr/local/cuda/include/cudnn*.h /usr/local/cuda/lib64/libcudnn*
```
## install tensorrt
```
cd ~/Downloads/program/
sudo rpm -Uvh nv-tensorrt-repo-rhel7-cuda11.4-trt8.2.3.0-ga-20220113-1-1.x86_64.rpm
sudo yum clean expire-cache
sudo yum makecache
sudo yum -y install tensorrt
sudo yum -y install python3-libnvinfer-devel
sudo yum -y install uff-converter-tf
sudo yum -y install onnx-graphsurgeon
sudo su
python3 -m pip install protobuf numpy
python3 -m pip install numpy onnx
exit
rpm -qa | grep tensorrt
```

# 27,安装opencl和clinfo，这个和cuda提供的有点不同
## 安装opencl
```
sudo yum install opencl-headers.noarch
yum provides '*/libOpenCL.so'
sudo yum install ocl-icd-devel -y
sudo yum install ocl-icd.x86_64 -y
```
## 安装clinfo
```
sudo yum install -y clinfo
```

# 28,安装opencv4
```
cd ~/Downloads/program
mkdir opencv4
cd opencv4
source /opt/rh/rh-git227/enable
source /opt/rh/devtoolset-9/enable
git clone https://github.com/opencv/opencv
git clone https://github.com/opencv/opencv_contrib
sudo yum install -y libva-freeworld libva-intel-driver vlc ffmpeg ffmpeg-devel
sudo yum -y install libdc1394-devel mercurial \
 zlib-devel freetype-devel hdf5-devel liblas-devel atlas-devel gcc-gfortran \
 libevent-devel openssl-devel flex flex-devel mysql-devel xz gettext-devel tcl \
 tesseract tesseract-devel tesseract-osd ccache pylint \
 python-flake8 vtk-devel vtk-python vtk-qt vtk gflags gflags-devel \
 glog glog-devel libXaw-devel freeimage freeimage-devel zziplib-devel \
 cppunit-devel libXt-devel libX11-devel re2c libgnomeui-devel gimp gimp-devel \
 gimp-devel-tools libraw1394-devel libjpeg-devel jasper-devel jasper-utils \
 swig nasm libdc1394 libv4l jasper libgphoto2 \
 libavc1394-devel gtk+-devel yasm libpciaccess phonon-backend-gstreamer 
sudo yum -y install epel-release qt5-qtbase-devel \
 python3-devel python3-numpy \
 gtk2 gtk2-devel libpng libpng-devel openexr-devel libwebp-devel \
 libjpeg-turbo-devel libtiff-devel tbb-devel libv4l-devel \
 freeglut-devel mesa-libGL mesa-libGL-devel \
 boost boost-thread boost-devel gstreamer* gstreamer-plugins-base-devel \
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

# 29,markdown(缩写为md)文件转docx或pdf工具
```
sudo yum install pandoc texlive-xetex texlive-luatex pandoc-citeproc texlive-pstricks -y
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

# 30,coc.nvim找不到头文件的解决办法：
## 对于cmake和catkin:
(1)把set(CMAKE_EXPORT_COMPILE_COMMANDS 1)添加到在CMakeList.txt的project语句下面然后编译,再把生成的compile_commands.json复制到工程目录；\
(2)把build的compile_commands.json复制到工程目录；\
(3)自己写compile_commands.json \
(4)catkin_make -DCMAKE_EXPORT_COMPILE_COMMANDS=YES \
(5)建立compile_commands.json硬链接/ 软连接 \
(6)写compile_flags.txt \
## 对于make:
有三种工具可以辅助基于GNUmake的构建系统生成Clang的JSON编译数据库文件的工具。\
分别为compiledb，YCM-Generator和Bear。本系统主要使用的bear。\
最新版本的 Bear 要求 C++17，而且还有类似 gRPC 的依赖，装起来太麻烦了，所以这里选择了老一点的 2.4.4 编译安装。
### Installation
```
sudo python3 -m pip install lit # Bear 依赖
git clone https://github.com/rizsotto/Bear.git
cd Bear
git checkout 2.4.4
mkdir build
cd build
cmake ..
make all
#make check
sudo make install
```

# 31,安装bazel和svlangserver和verible
## Install bazel
```
wget https://copr.fedorainfracloud.org/coprs/vbatts/bazel/repo/epel-7/vbatts-bazel-epel-7.repo
sudo chown root:root vbatts-bazel-epel-7.repo
yum list installed | grep -i openjdk-devel
yum list installed | grep -i openjdk-headless
sudo yum remove java-1.7.0-openjdk-devel java-1.7.0-openjdk-headless
sudo mv vbatts-bazel-epel-7.repo /etc/yum.repos.d
sudo yum install bazel4 -y
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
source /opt/rh/devtoolset-9/enable
bazel build -c opt //...
bazel test -c opt //...
bazel run -c opt :install -- -s /usr/local/bin
```

# 32,编译安装verilator
```
source /opt/rh/devtoolset-9/enable
cd ~/Downloads/program
sudo yum -y install git perl python3 make ccache numactl autoconf flex flex-devel bison bison-devel
git clone https://github.com/verilator/verilator.git
cd verilator
unset VERILATOR_ROOT
git checkout stable
autoconf
./configure
make -j16
make test
sudo make install
```
## 解决verilog找不到模块问题,coc.nvim使用iverilog,verilator
使用语法
```
`include "xxx.v"
```
包含模块所在v文件

# 33,更改权限，方便用户进来复制文件
```
cd ~
chmod 755 .vimrc .zshrc .vimrc_no_the_third_plugged
chmod 755 .config/nvim -R
chmod 755 .vim -R
chmod 755 Documents/configuration_file -R
chmod 755 Downloads/program/Goneovim-v0.5.1-linux -R
chmod 755 .vnc -R
cd ..
chmod 755 celab106_z2mini
cd ~
```

# 34,安装virtual box6.1
去[virtual_box 官网](https://www.virtualbox.org/wiki/Linux_Downloads)下载virtual box的rpm文件然后
```
cd ~/Downloads/program
sudo rpm -i VirtualBox-6.1-6.1.32_149290_el7-1.x86_64.rpm
```

# 35,解决nfs挂载硬盘普通用户没有访问权限问题
(1)查看可以访问nfs挂载的硬盘的用户组的gid \
(2)使用sudo groupadd -g gid group_name创建一个gid存在于所查结果的用户组(如果已存在，步骤2变为查询gid对应的group_name) \
(3)使用命令sudo gpasswd -a user group_name将user用户加入到group_name用户组中 \
(4)重启(也可以使用newgrp group_name更新用户组,但是打开新终端可能会失效)

# 36,安装lace的依赖
[lace](https://github.com/utwente-fmt/lace.git)
```
sudo yum -y install hwloc hwloc-libs hwloc-devel hwloc-gui hwloc-plugins
```

# 37,安装intel核显驱动相关文件
```
sudo yum install -y xorg-x11-drv-intel xorg-x11-drv-intel-devel
```

# 38,配置免密登录
注：celab106_z2min配置免密登录失败，应该是因为家目录位置更改到/home-local的原因
客户端
```
ssh-keygen -t rsa -b 4096 -C "1184903633@qq.com" #全部回车默认即可
```
服务端
```
#把客户端的~/.ssh/id_rsa.pub的文件复制到服务端你想登录的用户的~/.ssh/authorized_keys里面，如果没有则创建
chmod 700 ~/.ssh
chmod 600 ~/.ssh/authorized_keys
```
服务端
```
sudo su
cd /etc/ssh
cp sshd_config sshd_config.backup
vim sshd_config
```
把#PubkeyAuthentication yes的注释取消 \
把AuthorizedKeysFile .ssh/authorized_keys改为AuthorizedKeysFile %h/.ssh/authorized_keys \
使用systemctl restart sshd.service重启ssh服务

# 39,安装vscode
```
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
sudo yum update
sudo yum -y install code
sudo vim /etc/yum.repos.d/vscode.repo #change "enable=1" to "enable=0"
```

# 40,为ldap用户在特定ip的服务器更换shell，以hxliang用户和10.34.24.11为例
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
1000004 is my uid. 1000001 is my gid

# 41,安装批量文件编码转换工具，以及解决windows文件名在linux显示乱码的工具
```
sudo yum -y install enca convmv
```
Note:不要在NTFS和FAT文件 系统中使用convmv，否则可能产生意外结果，如果要在Linux 中正确的显示NTFS和 FAT的中文件名，可以通过mount参数来解决，具体方法查看一下man手册。 

# 42,更换python的方法
```
sudo update-alternatives --install /usr/bin/python python /usr/bin/python2 100
sudo update-alternatives --install /usr/bin/python python /usr/bin/python3 150
sudo update-alternatives --config python #选择python2
```

# 43,add shell environment variables
PATH: bin
LD_LIBRARY_PATH: lib or lib64
XDG_DATA_DIRS: share
C_INCLUDE_PATH: include
CPLUS_INCLUDE_PATH: include

# compile duf to replace df
```
git clone https://github.com/muesli/duf.git
cd duf
go build
go install
```

# 44,configure multiple ssh keys
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

# 45 服务器开启后再接入显示器无信号需要重启的解决方法：
xset s 0
xset -dpms
然后再在图形界面里面的休眠和待机取消。关闭屏幕可以选合适的时间。
建议全部取消。
设计失误，故意的，还是本身就是为服务器设计的，都没考虑过休眠问题。
反正很多发行版不用xset改，都会睡死。

# 46 服务器的Vivado无法识别fpga板子的解决方法：
(There is no active target available for server at localhost.) \
安装JTAG驱动。
```
cd /cadtools/Xilinx/2022.1/Vivado/2022.1/data/xicom/cable_drivers/lin64/install_script/install_drivers
sudo ./install_drivers 
```
安装完成后需要重新插拔JTAG。

# 47 close pulseaudio
Our servers have no such module.
```
sudo vim /etc/pulse/client.conf
```
Add the following content to the client.conf
```
autospawn = no
```
Reboot our servers \
If we want to use it, execute the following command
```
systemctl --user start pulseaudio.socket
systemctl --user start pulseaudio.service
```

# 48 configure perl LSP
```
sudo yum install libdb4-cxx.x86_64 cpan rh-perl530*
sudo su
cpan YAML #sudo
cpan Perl::LanguageServer #sudo
cpan install CPAN
cpan App::cpanminus
cpan Spreadsheet::ParseExcel Spreadsheet::WriteExcel #for xls
cpan Excel::Writer::XLSX Spreadsheet::ParseXLSX #for xlsx
cpanm --uninstall Spreadsheet::Read Spreadsheet::Write Spreadsheet::XLSX
exit
```
```
#add the following content to your .bashrc or .zshrc
if [ -f "/opt/rh/rh-perl530/enable" ]; then
  source /opt/rh/rh-perl530/enable #or scl enable rh-perl530 bash #only for .bashrc 
fi
```
系统永久更换perl版本
```
sudo su
vim /etc/bashrc /etc/zshrc
```
在这三个文件添加如下内容
```
if [ -f "/opt/rh/rh-perl530/enable" ]; then
  source /opt/rh/rh-perl530/enable #or scl enable rh-perl530 bash #only for .bashrc 
fi
```

# 49 install a json formatter
```
sudo npm install -g js-beautify
```

# 50 use neovim as a backend of vscode
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

# 51 latexmk
```
sudo yum install latexmk
```
