#!/bin/bash
set -e

echo "🐧 Ubuntu 22.04 开发环境初始化开始..."
echo "========================================"

# ==================== 第零阶段：基础系统更新 ====================
sudo apt update
sudo apt upgrade -y
sudo apt autoremove -y

sudo apt install -y software-properties-common
sudo add-apt-repository universe -y
sudo add-apt-repository multiverse -y
sudo apt update

# ==================== 第一阶段：Zsh / Oh My Zsh / Zinit ====================
sudo apt install -y zsh wget curl unzip git util-linux

wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh
sh install.sh
rm install.sh
bash -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"
mkdir ~/.config/nvim -p
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
echo 'E:\\Users\11849\Downloads\wsl_shared_folder /home/banana/wsl_shared_folder drvfs defaults,uid=1000,gid=1000,metadata 0 0' | sudo tee -a /etc/fstab > /dev/null

# reboot
sudo shutdown -h now
ln -sf ~/wsl_shared_folder/cpp_workspace ~
ln -sf ~/wsl_shared_folder/from_gcc_to_cpp ~
ln -sf ~/wsl_shared_folder/ubuntu18_zsh_configure ~
ln -sf ~/wsl_shared_folder/configuration_file ~
ln -sf ~/wsl_shared_folder/oasys_rtl_qs_ekit ~
ln -sf ~/wsl_shared_folder/PDK/NangateOpenCellLibrary_45nm ~
ln -sf ~/wsl_shared_folder/PDK/tsmc28_pdk ~
sudo ln -sf /mnt/c/Program\ Files/Mozilla\ Firefox/firefox.exe /usr/bin/firefox

# ==================== 第三阶段：字体安装 ====================
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
  [ -f "${font}.zip" ] && unzip -o "${font}.zip" -d "${font}"
done

if [ -d "DejaVuSansMono" ] || [ -d "FantasqueSansMono" ] || [ -d "UbuntuMono" ]; then
  sudo cp -r DejaVuSansMono FantasqueSansMono UbuntuMono /usr/share/fonts/
  sudo chown -R root:root /usr/share/fonts/DejaVuSansMono /usr/share/fonts/FantasqueSansMono /usr/share/fonts/UbuntuMono
  sudo chmod -R 755 /usr/share/fonts/DejaVuSansMono /usr/share/fonts/FantasqueSansMono /usr/share/fonts/UbuntuMono
fi

