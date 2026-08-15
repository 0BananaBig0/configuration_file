sudo dnf install -y git zsh wget
# also for sudo su
git config --global user.name "Huaxiao Liang"
git config --global user.email "1184903633@qq.com"
git config --global alias.logline "log --graph --abbrev-commit"
git config --global core.editor gvim
git config --global protocol.https.allow always
git config --global push.default "current"
# git config --global url."https://githubfast.com/".insteadOf "https://github.com/"
wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh
sh install.sh
bash -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"
mkdir ~/.config/nvim -p
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
echo 'E:\\Users\11849\Downloads\wsl_shared_folder /home/banana/wsl_shared_folder drvfs defaults,uid=1000,gid=1000,metadata 0 0' | sudo tee -a /etc/fstab > /dev/null

# reboot
sudo shutdown -h now
ln -s ~/wsl_shared_folder/cpp_workspace ~
ln -s ~/wsl_shared_folder/from_gcc_to_cpp ~
ln -s ~/wsl_shared_folder/ubuntu18_zsh_configure ~
ln -s ~/wsl_shared_folder/configuration_file ~
ln -s ~/wsl_shared_folder/oasys_rtl_qs_ekit ~
ln -s ~/wsl_shared_folder/PDK/NangateOpenCellLibrary_45nm ~
ln -s ~/wsl_shared_folder/PDK/tsmc28_pdk ~
cp ~/wsl_shared_folder/.ssh -r ~
[ -d ~/configuration_file/terminal-backup ] && \
cp -af ~/configuration_file/terminal-backup/terminator ~/.config/ && \
cp -af ~/configuration_file/terminal-backup/konsolerc ~/.config/ && \
cp -af ~/configuration_file/terminal-backup/konsole ~/.local/share/
chmod 700 /home/banana/.ssh && \
chmod 600 /home/banana/.ssh/id_rsa 2>/dev/null || true && \
chmod 644 /home/banana/.ssh/id_rsa.pub 2>/dev/null || true && \
chmod 600 /home/banana/.ssh/config 2>/dev/null || true && \
chmod 600 /home/banana/.ssh/authorized_keys 2>/dev/null || true

# ==================== 第三阶段：字体安装 ====================
sudo dnf install -y @development-tools
sudo dnf install -y make cmake valgrind gcc g++ llvm clang clangd clang-tools-extra autoconf
sudo dnf install -y npm nodejs bear git sqlite yarn neovim vim vim-X11
sudo dnf install -y python3 python3-pip perl flex duf pipx java python3-setuptools
sudo dnf install -y p7zip p7zip-plugins
sudo dnf install -y ShellCheck cargo gem ruby-devel
sudo dnf install -y boost-devel tcl-devel xauth
sudo dnf install -y fd-find zoxide ripgrep bat hyperfine httpie procs
sudo dnf install -y libX11-devel libXext-devel libXrandr-devel libXcursor-devel libXinerama-devel libXi-devel libXtst-devel libxkbcommon-x11-devel libxcb-devel xcb-util-cursor-devel
sudo dnf install -y gstreamer1-plugins-base-devel gstreamer1-devel xcb-util-wm xcb-util-keysyms
sudo dnf install -y zlib-devel libpng-devel libjpeg-devel libsecret-devel
sudo dnf install -y wayland-devel libxkbcommon-devel openssl-devel mesa-libGL-devel
sudo dnf install -y kernel-headers kernel-devel
sudo dnf install -y kmodtool akmods mokutil openssl dkms
# sudo dnf provides */xxx.so
sudo dnf install -y python3-devel libxml2-devel libxslt-devel
mkdir -p ~/wsl_shared_folder/font
cd ~/wsl_shared_folder/font

for font in DejaVuSansMono FantasqueSansMono UbuntuMono; do
  if [ ! -f "${font}.zip" ]; then
    echo "下载 ${font}.zip..."
    curl -fL --retry 3 --connect-timeout 10 \
      "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/${font}.zip" \
      -o "${font}.zip" || echo "⚠️ ${font}.zip 下载失败，跳过"
  fi
done

for font in DejaVuSansMono FantasqueSansMono UbuntuMono; do
  [ -f "${font}.zip" ] && unzip -o "${font}.zip" -d "${font}" 2>/dev/null || true
done

