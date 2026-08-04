sudo dnf install -y git zsh wget util-linux-user
sudo dnf update -y
sudo dnf autoremove -y
git config --global user.name "Huaxiao Liang"
git config --global user.email "1184903633@qq.com"
git config --global alias.logline "log --graph --abbrev-commit"
git config --global core.editor gvim
git config --global protocol.https.allow always
git config --global push.default "current"
git config --global url."https://githubfast.com/".insteadOf "https://github.com/"
wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh
sh install.sh
bash -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
mkdir -p ~/wsl_shared_folder
rm install.sh

git clone git@gitee.com:banana33/configuration_file.git
cp ~/configuration_file/.gdbinit ~
cp ~/configuration_file/coc-settings.json ~/.vim
cp ~/configuration_file/.vimrc ~
cp ~/configuration_file/.c_cpp ~/.vim -r
cp ~/configuration_file/.zshrc ~
cp ~/configuration_file/ys_modified.zsh-theme ~/.oh-my-zsh/custom
cp ~/configuration_file/.tessent_startup ~
cp ~/configuration_file/.perltidyrc ~

sudo dnf install -y curl
sudo dnf group install -y "Development Tools"  # 注意首字母大写和空格
sudo dnf install -y make cmake valgrind gcc gcc-c++ llvm clang clang-tools-extra
sudo dnf install epel-release -y
sudo dnf clean all
sudo dnf install -y git sqlite
sudo dnf install -y python3 python3-pip perl flex java python3-setuptools
sudo dnf install -y p7zip p7zip-plugins
sudo dnf install -y ShellCheck cargo ruby-devel
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
sudo dnf install -y xorg-x11-fonts-misc libyaml-devel
sudo dnf install konsole -y
sudo dnf install -y python3.12 python3.12-pip perl flex python3.12-setuptools

mkdir ~/font -p
cd ~/font
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/DejaVuSansMono.zip
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/FantasqueSansMono.zip
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/UbuntuMono.zip
unzip DejaVuSansMono.zip
unzip FantasqueSansMono.zip
unzip UbuntuMono.zip
sudo cp DejaVuSansMono/ FantasqueSansMono UbuntuMono /usr/share/fonts -r
cd /usr/share/fonts
sudo chown root:root DejaVuSansMono FantasqueSansMono UbuntuMono -R
sudo chmod 755 DejaVuSansMono FantasqueSansMono UbuntuMono -R
sudo cp ~/configuration_file/local.conf /etc/fonts/ # or modify 40-nonlatin.conf, but difficult
sudo mkdir /usr/share/fonts/win11 # to differentiate self-built font links from system font files
sudo ln -s /mnt/c/Windows/Fonts/* /usr/share/fonts/win11
sudo fc-cache -fv
cd ~
rm font -rf

sudo npm install yarn --prefix /data/bosios
sudo npm install @imc-trading/svlangserver --prefix /data/bosios
BOSIOS="${BOSIOS}"
for os_item in ${BOSIOS}/*/*; do
    OS_PATH="${BOSIOS}/${os_item}"
    [[ -d "${OS_PATH}/bin" && ":$PATH:" != *":${OS_PATH}/bin:"* ]] && export PATH="${OS_PATH}/bin:$PATH"
    [[ -d "${OS_PATH}/lib" && ":$LD_LIBRARY_PATH:" != *":${OS_PATH}/lib:"* ]] && export LD_LIBRARY_PATH="${OS_PATH}/lib:$LD_LIBRARY_PATH"
    [[ -d "${OS_PATH}/lib" && ":$LIBRARY_PATH:" != *":${OS_PATH}/lib:"* ]] && export LIBRARY_PATH="${OS_PATH}/lib:$LIBRARY_PATH"
    [[ -d "${OS_PATH}/share" && ":$XDG_DATA_DIRS:" != *":${OS_PATH}/share:"* ]] && export XDG_DATA_DIRS="${OS_PATH}/share:$XDG_DATA_DIRS"
done
yarn config set registry https://registry.npmmirror.com/ --global  && \
yarn config set sass_binary_site https://cdn.npmmirror.com/binaries/node-sass --global  && \
yarn config set electron_mirror https://registry.npmmirror.com/binary.html?path=electron/ --global  && \
yarn config set puppeteer_download_host https://registry.npmmirror.com/binary.html --global  && \
yarn config set chromedriver_cdnurl https://cdn.npmmirror.com/binaries/chromedriver --global  && \
yarn config set operadriver_cdnurl https://cdn.npmmirror.com/binaries/operadriver --global  && \
yarn config set phantomjs_cdnurl https://cdn.npmmirror.com/binaries/phantomjs --global  && \
yarn config set selenium_cdnurl https://cdn.npmmirror.com/binaries/selenium --global  && \
yarn config set node_inspector_cdnurl https://cdn.npmmirror.com/binaries/node-inspector --global

