sudo dnf install -y git zsh wget
git clone git@gitee.com:banana33/configuration_file.git
# also for sudo su
git config --global user.name "Huaxiao Liang"
git config --global user.email "1184903633@qq.com"
git config --global alias.logline "log --graph --abbrev-commit"
git config --global core.editor gvim
git config --global protocol.https.allow always
git config --global push.default "current"
git config --global diff.tool gvimdiff
# git config --global url."https://githubfast.com/".insteadOf "https://github.com/"
wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh
sh install.sh
bash -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"
mkdir ~/.config/nvim -p
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
cp /home/banana/configuration_file/.gdbinit ~
cp /home/banana/configuration_file/coc-settings.json ~/.vim
cp /home/banana/configuration_file/.vimrc ~
cp /home/banana/configuration_file/.c_cpp ~/.vim -r
cp /home/banana/configuration_file/.zshrc ~
cp /home/banana/configuration_file/ys_modified.zsh-theme ~/.oh-my-zsh/custom
cp /home/banana/configuration_file/init.vim ~/.config/nvim
chsh -s $(which zsh)
rm install.sh
pip3 config set global.index-url https://mirrors.tuna.tsinghua.edu.cn/pypi/web/simple

sudo dnf install -y @development-tools
sudo dnf install -y make cmake valgrind gcc g++ llvm clang clangd clang-tools-extra
sudo dnf install -y vim npm nodejs vim-X11 zsh bear git sqlite yarn neovim
sudo dnf install -y python3 python3-pip perl flex duf pipx java
sudo dnf install -y p7zip.x86_64 p7zip-plugins.x86_64
sudo dnf install -y opencl-headers.noarch cargo gem ruby-devel
sudo dnf install -y ocl-icd-devel ocl-icd.x86_64 -y
sudo dnf install -y clinfo boost-devel tcl-devel xauth
sudo dnf install -y fd-find eza zoxide ripgrep bat hyperfine httpie procs
sudo dnf install -y libX11-devel libXext-devel libXrandr-devel libXcursor-devel libXinerama-devel libXi-devel libXtst-devel libxkbcommon-x11-devel libxcb-devel xcb-util-cursor-devel
sudo dnf install -y gstreamer1-plugins-base-devel gstreamer1-devel xcb-util-wm xcb-util-keysyms
sudo dnf install -y zlib-devel libpng-devel libjpeg-devel libsecret-devel
sudo dnf install -y wayland-devel libxkbcommon-devel openssl-devel mesa-libGL-devel
sudo dnf install -y kernel-headers kernel-devel
sudo dnf install -y kmodtool akmods mokutil openssl dkms
# sudo dnf provides */xxx.so

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
cargo install du-dust bottom cargo-cache asm-lsp

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
sudo npm install -g neovim
gem install neovim --user-install

cd ~
wget https://ftp.gnu.org/gnu/bison/bison-3.3.tar.gz
x bison-3.3.tar.gz
rm bison-3.3.tar.gz
cd bison-3.3
./configure
make
sudo make install

sudo vim /etc/ssh/sshd_config
# Modify the following content:
X11Forwarding yes
X11DisplayOffset 10

sudo dnf install -y perl-AnyEvent perl-Data-Dump perl-JSON perl-Moose perl-PadWalker perl-Scalar-List-Utils
sudo dnf install -y perl-App-cpanminus
cpanm --local-lib=~/.local/perl5 AnyEvent Data::Dump IO::AIO JSON Moose PadWalker Scalar::List::Utils Coro
cpanm --local-lib=~/.local/perl5 YAML CPAN::DistnameInfo CPAN Spreadsheet::ParseExcel Spreadsheet::WriteExcel Excel::Writer::XLSX
cpanm --local-lib=~/.local/perl5 Neovim::Ext Class::Refresh Compiler::Lexer Hash::SafeKeys Perl::LanguageServer

sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
sudo dnf update
sudo dnf install -y code

[install nvidia-driver](https://cloud.baidu.com/article/3404246)

tee > /tmp/oneAPI.repo << EOF
[oneAPI]
name=Intel® oneAPI repository
baseurl=https://yum.repos.intel.com/oneapi
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://yum.repos.intel.com/intel-gpg-keys/GPG-PUB-KEY-INTEL-SW-PRODUCTS.PUB
EOF

sudo mv /tmp/oneAPI.repo /etc/yum.repos.d
sudo dnf install -y intel-oneapi-runtime-opencl

sudo dnf install gdouros-symbola-fonts # For special symbols or emojis, like 🌪.
wget https://developer.download.nvidia.com/compute/cuda/12.4.1/local_installers/cuda-repo-fedora39-12-4-local-12.4.1_550.54.15-1.x86_64.rpm
sudo rpm -i cuda-repo-fedora39-12-4-local-12.4.1_550.54.15-1.x86_64.rpm
sudo dnf clean all
sudo dnf -y install cuda-toolkit-12-4
sudo dnf install g++-13 gcc-13
