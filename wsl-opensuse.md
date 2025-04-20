sudo zypper mr -da
sudo zypper ar -cfg 'https://mirrors.tuna.tsinghua.edu.cn/opensuse/tumbleweed/repo/oss/' mirror-oss
sudo zypper ar -cfg 'https://mirrors.tuna.tsinghua.edu.cn/opensuse/tumbleweed/repo/non-oss/' mirror-non-oss
sudo zypper ar -f https://packages.microsoft.com/yumrepos/vscode vscode
sudo zypper ref
ln -s /mnt/d/Users/11849/Documents
ln -s /mnt/d/Users/11849/Videos
ln -s /mnt/d/Users/11849/Downloads
ln -s /mnt/d/Users/11849/Desktop WDesktop
mkdir -p /home/banana/wsl_shared_folder # also create wsl_shared_folder in D:\Users\11849\Downloads\
echo 'D:\Users\11849\Downloads\wsl_shared_folder /home/banana/wsl_shared_folder drvfs defaults,uid=1000,gid=1000,metadata 0 0' | sudo tee -a /etc/fstab > /dev/null
echo '[boot]' | sudo tee -a /etc/wsl.conf > /dev/null
echo 'systemd = false' | sudo tee -a /etc/wsl.conf > /dev/null
echo '[automount]' | sudo tee -a /etc/wsl.conf > /dev/null
echo 'ldconfig = false' | sudo tee -a /etc/wsl.conf > /dev/null
echo 'enabled = true' | sudo tee -a /etc/wsl.conf > /dev/null
echo 'root = /mnt/' | sudo tee -a /etc/wsl.conf > /dev/null
echo 'options = "metadata"' | sudo tee -a /etc/wsl.conf > /dev/null
echo '[interop]' | sudo tee -a /etc/wsl.conf > /dev/null
echo 'enabled = true' | sudo tee -a /etc/wsl.conf > /dev/null
echo 'appendWindowsPath = true' | sudo tee -a /etc/wsl.conf > /dev/null
echo '[user]' | sudo tee -a /etc/wsl.conf > /dev/null
echo 'default=banana' | sudo tee -a /etc/wsl.conf > /dev/null
# reboot wsl2
sudo mkdir /usr/share/fonts/win11 # to differentiate self-built font links from system font files
sudo ln -s /mnt/c/Windows/Fonts/* /usr/share/fonts/win11
sudo ln /mnt/c/Program\ Files/Mozilla\ Firefox/firefox.exe /usr/bin/firefox -s
sudo zypper install -y zsh git curl wget 7zip xauth

# also for sudo su
git config --global user.name "Huaxiao Liang"
git config --global user.email "1184903633@qq.com"
git config --global alias.logline "log --graph --abbrev-commit"
git config --global core.editor gvim
git config --global protocol.https.allow always
git config --global push.default "current"
git config --global diff.tool gvimdiff
git config --global url."https://githubfast.com/".insteadOf "https://github.com/"
wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh
sh install.sh
bash -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"
cp /home/banana/Downloads/wsl_shared_folder/configuration_file/ys_modified.zsh-theme ~/.oh-my-zsh/custom
cp /home/banana/Downloads/wsl_shared_folder/configuration_file/.zshrc ~
cp /home/banana/Downloads/wsl_shared_folder/configuration_file/.gdbinit ~
chsh -s $(which zsh)
rm install.sh

sudo zypper install -y make valgrind gcc gcc-c++ gvim npm-default nodejs-default Bear gdb libstdc++6-pp
sudo zypper install -y vulkan-devel cmake ccache
sudo zypper install -y neovim xclip cargo python311-base python311-pip python311-pipx python311-neovim ruby-devel python311-devel python311-setuptools
sudo zypper install -y *clang*19* *llvm*19* lld-19 lldb-19 cdecl
sudo zypper install -y libc++-devel libc++abi-devel
sudo zypper install -y pandoc-cli texlive-xetex texlive-luatex texlive-pstricks
sudo zypper install -y opencl-headers ocl-icd-devel pocl pocl-devel clinfo libpocl-devices-tbb
sudo zypper install -y boost-devel tcl-devel tcllib libboost_date_time-devel libboost_filesystem-devel  libboost_iostreams-devel libboost_system-devel libboost_program_options-devel

# fix a bug that pocl does not detect opencl devices
export POCL_CPU_ENABLED=1
export POCL_DEBUG=1
clinfo

# sudo ln -s /usr/lib64/libtcl8.6.so /usr/lib/libtcl.so # delete it, use `pkg-config --cflags --libs tcl` to configure tcl
sudo zypper install -y perl libdb-4_8-devel flex duf
cargo install fd-find eza zoxide ripgrep bat hyperfine httpie
cargo install du-dust bottom procs cargo-cache
cargo install asm-lsp

cd ~
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/DejaVuSansMono.zip
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/FantasqueSansMono.zip
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/UbuntuMono.zip
x DejaVuSansMono.zip FantasqueSansMono.zip UbuntuMono.zip
sudo mv DejaVuSansMono/ FantasqueSansMono UbuntuMono /usr/share/fonts
rm *.zip
cd /usr/share/fonts
sudo chown root:root DejaVuSansMono FantasqueSansMono UbuntuMono -R
sudo chmod 755 DejaVuSansMono FantasqueSansMono UbuntuMono -R
sudo fc-cache -fv

# also for root
mkdir ~/.config/nvim -p
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
cp /home/banana/Downloads/wsl_shared_folder/configuration_file/.vimrc ~
cp /home/banana/Downloads/wsl_shared_folder/configuration_file/.c_cpp ~/.vim -r
cp /home/banana/Downloads/wsl_shared_folder/configuration_file/coc-settings.json ~/.vim
ln -s ~/.vimrc ~/.config/nvim/init.vim
ln -s ~/.vim/coc-settings.json ~/.config/nvim
pip3 config set global.index-url https://mirrors.tuna.tsinghua.edu.cn/pypi/web/simple

pipx install scons
pipx install ipdb
pipx install pylint
pipx install yapf
pipx install pygments
pipx install cmakelang
pipx install cmake-language-server
pipx install pyright
pipx install cppman
pipx install you-get
pipx install sphinx
pipx install sphinx-rtd-theme --include-deps
pipx install autopep8
pipx install vim-vint
pip3 install pysnooper futures neovim --break-system-packages #not do for root
gem install neovim --user-install
npm config set coc.nvim:registry https://registry.npmmirror.com
npm config set registry https://registry.npmmirror.com/ && \
npm cache clean --force
sudo npm config set coc.nvim:registry https://registry.npmmirror.com
sudo npm config set registry https://registry.npmmirror.com/ && \
sudo npm cache clean --force
sudo npm install -g neovim yarn

# also for root
yarn config set registry https://registry.npmmirror.com/ --global  && \
yarn config set sass_binary_site https://cdn.npmmirror.com/binaries/node-sass --global  && \
yarn config set electron_mirror https://registry.npmmirror.com/binary.html?path=electron/ --global  && \
yarn config set puppeteer_download_host https://registry.npmmirror.com/binary.html --global  && \
yarn config set chromedriver_cdnurl https://cdn.npmmirror.com/binaries/chromedriver --global  && \
yarn config set operadriver_cdnurl https://cdn.npmmirror.com/binaries/operadriver --global  && \
yarn config set phantomjs_cdnurl https://cdn.npmmirror.com/binaries/phantomjs --global  && \
yarn config set selenium_cdnurl https://cdn.npmmirror.com/binaries/selenium --global  && \
yarn config set node_inspector_cdnurl https://cdn.npmmirror.com/binaries/node-inspector --global

# if you can't open GUI, add "export DISPLAY=:0" to your .zshrc or .bashrc
sudo zypper install -y adwaita-icon-theme-legacy adwaita-icon-theme # also for qt icons
sudo zypper install -y dbus-1-x11 at-spi2-core
# Fix an error of ping
sudo zypper install -y libcap-progs
sudo setcap cap_net_raw+p /bin/ping


sudo zypper install -y libX11-devel libXext-devel libXrandr-devel libXcursor-devel libXinerama-devel libXi-devel libXtst-devel libxkbcommon-x11-devel libxcb-icccm4 libxcb-image0 libxcb-keysyms1 libxcb-render-util0 xcb-util-cursor-devel xcb-util-cursor-devel
sudo zypper install -y gstreamer-plugins-base-devel gstreamer-devel
sudo zypper install -y libz1 libpng16-16 libjpeg8 libsecret-devel
sudo zypper install -y wayland-devel libxkbcommon-devel libopenssl-devel Mesa-libGL-devel
cd ~/wsl_shared_folder
mkdir .Qt6_Online_Installer
cd .Qt6_Online_Installer
wget https://download.qt.io/official_releases/online_installers/qt-unified-linux-x64-online.run
chmod a+x qt-unified-linux-x64-online.run
./qt-unified-linux-x64-online.run
cd ~/wsl_shared_folder
wget https://ftp.gnu.org/gnu/bison/bison-3.3.tar.gz
x bison-3.3.tar.gz
sudo zypper install m4
cd bison-3.3
./configure
make
sudo make install
cd ~/wsl_shared_folder
rm bison-3.3.tar.gz
ln -s ~/wsl_shared_folder/cpp_workspace ~
ln -s ~/wsl_shared_folder/from_gcc_to_cpp ~
ln -s ~/wsl_shared_folder/ubuntu18_zsh_configure ~
ln -s ~/wsl_shared_folder/configuration_file ~

# fix an error that gvim cannot use menus
export XDG_DATA_DIRS=$XDG_DATA_DIRS:/usr/share

sudo zypper install -y perl-AnyEvent perl-Data-Dump perl-JSON perl-Moose perl-PadWalker perl-Scalar-List-Utils
sudo zypper install -y perl-App-cpanminus
cpanm --local-lib=~/.local/perl5 AnyEvent Class::Refresh Compiler::Lexer Data::Dump IO::AIO JSON Moose PadWalker Scalar::List::Utils Coro
cpanm --local-lib=~/.local/perl5 YAML CPAN::DistnameInfo Perl::LanguageServer CPAN Spreadsheet::ParseExcel Spreadsheet::WriteExcel Excel::Writer::XLSX
cpanm --local-lib=~/.local/perl5 Neovim::Ext Class::Refresh Compiler::Lexer Hash::SafeKeys Perl::LanguageServer
#cpanm --uninstall Spreadsheet::Read Spreadsheet::Write Spreadsheet::XLSX

# compile vim(option):
sudo zypper install gpm gpm-devel python311-devel lua51-devel luajit-devel libXft-devel motif-devel libX11-devel libXt-devel gtk3-devel ruby-devel ncurses-devel
./configure \
  --prefix=/usr/local \
  --with-features=huge \
  --enable-multibyte \
  --enable-rubyinterp=yes \
  --enable-luainterp=yes \
  --enable-gui=gtk3 \
  --enable-cscope \
  --enable-fontset \
  --enable-tclinterp \
  --enable-perlinterp \
  --with-luajit \
  --enable-python3interp=yes \
  --with-python3-config-dir=/usr/lib64/python3.13/config-3.13-x86_64-linux-gnu \
  --enable-gpm

sudo zypper install iotop

# for a special tool
sudo zypper install libncurses5 ksh unrar

sudo zypper install iverilog verilator bazel patch
sudo npm install -g @imc-trading/svlangserver
cd ~
git clone https://github.com/chipsalliance/verible
cd verible
bazel build -c opt //...
bazel test -c opt //... --test_verbose_timeout_warnings
bazel build -c opt :install-binaries
sudo .github/bin/simple-install.sh /usr/local/bin

sudo cp ~/configuration_file/local.conf /etc/fonts/

sudo zypper remove -y *clang*19* *llvm*19* lld-19 lldb-19
sudo zypper install -y *clang*20* *llvm*20* lld-20 lldb-20

# for a special tool
sudo zypper install libXdmcp-devel ShellCheck
pipx install tclint
sudo zypper remove -y python311-base python311-pip python311-pipx python311-neovim ruby-devel python311-devel python311-setuptools python311-devel
sudo zypper install -y python313-base python313-pip python313-pipx python313-neovim ruby-devel python313-devel python313-setuptools python313-devel

pipx install scons
pipx install ipdb
pipx install pylint
pipx install yapf
pipx install pygments
pipx install cmakelang
pipx install cmake-language-server
pipx install pyright
pipx install cppman
pipx install you-get
pipx install sphinx
pipx install sphinx-rtd-theme --include-deps
pipx install autopep8
pipx install vim-vint
pip3 install pysnooper futures neovim --break-system-packages #not do for root
pipx install tclint