sudo mkdir -p /usr/share/fonts/win11
sudo ln -sf /mnt/c/Windows/Fonts/* /usr/share/fonts/win11/
sudo fc-cache -fv

# ==================== 第四阶段：配置文件拷贝 ====================
if [ -d ~/configuration_file ]; then
  cp ~/configuration_file/.gdbinit ~
  cp ~/configuration_file/coc-settings.json ~/.vim
  cp -r ~/configuration_file/.c_cpp ~/.vim
  cp ~/configuration_file/.vimrc ~
  cp ~/configuration_file/.zshrc ~
  cp ~/configuration_file/ys_modified.zsh-theme ~/.oh-my-zsh/custom
  cp ~/configuration_file/init.vim ~/.config/nvim
  cp ~/configuration_file/.tessent_startup ~
  cp ~/configuration_file/.perltidyrc ~
  echo "✅ 配置文件拷贝完成"
else
  echo "⚠️ ~/configuration_file 不存在，跳过"
fi

source ~/.zshrc

git config --global user.name "Huaxiao Liang"
git config --global user.email "1184903633@qq.com"
git config --global alias.logline "log --graph --abbrev-commit"
git config --global core.editor gvim
git config --global protocol.https.allow always
git config --global push.default "current"
git config --global url."https://githubfast.com/".insteadOf "https://github.com/"
# ==================== 第五阶段：Python 3.12（不设为系统默认！） ====================
sudo add-apt-repository ppa:deadsnakes/ppa -y
sudo apt update

# 注意：没有 python3.12-distutils（这个包不存在）
sudo apt install -y python3.12 python3.12-dev python3.12-venv python3.12-full
sudo apt install openjdk-25-jdk

# 手动引导 pip
curl -sS --retry 3 https://bootstrap.pypa.io/get-pip.py | python3.12

# ⚠️ 不切系统默认 python3！保持 3.10，避免 apt 的 cnf-update-db 崩溃
echo "ℹ️ Python 3.12 已安装，系统默认 python3 保持 3.10"
echo "ℹ️ 开发时请使用 python3.12 显式调用"

mkdir -p ~/.config/pip
cat > ~/.config/pip/pip.conf <<'EOF'
[global]
index-url = https://mirrors.tuna.tsinghua.edu.cn/pypi/web/simple
EOF

python3.12 -m pip install --upgrade pip --user
python3.12 -m pip install scons pylint cmakelang cmake-language-server pyright \
                          cppman you-get sphinx sphinx-rtd-theme vim-vint black \
                          pysnooper futures tclint distro neovim httpie --user

# ==================== 第六阶段：Node.js 24 + Yarn ====================
curl -fsSL https://deb.nodesource.com/setup_24.x | sudo -E bash - || {
  echo "⚠️ NodeSource 官方源失败，尝试备用方案..."
  sudo apt install -y nodejs npm
}

sudo apt install -y nodejs
sudo npm install -g yarn

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
sudo npm config set registry https://registry.npmmirror.com/
sudo npm cache clean --force
sudo npm install -g @imc-trading/svlangserver neovim

# ==================== 第七阶段：Ruby + rbenv ====================
sudo apt install -y rbenv ruby-full ruby-dev libyaml-dev
git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build && (cd ~/.rbenv/plugins/ruby-build && git pull)
rbenv install 3.3.0
rbenv global 3.3.0
gem sources --clear-all
gem sources -a https://mirrors.ustc.edu.cn/rubygems/
gem install neovim --bindir=$HOME/.local/bin

# ==================== 第八阶段：Rust / Cargo ====================
# ==================== Rust 安装（国内镜像版） ====================

# 1. 设置 rustup 国内镜像环境变量
export RUSTUP_DIST_SERVER="https://rsproxy.cn"
export RUSTUP_UPDATE_ROOT="https://rsproxy.cn/rustup"
export CARGO_HOME="$HOME/.cargo"
export RUSTUP_HOME="$HOME/.rustup"

# 2. 从国内镜像拉取 rustup-init 安装脚本（替代 sh.rustup.rs）
curl --proto '=https' --tlsv1.2 -sSf https://rsproxy.cn/rustup-init.sh | sh -s -- -y
source $HOME/.cargo/env

# 3. 配置 cargo 使用国内 crates.io 镜像（sparse 协议，速度最快）
mkdir -p ~/.cargo
cat > ~/.cargo/config.toml <<'EOF'
[source.crates-io]
replace-with = 'rsproxy-sparse'

[source.rsproxy]
registry = "https://rsproxy.cn/crates.io-index"

[source.rsproxy-sparse]
registry = "sparse+https://rsproxy.cn/index/"

[registries.rsproxy]
index = "https://rsproxy.cn/crates.io-index"

[net]
git-fetch-with-cli = true
EOF

# 4. 安装 CLI 工具：先试 binstall 秒装，失败回退到源码编译
cargo install cargo-binstall
if command -v cargo-binstall &> /dev/null; then
  cargo binstall -y du-dust bottom cargo-cache eza asm-lsp fd-find procs bottom zoxide ripgrep bat hyperfine  2>/dev/null || \
    cargo install du-dust bottom cargo-cache eza asm-lsp fd-find procs bottom zoxide ripgrep bat hyperfine  --locked
else
  cargo install du-dust bottom cargo-cache eza asm-lsp fd-find procs bottom zoxide ripgrep bat hyperfine --locked
fi

# ==================== 第九阶段：Clang 20 ====================
# LLVM 20 官方源（上游 LLVM 团队维护，非 Ubuntu 官方仓库）
wget https://mirrors.tuna.tsinghua.edu.cn/llvm-apt/llvm.sh
chmod +x llvm.sh
sudo ./llvm.sh 20 all -m https://mirrors.tuna.tsinghua.edu.cn/llvm-apt
# 设为系统默认
sudo update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-20 100
sudo update-alternatives --install /usr/bin/clang clang /usr/bin/clang-20 100
sudo update-alternatives --install /usr/bin/clangd clangd /usr/bin/clangd-20 100
sudo update-alternatives --install /usr/bin/clang-format clang-format /usr/bin/clang-format-20 100
sudo update-alternatives --install /usr/bin/clang-apply-replacements clang-apply-replacements /usr/bin/clang-apply-replacements-20 100
sudo update-alternatives --install /usr/bin/clang-change-namespace clang-change-namespace /usr/bin/clang-change-namespace-20 100
sudo update-alternatives --install /usr/bin/clang-check clang-check /usr/bin/clang-check-20 100
sudo update-alternatives --install /usr/bin/clang-cl clang-cl /usr/bin/clang-cl-20 100
sudo update-alternatives --install /usr/bin/clang-cpp clang-cpp /usr/bin/clang-cpp-20 100
sudo update-alternatives --install /usr/bin/clang-doc clang-doc /usr/bin/clang-doc-20 100
sudo update-alternatives --install /usr/bin/clang-extdef-mapping clang-extdef-mapping /usr/bin/clang-extdef-mapping-20 100
sudo update-alternatives --install /usr/bin/clang-format-diff clang-format-diff /usr/bin/clang-format-diff-20 100
sudo update-alternatives --install /usr/bin/clang-include-fixer clang-include-fixer /usr/bin/clang-include-fixer-20 100
sudo update-alternatives --install /usr/bin/clang-move clang-move /usr/bin/clang-move-20 100
sudo update-alternatives --install /usr/bin/clang-offload-bundler clang-offload-bundler /usr/bin/clang-offload-bundler-20 100
sudo update-alternatives --install /usr/bin/clang-query clang-query /usr/bin/clang-query-20 100
sudo update-alternatives --install /usr/bin/clang-refactor clang-refactor /usr/bin/clang-refactor-20 100
sudo update-alternatives --install /usr/bin/clang-reorder-fields clang-reorder-fields /usr/bin/clang-reorder-fields-20 100
sudo update-alternatives --install /usr/bin/clang-scan-deps clang-scan-deps /usr/bin/clang-scan-deps-20 100
sudo update-alternatives --install /usr/bin/clang-tidy clang-tidy /usr/bin/clang-tidy-20 100
sudo update-alternatives --install /usr/bin/clang-tidy-diff clang-tidy-diff /usr/bin/clang-tidy-diff-20.py 100
sudo update-alternatives --install /usr/bin/clang-offload-packager clang-offload-packager /usr/bin/clang-offload-packager-20 100

# ==================== 第十阶段：系统开发工具链 ====================
sudo apt install -y build-essential make cmake valgrind gcc g++ \
    gdb pkg-config autoconf automake libtool \
    gettext patch ninja-build ccache bison flex gperf \
    libx11-dev libxext-dev libxrandr-dev libxcursor-dev \
    libxinerama-dev libxi-dev libxtst-dev libxkbcommon-dev \
    libxcb1-dev libxcb-util-dev libxcb-keysyms1-dev libxcb-icccm4-dev \
    libxcb-image0-dev libxcb-randr0-dev libxcb-render-util0-dev \
    libxcb-shape0-dev libxcb-sync-dev libxcb-xfixes0-dev libxcb-xinerama0-dev \
    libxcb-xkb-dev libxcb-cursor-dev \
    zlib1g-dev libpng-dev libjpeg-dev libsecret-1-dev \
    wayland-protocols libwayland-dev libssl-dev mesa-common-dev \
    libxkbcommon-x11-dev \
    libboost-all-dev tcl-dev tk-dev \
    libgtk-3-dev qtbase5-dev libpulse-dev \
    xfonts-base xfonts-75dpi xfonts-100dpi \
    ksh csh libgfortran5 libxslt1-dev \
    libasan6 libubsan1 \
    libglib2.0-dev libpango1.0-dev libatk1.0-dev \
    libcairo2-dev libgdk-pixbuf-2.0-dev \
    libncurses5-dev libncursesw5-dev libncurses6 \
    libreadline-dev libonig-dev \
    linux-headers-generic
sudo apt install -y ocl-icd-opencl-dev opencl-headers clinfo
sudo apt install -y perl libanyevent-perl libdata-dump-perl libjson-perl \
                    libmoose-perl libpadwalker-perl libscalar-list-utils-perl \
                    libyaml-perl liblwp-protocol-https-perl libpath-tiny-perl \
                    libmodule-build-perl libclass-accessor-perl \
                    libdevel-symdump-perl libpod-coverage-perl libtest-pod-perl \
                    libcapture-tiny-perl libfuture-perl libterm-table-perl \
                    libfile-copy-recursive-reduced-perl libcwd-guard-perl \
                    libclass-inspector-perl libclass-unload-perl \
                    libcoro-perl libio-aio-perl \
                    libcpan-distnameinfo-perl libspreadsheet-parseexcel-perl
sudo apt install -y htop jq tree \
                    p7zip-full p7zip-rar shellcheck xclip xsel \
                    lsb-release diffstat colordiff cpanminus duf
cpanm --local-lib=~/.local/perl5 Perl::LanguageServer Hash::SafeKeys Compiler::Lexer

# ==================== 第十二阶段：VS Code ====================
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | sudo gpg --dearmor -o /usr/share/keyrings/microsoft.gpg
if [ -f microsoft.gpg ]; then
  sudo install -o root -g root -m 644 /usr/share/keyrings/microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
  sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
  sudo apt update
  sudo apt install -y code 2>/dev/null || echo "VS Code 安装失败"
else
  echo "⚠️ Microsoft GPG 密钥下载失败，跳过 VS Code"
fi

# ==================== 第十三阶段：编译安装 ====================
mkdir -p ~/wsl_shared_folder/ubuntu_pack
cd ~/wsl_shared_folder/ubuntu_pack

# ---- Vim ----
if [ ! -d vim ]; then
  git clone https://github.com/vim/vim.git
fi
sudo apt install -y libluajit-5.1-dev luajit libxdmcp-dev libgl1-mesa-dev \
                    mesa-common-dev libgpm-dev libxft-dev libgtk-3-dev \
                    libx11-dev gettext python3.12-dev libxt-dev ruby-dev \
                    libncurses-dev liblua5.4-dev
sudo apt install -y libatk1.0-dev libcairo2-dev libpango1.0-dev \
                    libxpm-dev libxrender-dev libxrandr-dev \
                    libxinerama-dev libxcursor-dev libxcomposite-dev
if [ -d vim ]; then
  cd vim
  git clean -fdx
  make distclean
  ./configure \
    --prefix=/usr/local \
    --with-features=huge \
    --enable-multibyte \
    --enable-rubyinterp=yes \
    --enable-luainterp=yes \
    --enable-gui=gtk3 \
    --enable-cscope=yes \
    --enable-fontset=yes \
    --enable-tclinterp=yes \
    --enable-perlinterp=yes \
    --with-luajit \
    --enable-python3interp=yes \
    --with-python3-config-dir=$(python3.12-config --configdir) \
    --with-python3-command=/usr/bin/python3.12 \
    --enable-gpm \
    --enable-terminal \
    --enable-xim \
    --enable-xsmp
  make -j$(nproc)
  sudo make install
fi

# ---- Icarus Verilog ----
if [ ! -d iverilog ]; then
  git clone https://github.com/steveicarus/iverilog.git 2>/dev/null || echo "⚠️ Icarus Verilog 克隆失败"
fi
sudo apt install -y build-essential libc6-dev linux-libc-dev \
                    libstdc++-12-dev libgcc-12-dev
if [ -d iverilog ]; then
  cd iverilog
  git clean -fdx
  sh autoconf.sh
  ./configure
  make -j$(nproc)
  sudo make install
fi

# ---- Verilator ----
if [ ! -d verilator ]; then
  git clone https://github.com/verilator/verilator.git 2>/dev/null || echo "⚠️ Verilator 克隆失败"
fi
sudo apt install -y ccache numactl autoconf flex bison help2man
if [ -d verilator ]; then
  cd verilator
  unset VERILATOR_ROOT
  make distclean
  git clean -fdx
  autoconf
  ./configure
  make -j$(nproc)
  make test
  sudo make install
fi

# ---- Bear ----
if [ ! -d Bear ]; then
  git clone https://github.com/rizsotto/Bear.git 2>/dev/null || echo "⚠️ Bear 克隆失败"
fi
sudo apt install -y cmake pkg-config \
                    libjson-c-dev libspdlog-dev libfmt-dev \
                    libgtest-dev libgmock-dev \
                    libprotobuf-dev protobuf-compiler \
                    lld binutils g++
if [ -d Bear ]; then
  cd Bear
  git clean -fdx
  mkdir -p build
  cargo build --release
  target/release/generate-completions target/release/completions
  sudo PREFIX=/usr/local ./scripts/install.sh
fi

# ---- Neovim ----
if [ ! -d neovim ]; then
  git clone https://github.com/neovim/neovim 2>/dev/null || echo "⚠️ Neovim 克隆失败"
fi
sudo apt install -y ninja-build libtool autoconf automake pkg-config \
                    unzip patch gettext curl xclip
if [ -d neovim ]; then
  cd neovim
  git clean -fdx
  git checkout stable
  make distclean
  make CMAKE_BUILD_TYPE=Release -j$(nproc)
  sudo make install
fi

# ==================== 第十四阶段：Verible（最后安装） ====================
# not compile it, because the bazel version requirement of verible is too old.
## cd ~/wsl_shared_folder/ubuntu_pack
## sudo apt install apt-transport-https curl gnupg -y
## curl -fsSL https://storage.googleapis.com/bazel-apt/doc/apt-key.pub.gpg | sudo gpg --dearmor -o /usr/share/keyrings/bazel-archive-keyring.gpg
## echo "deb [arch=amd64 signed-by=/usr/share/keyrings/bazel-archive-keyring.gpg] https://mirrors.cernet.edu.cn/bazel-apt stable jdk1.8" | sudo tee /etc/apt/sources.list.d/bazel.list
## sudo apt update && sudo apt install bazel

## git clone https://github.com/chipsalliance/verible
## cd verible
## bazel build -c opt //...
## bazel test -c opt //... --test_verbose_timeout_warnings
## bazel run -c opt :install -- -s /usr/local/bin

cd ~/wsl_shared_folder/ubuntu_pack
wget https://github.com/chipsalliance/verible/releases/download/v0.0-4080-ga0a8d8eb/verible-v0.0-4080-ga0a8d8eb-linux-static-x86_64.tar.gz
x verible-v0.0-4080-ga0a8d8eb-linux-static-x86_64.tar.gz
sudo cp verible-v0.0-4080-ga0a8d8eb/bin/* /usr/local/bin

# install docker
## 0. enable system
sudo tee /etc/wsl.conf <<'EOF'
[boot]
systemd=true
EOF
sudo shutdown -h now
## 1. 清理之前所有失败的残留配置
sudo rm -f /etc/apt/trusted.gpg.d/docker.gpg \
           /etc/apt/keyrings/docker.gpg \
           /etc/apt/keyrings/docker.asc \
           /etc/apt/sources.list.d/docker.list \
           /etc/apt/sources.list.d/docker.sources
## 2. 安装基础工具
sudo apt update
sudo apt install -y ca-certificates curl gnupg lsb-release
## 3. 从阿里云镜像拉取 Docker 官方 GPG 密钥（关键：用 http 而非 https，避开 SSL 重置）
sudo curl -fsSL http://mirrors.aliyun.com/docker-ce/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
## 4. 验证密钥文件是否有效（必须看到一串字母数字指纹才算成功）
gpg --show-keys /etc/apt/keyrings/docker.asc
## 5. 写入软件源信息（用变量自动适配 jammy）
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] http://mirrors.aliyun.com/docker-ce/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
## 6. 刷新并安装
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
## 7. 启动并设置开机自启
sudo systemctl enable --now docker
systemctl status docker
## 8. 把自己加入 docker 组
sudo usermod -aG docker $USER
## 9. reopen terminal
## 10. configure docker image source
sudo mkdir -p /etc/docker
sudo tee /etc/docker/daemon.json > /dev/null <<'EOF'
{
  "registry-mirrors": [
    "https://docker.m.daocloud.io",
    "https://hub-mirror.c.163.com"
  ]
}
EOF
sudo systemctl restart docker