mkdir ~/.config/pip -p
echo '[global]' > ~/.config/pip/pip.conf
echo 'index-url = https://mirrors.tuna.tsinghua.edu.cn/pypi/web/simple' >> ~/.config/pip/pip.conf
sudo python3.12 -m pip install --upgrade pip --target=/data/bosios/python/site-packages
sudo python3.12 -m pip install scons pylint cmakelang cmake-language-server pyright \
                       cppman you-get sphinx sphinx-rtd-theme vim-vint black \
                       pysnooper futures tclint distro --target=/data/bosios/python/site-packages

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
sudo cpanm --local-lib=/data/bosios/perl5 Perl::LanguageServer Hash::SafeKeys Compiler::Lexer
sudo cargo install du-dust@1.1.2 bottom@0.8.0 cargo-cache@0.8.3 eza@0.20.24 asm-lsp@0.9.0 --locked --root /data/bosios/cargo

# install verible:
cd ~/rocky_pack
wget https://github.com/chipsalliance/verible/releases/download/v0.0-4080-ga0a8d8eb/verible-v0.0-4080-ga0a8d8eb-linux-static-x86_64.tar.gz
x verible-v0.0-4080-ga0a8d8eb-linux-static-x86_64.tar.gz
mkdir -p /data/bosios/verible/bin
sudo cp verible-v0.0-4080-ga0a8d8eb/bin/* /data/bosios/verible/bin

# compile vim(option):
cd ~/rocky_pack/
git clone https://github.com/vim/vim.git
cd vim
sudo dnf install -y luajit-devel luajit libXdmcp-devel mesa-dri-drivers
sudo dnf install -y gpm-devel libXft-devel gtk3-devel libX11-devel gettext python3-devel
sudo dnf install -y libXt-devel ruby-devel ncurses-devel gettext-devel lua-devel
./configure \
--prefix=/data/bosios/vim \
--with-features=huge  \
--enable-multibyte  \
--enable-rubyinterp=yes  \
--enable-luainterp=yes  \
--enable-gui=gtk3  \
--enable-cscope=yes \
--enable-fontset=yes  \
--enable-tclinterp=yes  \
--enable-perlinterp=yes  \
--with-luajit  \
--enable-python3interp=yes  \
--with-python3-config-dir=/usr/lib64/python3.12/config-3.12-x86_64-linux-gnu  \
--with-python3-command=/usr/bin/python3.12  \
--enable-gpm  \
--with-luajit \
--enable-terminal \
--enable-xim \
--enable-xsmp
make -j24
sudo make install

# compile iveriolog:
cd ~/rocky_pack/
git clone https://github.com/steveicarus/iverilog.git
sudo dnf install -y autoconf gperf
cd iverilog
sh autoconf.sh
./configure
make -j24
sudo make install

# compile duf to replace df
cd ~/rocky_pack/
git clone https://github.com/muesli/duf.git
sudo dnf install -y go # Should open a new terminal
cd duf
go build
GOBIN=/data/bosios/go/bin go install

# compile verilator:
cd ~/rocky_pack/
git clone https://github.com/verilator/verilator.git
sudo dnf install -y ccache numactl autoconf flex flex-devel bison bison-devel help2man
cd verilator
#git reset --hard v5.026
unset VERILATOR_ROOT
make distclean
autoconf
./configure \
--prefix=/data/bosios/verilator
make -j24
make test
sudo make install

# compile Bear:
cd ~/rocky_pack/
git clone https://github.com/rizsotto/Bear.git
sudo dnf install -y cmake pkg-config json-devel
sudo dnf install -y json-devel spdlog-devel fmt-devel
sudo dnf install -y gtest-devel gmock-devel # optional for running the tests
sudo dnf install -y protobuf-devel fmt-devel spdlog-devel
sudo dnf install -y lld binutils gcc-c++
cd Bear
mkdir build
cargo build --release
target/release/generate-completions target/release/completions
sudo PREFIX=/data/bosios/bear ./scripts/install.sh

sudo mkdir /data/bosios/nvm -p
sudo NVM_DIR=/data/bosios/nvm bash -c 'curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash'
sudo su
export NVM_DIR="/data/bosios/nvm" && \
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" && \
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" && \
nvm install 24.14.0
