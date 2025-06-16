sudo dnf install epel-release -y
sudo dnf config-manager --set-enabled powertools
curl -fsSL https://rpm.nodesource.com/setup_18.x | sudo bash -
sudo dnf clean all
sudo dnf update -y
sudo dnf group install -y "Development Tools"  # 注意首字母大写和空格
sudo dnf install -y make cmake valgrind gcc gcc-c++ llvm clang clang-tools-extra
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
sudo npm install -g yarn
cd ~/wsl_shared_folder/font
sudo cp DejaVuSansMono/ FantasqueSansMono UbuntuMono /usr/share/fonts -r
cd /usr/share/fonts
sudo chown root:root DejaVuSansMono FantasqueSansMono UbuntuMono -R
sudo chmod 755 DejaVuSansMono FantasqueSansMono UbuntuMono -R
sudo cp ~/configuration_file/local.conf /etc/fonts/ # or modify 40-nonlatin.conf, but difficult
sudo mkdir /usr/share/fonts/win11 # to differentiate self-built font links from system font files
sudo ln -s /mnt/c/Windows/Fonts/* /usr/share/fonts/win11
sudo fc-cache -fv
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
sudo dnf update -y
sudo dnf install -y code
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
sudo dnf install -y luajit-devel luajit libXdmcp-devel mesa-dri-drivers
sudo dnf install -y gpm-devel libXft-devel gtk3-devel libX11-devel gettext python3-devel
sudo dnf install -y libXt-devel ruby-devel ncurses-devel gettext-devel lua-devel
sudo dnf install -y autoconf gperf
sudo dnf install -y go # Should open a new terminal
sudo dnf install -y ccache numactl autoconf flex flex-devel bison bison-devel help2man
sudo dnf install -y cmake pkg-config json-devel
sudo dnf install -y json-devel spdlog-devel fmt-devel
sudo dnf install -y gtest-devel gmock-devel # optional for running the tests
sudo dnf install -y protobuf-devel fmt-devel spdlog-devel
sudo dnf install -y ninja-build libtool autoconf automake pkgconfig unzip patch gettext
sudo dnf install -y curl xclip python3.11 python3.11-pip
sudo dnf install -y ksh ncurses-devel libXdmcp-devel ncurses-compat-libs
sudo dnf install -y libasan libubsan csh libXScrnSaver-devel
sudo dnf install -y qt5-qtbase-devel libgfortran libpng12
sudo dnf install -y libxslt-devel pulseaudio-libs-glib2
sudo dnf install -y llvm-devel clang-devel
sudo dnf install -y xorg*fonts*
cp /home/banana/configuration_file/.gdbinit ~
cp /home/banana/configuration_file/coc-settings.json ~/.vim
cp /home/banana/configuration_file/.vimrc ~
cp /home/banana/configuration_file/.c_cpp ~/.vim -r
cp /home/banana/configuration_file/.zshrc ~
cp /home/banana/configuration_file/ys_modified.zsh-theme ~/.oh-my-zsh/custom
cp /home/banana/configuration_file/init.vim ~/.config/nvim
cp /home/banana/configuration_file/.tessent_startup ~
cp /home/banana/configuration_file/.perltidyrc ~

mkdir ~/.config/pip -p
echo '[global]' > ~/.config/pip/pip.conf
echo 'index-url = http://mirrors.cloud.tencent.com/pypi/simple' >> ~/.config/pip/pip.conf
python3 -m pip install --upgrade pip --user
python3 -m pip install scons ipdb pylint yapf pygments cmakelang cmake-language-server pyright --user
python3 -m pip install cppman you-get sphinx sphinx-rtd-theme autopep8 vim-vint --user
python3 -m pip install pysnooper futures --user
python3 -m pip install distro  # 针对 Python3
python3.11 -m pip install --upgrade pip --user
python3.11 -m pip install neovim --user
python3.11 -m pip install tclint --user

cpanm --local-lib=~/.local/perl5 Perl::LanguageServer Hash::SafeKeys Compiler::Lexer
cargo install du-dust@1.1.2
cargo install bottom@0.8.0 cargo-cache@0.8.3 eza@0.20.24 asm-lsp@0.9.0 --locked