if [ -d "DejaVuSansMono" ] || [ -d "FantasqueSansMono" ] || [ -d "UbuntuMono" ]; then
  sudo cp -r DejaVuSansMono FantasqueSansMono UbuntuMono /usr/share/fonts/ 2>/dev/null || true
  sudo chown -R root:root /usr/share/fonts/DejaVuSansMono /usr/share/fonts/FantasqueSansMono /usr/share/fonts/UbuntuMono 2>/dev/null || true
  sudo chmod -R 755 /usr/share/fonts/DejaVuSansMono /usr/share/fonts/FantasqueSansMono /usr/share/fonts/UbuntuMono 2>/dev/null || true
fi

sudo mkdir -p /usr/share/fonts/win11
sudo ln -sf /mnt/c/Windows/Fonts/* /usr/share/fonts/win11/ 2>/dev/null || true
sudo fc-cache -fv
cp /home/banana/configuration_file/.gdbinit ~
cp /home/banana/configuration_file/coc-settings.json ~/.vim
cp /home/banana/configuration_file/.vimrc ~
cp /home/banana/configuration_file/.c_cpp ~/.vim -r
cp /home/banana/configuration_file/.zshrc ~
cp /home/banana/configuration_file/ys_modified.zsh-theme ~/.oh-my-zsh/custom
cp /home/banana/configuration_file/init.vim ~/.config/nvim
cp /home/banana/configuration_file/.tessent_startup ~
source ~/.zshrc

python3 -m pip config set global.index-url https://mirrors.tuna.tsinghua.edu.cn/pypi/web/simple
python3 -m pip install --user scons ipdb pylint yapf pygments cmakelang cmake-language-server \
                       pyright cppman you-get sphinx sphinx-rtd-theme autopep8 \
                       vim-vint tclint black pysnooper futures neovim #not do for root
cargo install du-dust bottom cargo-cache asm-lsp eza --locked

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
gem install neovim --bindir=$HOME/.local/bin

cd ~/wsl_shared_folder/fedora_pack
wget https://ftp.gnu.org/gnu/bison/bison-3.3.tar.gz
x bison-3.3.tar.gz
rm bison-3.3.tar.gz
cd bison-3.3
./configure
make
sudo make install

sudo dnf install -y perl-AnyEvent perl-Data-Dump perl-JSON perl-Moose perl-PadWalker perl-Scalar-List-Utils
sudo dnf install -y perl-App-cpanminus perl-Coro perl-AnyEvent perl-Class-Refresh perl-YAML perl-Data-Dump
sudo dnf install -y perl-IO-AIO perl-JSON perl-Mo-Moose perl-PadWalker perl-Scalar-List-Utils perl-CPAN-DistnameInfo
sudo dnf install -y perl-CPAN perl-Spreadsheet-ParseExcel perl-Spreadsheet-WriteExcel perl-Spreadsheet-XLSX
sudo dnf install -y perl-LWP-Protocol-https perl-Path-Tiny perl-IO-Async perl-Module-Build perl-Module-Build-XSUtil
sudo dnf install -y perl-Module-Build-Tiny perl-ExtUtils-Config perl-ExtUtils-Install perl-ExtUtils-Helpers
sudo dnf install -y perl-Devel-CheckCompiler perl-Test-Requires perl-Cwd-Guard perl-Capture-Tiny
sudo dnf install -y perl-File-Copy-Recursive-Reduced perl-Future perl-Struct-Dumb perl-Metrics-Any
sudo dnf install -y perl-Test-Metrics-Any perl-Test-Future-IO-Impl perl-Devel-Symdump
sudo dnf install -y perl-Pod-Coverage perl-Test-Pod-Coverage perl-Test-Pod perl-Class-Accessor
# cpanm --local-lib=~/.local/perl5 Moose
cpanm --local-lib=~/.local/perl5 Perl::LanguageServer Hash::SafeKeys Compiler::Lexer
cpanm --local-lib=~/.local/perl5 --force Neovim::Ext

sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
sudo dnf update
sudo dnf install -y code

sudo dnf install -y gdouros-symbola-fonts # For special symbols or emojis, like 🌪.
sudo cp ~/configuration_file/local.conf /etc/fonts/ # or modify 40-nonlatin.conf, but difficult
sudo dnf install -y ocl-icd-devel ocl-icd opencl-headers clinfo pocl pocl-devel

sudo ln /mnt/c/Program\ Files/Mozilla\ Firefox/firefox.exe /usr/bin/firefox -s
sudo dnf install -y verilator iverilog yosys
sudo npm install -g @imc-trading/svlangserver
sudo dnf -y copr enable rezso/HDL
sudo dnf install -y verible

# for a special tool
# sudo dnf install -y ksh ncurses-devel libXdmcp-devel ncurses-compat-libs
# sudo dnf install -y libasan libubsan csh libXScrnSaver-devel
# sudo dnf install -y qt5-qtbase-devel-5.15.16 pulseaudio-libs-glib2

# If WSL2 fails to start via MobaXterm after initial setup, adjust the session's Run Method setting by replacing Autodetection with Native Connector.

# for calibre2023
# mkdir ~/wsl_shared_folder/fedora_pack -p
# cd ~/wsl_shared_folder/fedora_pack
# wget https://archives.boost.io/release/1.66.0/source/boost_1_66_0.tar.gz
# x boost_1_66_0.tar.gz
# rm boost_1_66_0.tar.gz
# cd boost_1_66_0
# ./bootstrap.sh --with-python=/usr/bin/python3.13
# ./b2 -j24
# sudo ./b2 install

# cd ~/wsl_shared_folder/fedora_pack
# wget https://github.com/unicode-org/icu/releases/download/release-60-3/icu4c-60_3-src.tgz
# tar xvf icu4c-60_3-src.tgz
# cd icu/source
# ./configure
# make -j24
# sudo make install

# for compiling libnsl-1.3.0
# for calibre2024
# for vcs2023 and verdi2024
# sudo dnf install -y libxslt-devel lsb_release
# sudo dnf install -y libtirpc-devel
# cd ~/wsl_shared_folder/fedora_pack
# wget https://github.com/thkukuk/libnsl/releases/download/v1.3.0/libnsl-1.3.0.tar.xz
# x libnsl-1.3.0.tar.xz
# cd libnsl
# ./configure --prefix=/EDA/library
# make -j24
# make install
sudo dnf install konsole terminator -y


export CODEX_HOME="$HOME/.local/.codex_home/codex"
mkdir -p $HOME/.local/bin
curl -fsSL https://chatgpt.com/codex/install.sh -o $HOME/.local/bin/install_codex.sh
sh $HOME/.local/bin/install_codex.sh
ensure_dracula_konsole() {
    local target="${1:-$HOME/.local/share/konsole/Dracula.colorscheme}"

    if [[ -f "$target" ]]; then
        echo "Dracula theme already installed at: $target"
        return 0
    fi

    echo "Dracula theme not found. Installing..."

    local tmpdir
    tmpdir=$(mktemp -d) || { echo "Failed to create temp dir" >&2; return 1; }

    git clone --depth 1 https://github.com/dracula/konsole "$tmpdir/konsole" 2>/dev/null || {
        echo "Failed to clone repository" >&2
        rm -rf "$tmpdir"
        return 1
    }

    mkdir -p "$(dirname "$target")"
    mv "$tmpdir/konsole/Dracula.colorscheme" "$target"
    rm -rf "$tmpdir"

    echo "Dracula theme installed at: $target"
}
ensure_dracula_konsole

# for openai to call some tools
sudo dnf install -y libreoffice-writer libreoffice-calc libreoffice-impress firefox

# install podman to replace docker
# 1. 更新元数据
sudo dnf update -y
# 2. 装 Podman 引擎 + 辅助包（rootless 网络/挂载用）
sudo dnf install -y podman podman-compose fuse-overlayfs
# 3. 验证
podman --version
podman run --rm docker.io/library/hello-world
# 建系统级 symlink
sudo ln -sf /usr/bin/podman /usr/local/bin/docker
sudo ln -sf /usr/bin/podman-compose /usr/local/bin/docker-compose

# mount FedoraLinux into win11 persistently, execute the following commands in powershell
net use F: \\wsl.localhost\FedoraLinux /persistent:yes
# unmount FedoraLinux
net use F: /delete
# mount FedoraLinux into win11 temporarily, execute the following commands in powershell
subst G: "\\wsl.localhost\FedoraLinux\home\banana"

# install ssh for connection from other devices in the internal network.
# 1. 安装服务端（客户端一般已带）
sudo dnf install -y openssh-server openssh-clients
# 2. 启动并设置开机自启
sudo systemctl enable --now sshd
# 3. 确认服务状态
sudo systemctl status sshd
# 应看到 Active: active (running)
# 4. 确认 22 端口在监听
sudo ss -tlnp | grep :22
