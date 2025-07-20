sudo dnf install -y git zsh wget util-linux-user
sudo dnf update -y
sudo dnf autoremove -y
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
mkdir ~/.config/nvim -p
# sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
#        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
echo 'E:\\Users\11849\Downloads\wsl_shared_folder /home/banana/wsl_shared_folder drvfs defaults,uid=1000,gid=1000,metadata 0 0' | sudo tee -a /etc/fstab > /dev/null
mkdir -p ~/wsl_shared_folder
rm install.sh

ln -s ~/wsl_shared_folder/cpp_workspace ~
ln -s ~/wsl_shared_folder/from_gcc_to_cpp ~
ln -s ~/wsl_shared_folder/ubuntu18_zsh_configure ~
ln -s ~/wsl_shared_folder/configuration_file ~
ln -s ~/wsl_shared_folder/oasys_rtl_qs_ekit ~
ln -s ~/wsl_shared_folder/PDK/NangateOpenCellLibrary_45nm ~
ln -s ~/wsl_shared_folder/PDK/tsmc28_pdk ~
sudo ln /mnt/c/Program\ Files/Mozilla\ Firefox/firefox.exe /usr/bin/firefox -s

cp /home/banana/configuration_file/.gdbinit ~
cp /home/banana/configuration_file/coc-settings.json ~/.vim
cp /home/banana/configuration_file/.vimrc ~
cp /home/banana/configuration_file/.c_cpp ~/.vim -r
cp /home/banana/configuration_file/.zshrc ~
cp /home/banana/configuration_file/ys_modified.zsh-theme ~/.oh-my-zsh/custom
cp /home/banana/configuration_file/init.vim ~/.config/nvim
cp /home/banana/configuration_file/.tessent_startup ~
cp /home/banana/configuration_file/.perltidyrc ~

sudo dnf group install -y "Development Tools"  # 注意首字母大写和空格
sudo dnf install -y make cmake valgrind gcc gcc-c++ llvm clang clang-tools-extra
curl -fsSL https://rpm.nodesource.com/setup_18.x | sudo bash -
sudo dnf install epel-release -y
sudo dnf clean all
sudo dnf update -y
sudo dnf install -y nodejs git sqlite
sudo dnf install -y python3 python3-pip perl flex java python3-setuptools
sudo dnf install -y p7zip p7zip-plugins
sudo dnf install -y ShellCheck cargo gem ruby-devel
sudo dnf install -y boost-devel tcl-devel xauth
sudo dnf install -y fd-find zoxide ripgrep bat hyperfine httpie procs
sudo dnf install -y libX11-devel libXext-devel libXrandr-devel libXcursor-devel
sudo dnf install -y libXinerama-devel libXi-devel libXtst-devel libxkbcommon-devel libxkbcommon-x11
sudo dnf install -y libxcb-devel
sudo dnf install -y gstreamer1-plugins-base-devel gstreamer1-devel xcb-util-wm xcb-util-keysyms
sudo dnf install -y zlib-devel libpng-devel libjpeg-devel libsecret-devel
sudo dnf install -y wayland-devel libxkbcommon-devel openssl-devel mesa-libGL-devel
sudo dnf install -y kernel-headers kernel-devel
sudo dnf install -y kmodtool akmods mokutil openssl dkms
sudo dnf install -y redhat-lsb-core
sudo dnf install -y xorg*fonts*
sudo npm install -g yarn
# sudo dnf provides */xxx.so

cd ~/wsl_shared_folder/font
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/DejaVuSansMono.zip
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/FantasqueSansMono.zip
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/UbuntuMono.zip
x DejaVuSansMono.zip FantasqueSansMono.zip UbuntuMono.zip
sudo cp DejaVuSansMono/ FantasqueSansMono UbuntuMono /usr/share/fonts -r
cd /usr/share/fonts
sudo chown root:root DejaVuSansMono FantasqueSansMono UbuntuMono -R
sudo chmod 755 DejaVuSansMono FantasqueSansMono UbuntuMono -R
sudo cp ~/configuration_file/local.conf /etc/fonts/ # or modify 40-nonlatin.conf, but difficult
sudo mkdir /usr/share/fonts/win11 # to differentiate self-built font links from system font files
sudo ln -s /mnt/c/Windows/Fonts/* /usr/share/fonts/win11
sudo fc-cache -fv


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

npm config set coc.nvim:registry https://registry.npmmirror.com
npm config set registry https://registry.npmmirror.com/ && \
npm cache clean --force
sudo npm config set coc.nvim:registry https://registry.npmmirror.com
sudo npm config set registry https://registry.npmmirror.com/ && \
sudo npm cache clean --force
sudo npm install -g @imc-trading/svlangserver

sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
sudo dnf update
sudo dnf install -y code

mkdir ~/.config/pip -p
echo '[global]' > ~/.config/pip/pip.conf
echo 'index-url = https://mirrors.tuna.tsinghua.edu.cn/pypi/web/simple' >> ~/.config/pip/pip.conf
python3 -m pip install --upgrade pip --user
python3 -m pip install scons pylint cmakelang cmake-language-server pyright --user
python3 -m pip install cppman you-get sphinx sphinx-rtd-theme vim-vint black --user
python3 -m pip install pysnooper futures --user

sudo dnf config-manager --set-enabled powertools
sudo dnf install -y ocl-icd-devel ocl-icd opencl-headers clinfo
sudo dnf install -y perl-AnyEvent perl-Data-Dump perl-JSON perl-Moose perl-PadWalker perl-Scalar-List-Utils
sudo dnf install -y perl-App-cpanminus perl-Coro perl-AnyEvent perl-YAML perl-Data-Dump
sudo dnf install -y perl-IO-AIO perl-JSON perl-PadWalker perl-Scalar-List-Utils perl-CPAN-DistnameInfo
sudo dnf install -y perl-CPAN perl-Spreadsheet-ParseExcel perl-Spreadsheet-WriteExcel perl-Spreadsheet-XLSX
sudo dnf install -y perl-LWP-Protocol-https perl-Path-Tiny perl-Module-Build perl-Module-Build-XSUtil
sudo dnf install -y perl-Module-Build-Tiny perl-ExtUtils-Config perl-ExtUtils-Install perl-ExtUtils-Helpers
sudo dnf install -y perl-Devel-CheckCompiler perl-Test-Requires perl-Cwd-Guard perl-Capture-Tiny
sudo dnf install -y perl-File-Copy-Recursive-Reduced perl-Future perl-Term-Table perl-Test-Simple
sudo dnf install -y perl-Devel-Symdump perl-Class-Inspector perl-Class-Unload
sudo dnf install -y perl-Pod-Coverage perl-Test-Pod-Coverage perl-Test-Pod perl-Class-Accessor
cpanm --local-lib=~/.local/perl5 Perl::LanguageServer Hash::SafeKeys Compiler::Lexer
cargo install du-dust@1.1.2
cargo install bottom@0.8.0 cargo-cache@0.8.3 eza@0.20.24 asm-lsp@0.9.0 --locked

# install verible:
cd ~/wsl_shared_folder/rocky_pack
wget https://github.com/chipsalliance/verible/releases/download/v0.0-3992-g1903b809/verible-v0.0-3992-g1903b809-linux-static-x86_64.tar.gz
x verible-v0.0-3992-g1903b809-linux-static-x86_64.tar.gz
sudo cp verible-v0.0-3992-g1903b809/bin/* /usr/local/bin

# compile vim(option):
cd ~/wsl_shared_folder/rocky_pack/
git clone https://github.com/vim/vim.git
cd vim
sudo dnf install -y luajit-devel luajit libXdmcp-devel mesa-dri-drivers
sudo dnf install -y gpm-devel libXft-devel gtk3-devel libX11-devel gettext python3-devel
sudo dnf install -y libXt-devel ruby-devel ncurses-devel gettext-devel lua-devel
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
  --with-python3-config-dir=/usr/lib64/python3.6/config-3.6m-x86_64-linux-gnu \
  --with-python3-command=/usr/bin/python3 \
  --enable-gpm \
  --with-luajit
make -j24
sudo make install
sudo ln -s /usr/local/bin/vim /usr/bin/vim
sudo ln -s /usr/local/bin/gvim /usr/bin/gvim

# compile iveriolog:
cd ~/wsl_shared_folder/rocky_pack/
git clone https://github.com/steveicarus/iverilog.git
sudo dnf install -y autoconf gperf
cd iverilog
sh autoconf.sh
./configure
make -j24
sudo make install

# compile duf to replace df
cd ~/wsl_shared_folder/rocky_pack/
git clone https://github.com/muesli/duf.git
sudo dnf install -y go # Should open a new terminal
cd duf
go build
go install

# compile verilator:
cd ~/wsl_shared_folder/rocky_pack/
git clone https://github.com/verilator/verilator.git
sudo dnf install -y ccache numactl autoconf flex flex-devel bison bison-devel help2man
python3 -m pip install distro  # 针对 Python3
cd verilator
git reset --hard v5.026
unset VERILATOR_ROOT
make distclean
autoconf
./configure
make -j24
make test
sudo make install

# compile Bear:
cd ~/wsl_shared_folder/rocky_pack/
git clone https://github.com/rizsotto/Bear.git
sudo dnf install -y cmake pkg-config json-devel
sudo dnf install -y json-devel spdlog-devel fmt-devel
sudo dnf install -y gtest-devel gmock-devel # optional for running the tests
sudo dnf install -y protobuf-devel fmt-devel spdlog-devel
cd Bear
git reset --hard 2.3.13
mkdir build
cd build
cmake ..
make -j24
sudo make install
sudo ln -s /usr/bin/python3 /usr/bin/python

# compile neovim
cd ~/wsl_shared_folder/rocky_pack/
git clone https://github.com/neovim/neovim
sudo dnf install -y ninja-build libtool autoconf automake pkgconfig unzip patch gettext
sudo dnf install -y curl xclip python3.11 python3.11-pip
python3.11 -m pip install --upgrade pip --user
python3.11 -m pip install neovim --user
cd neovim
git checkout stable
make CMAKE_BUILD_TYPE=Release #repeat until success
sudo make install
sudo npm install -g neovim
gem sources -r https://rubygems.org/ -a https://gems.ruby-china.com/
gem install neovim --bindir=$HOME/.local/bin

# for a special tool
sudo dnf install -y ksh ncurses-devel libXdmcp-devel ncurses-compat-libs
sudo dnf install -y libasan libubsan csh libXScrnSaver-devel
sudo dnf install -y qt5-qtbase-devel libgfortran libpng12
sudo dnf install -y libxslt-devel pulseaudio-libs-glib2
python3.11 -m pip install tclint --user

# vimspector(gadgets, debugpy)
python3.5 debugpy1.5.1: 9575ac1565a0bc03fdb41be3dab3b89754437ac6
python3.6 debugpy1.6.7: be68c930568a189ca156f8d170383fe2febbe470
python3.7 debugpy1.7.0: 8fecfde4379af186574286c6cc38cb77f0ef584e
python3.8 debugpy1.8.11: The latest
git clone --recurse-submodules https://github.com/microsoft/debugpy.git
cd debugpy
sudo dnf install python3.11-devel
python3.11 -m pip install wheel setuptools --user
python3.11 setup.py build_ext --inplace
python3.11 -m pip install -e .
sudo dnf install python38-devel python38
python3.8 -m pip install wheel setuptools --user
python3.8 setup.py build_ext --inplace
python3.8 -m pip install -e .

###### ONLY FOR ME
sudo dnf install glibc -y
 sudo dnf install -y zlib-devel bzip2-devel openssl-devel ncurses-devel \
libffi-devel readline-devel sqlite-devel tk-devel gdbm-devel xz-devel

tar -zxvf openssl-1.1.1w.tar.gz
cd openssl-1.1.1w
./config --prefix=/usr/local/openssl --openssldir=/usr/local/openssl shared zlib
make && sudo make install
sudo mv /usr/bin/openssl /usr/bin/openssl.bak
sudo mv /usr/include/openssl /usr/include/openssl.bak
sudo ln -s /usr/local/openssl/bin/openssl /usr/bin/openssl
sudo ln -s /usr/local/openssl/include/openssl /usr/include/openssl
echo "/usr/local/openssl/lib" | sudo tee /etc/ld.so.conf.d/openssl.conf
sudo ldconfig -v

wget https://www.python.org/ftp/python/3.7.3/Python-3.7.3.tgz
x Python-3.7.3.tgz
cd Python-3.7.3
./configure \
  --prefix=/mtkoss/Python3/3.7.3-rhel8/x86_64 \
  --enable-optimizations \
  --enable-shared \
  --with-system-ffi \
  --with-ensurepip=install \
  --disable-ipv6 \
  CC=gcc \
  LDFLAGS="-Wl,-rpath=/usr/lib64 -Wl,-rpath=/mtkoss/Python3/3.7.3-rhel8/x86_64/lib"
make -j$(nproc)
sudo make install

cd vim_mtk
make distclean
export PYTHON377_HOME=/mtkoss/Python3/3.7.3-rhel8/x86_64
./configure \
  --prefix=/usr/local \
  --with-features=huge \
  --enable-multibyte \
  --enable-python3interp=dynamic \
  --with-python3-command=$PYTHON377_HOME/bin/python3.7 \
  --with-python3-config-dir=$PYTHON377_HOME/lib/python3.7/config-3.7m-x86_64-linux-gnu \
  --enable-rubyinterp=yes \
  --enable-luainterp=yes \
  --enable-gui=gtk3 \
  --enable-cscope \
  --enable-fontset \
  --enable-tclinterp=yes \
  --enable-perlinterp=yes \
  --enable-gpm \
  --with-luajit \
  LDFLAGS="-L$PYTHON377_HOME/lib -Wl,-rpath=$PYTHON377_HOME/lib" \
  CPPFLAGS="-I$PYTHON377_HOME/include/python3.7m"
export PATH="$PYTHON377_HOME/bin:$PATH"
export LD_LIBRARY_PATH="$PYTHON377_HOME/lib:$LD_LIBRARY_PATH"
make -j24
sudo make install
LD_LIBRARY_PATH="$PYTHON377_HOME/lib" vim --version | grep python
###### ONLY FOR ME
