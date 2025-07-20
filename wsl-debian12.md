sudo su
mv /etc/apt/sources.list /etc/apt/sources.list.backup
vi /etc/apt/sources.list
deb http://mirrors.tuna.tsinghua.edu.cn/debian/ bookworm main contrib non-free non-free-firmware
deb-src http://mirrors.tuna.tsinghua.edu.cn/debian/ bookworm main contrib non-free non-free-firmware

deb http://mirrors.tuna.tsinghua.edu.cn/debian/ bookworm-updates main contrib non-free non-free-firmware
deb-src http://mirrors.tuna.tsinghua.edu.cn/debian/ bookworm-updates main contrib non-free non-free-firmware

deb http://mirrors.tuna.tsinghua.edu.cn/debian/ bookworm-backports main contrib non-free non-free-firmware
deb-src http://mirrors.tuna.tsinghua.edu.cn/debian/ bookworm-backports main contrib non-free non-free-firmware

deb http://mirrors.tuna.tsinghua.edu.cn/debian-security bookworm-security main contrib non-free non-free-firmware
deb-src http://mirrors.tuna.tsinghua.edu.cn/debian-security bookworm-security main contrib non-free non-free-firmware
apt update -y
apt install apt-transport-https ca-certificates
apt update -y && apt upgrade -y
apt install zsh -y
sed -i 's/http/https/g' /etc/apt/sources.list # modify http to https
apt update
# no need mount on disk in wsl2 and install nvidia-driver
ln -s /mnt/d/Users/11849/Documents
ln -s /mnt/d/Users/11849/Videos
ln -s /mnt/d/Users/11849/Downloads
ln -s /mnt/d/Users/11849/Desktop WDesktop
sudo apt install -y make cmake valgrind gcc g++ ccache
sudo apt remove vim-common -y
sudo apt install -y vim npm nodejs vim-gtk3
sudo apt install -y bear git curl wget p7zip-full
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
cp ~/Downloads/wsl_shared_folder/configuration_file/ys_modified.zsh-theme ~/.oh-my-zsh/custom
cp ~/Downloads/wsl_shared_folder/configuration_file/.zshrc ~
rm install.sh
exit
cd ~/Downloads
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/DejaVuSansMono.zip
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/FantasqueSansMono.zip
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/UbuntuMono.zip
x DejaVuSansMono.zip FantasqueSansMono.zip UbuntuMono.zip
sudo mv DejaVuSansMono/ FantasqueSansMono UbuntuMono /usr/share/fonts
cd /usr/share/fonts
sudo chown root:root DejaVuSansMono FantasqueSansMono UbuntuMono -R
sudo chmod 755 DejaVuSansMono FantasqueSansMono UbuntuMono -R
sudo fc-cache -fv
sudo apt install -y cargo rustc
sudo apt install -y python3 python3-pip pipx
sudo apt install -y neovim xclip
sudo apt install -y fd-find exa zoxide ripgrep bat hyperfine duf httpie
cargo install du-dust@0.8.6 bottom@0.6.3 procs@0.13.0 --locked #not do for root
pipx install ipdb
pipx install scons
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
pip install pysnooper futures neovim --break-system-packages #not do for root
mkdir ~/.config/nvim -p
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
cp ~/Downloads/wsl_shared_folder/configuration_file/.vimrc ~
cp ~/Downloads/wsl_shared_folder/configuration_file/.c_cpp ~/.vim -r
cp ~/Downloads/wsl_shared_folder/configuration_file/coc-settings.json ~/.vim
ln -s ~/.vimrc ~/.config/nvim/init.vim
ln -s ~/.vim/coc-settings.json ~/.config/nvim
npm config set coc.nvim:registry https://registry.npmmirror.com
sudo npm config set coc.nvim:registry https://registry.npmmirror.com
npm config set registry https://registry.npmmirror.com/ && \
npm cache clean --force
sudo npm config set registry https://registry.npmmirror.com/ && \
sudo npm cache clean --force
sudo npm install -g neovim yarn
yarn config set registry https://registry.npmmirror.com/ --global  && \
yarn config set sass_binary_site https://cdn.npmmirror.com/binaries/node-sass --global  && \
yarn config set electron_mirror https://registry.npmmirror.com/binary.html?path=electron/ --global  && \
yarn config set puppeteer_download_host https://registry.npmmirror.com/binary.html --global  && \
yarn config set chromedriver_cdnurl https://cdn.npmmirror.com/binaries/chromedriver --global  && \
yarn config set operadriver_cdnurl https://cdn.npmmirror.com/binaries/operadriver --global  && \
yarn config set phantomjs_cdnurl https://cdn.npmmirror.com/binaries/phantomjs --global  && \
yarn config set selenium_cdnurl https://cdn.npmmirror.com/binaries/selenium --global  && \
yarn config set node_inspector_cdnurl https://cdn.npmmirror.com/binaries/node-inspector --global
sudo yarn config set registry https://registry.npmmirror.com/ --global  && \
sudo yarn config set sass_binary_site https://cdn.npmmirror.com/binaries/node-sass --global  && \
sudo yarn config set electron_mirror https://registry.npmmirror.com/binary.html?path=electron/ --global  && \
sudo yarn config set puppeteer_download_host https://registry.npmmirror.com/binary.html --global  && \
sudo yarn config set chromedriver_cdnurl https://cdn.npmmirror.com/binaries/chromedriver --global  && \
sudo yarn config set operadriver_cdnurl https://cdn.npmmirror.com/binaries/operadriver --global  && \
sudo yarn config set phantomjs_cdnurl https://cdn.npmmirror.com/binaries/phantomjs --global  && \
sudo yarn config set selenium_cdnurl https://cdn.npmmirror.com/binaries/selenium --global  && \
sudo yarn config set node_inspector_cdnurl https://cdn.npmmirror.com/binaries/node-inspector --global
sudo apt install -y opencl-headers ocl-icd-dev ocl-icd-opencl-dev pocl-opencl-icd
sudo apt install -y clinfo libboost-all-dev tcl-dev pkg-config
sudo apt install -y perl libdb-dev libcap-dev libacl1-dev
cd ~
wget https://vscode.download.prss.microsoft.com/dbazure/download/stable/38c31bc77e0dd6ae88a4e9cc93428cc27a56ba40/code_1.93.1-1726079302_amd64.deb
sudo dpkg -i code_*.deb
rm code_*.deb
sudo apt install --fix-broken -y
cd ~/wsl_shared_folder
wget https://ftp.gnu.org/gnu/bison/bison-3.3.tar.gz
x bison-3.3.tar.gz
sudo apt install m4 flex -y
cd bison-3.3
./configure
make
sudo make install
cd ~/wsl_shared_folder
rm bison-3.3.tar.gz
# Fix an error of ping
sudo setcap cap_net_raw+p /bin/ping
sudo mkdir /usr/share/fonts/win11 # to differentiate self-built font links from system font files
sudo ln -s /mnt/c/Windows/Fonts/* /usr/share/fonts/win11
# if you can't open GUI, add "export DISPLAY=:0" to your .zshrc or .bashrc
sudo apt install dbus-x11 adwaita-icon-theme -y #also for qt icons
# 先备份配置
sudo cp /etc/xrdp/xrdp.ini /etc/xrdp/xrdp.ini.backup
# 修改配置文件
## 设置 xrdp 的默认服务端口为 3390，即微软远程桌面协议惹默认端口
sudo sed -i 's/3389/3390/g' /etc/xrdp/xrdp.ini
## 修改 位/像素（bpp）
sudo sed -i 's/max_bpp=32/#max_bpp=32\nmax_bpp=128/g' /etc/xrdp/xrdp.ini
sudo sed -i 's/xserverbpp=24/#xserverbpp=24\nxserverbpp=128/g' /etc/xrdp/xrdp.ini
# 指定 x windows system 启动使用我们安装的 xfce4
echo xfce4-session > ~/.xsession
# 修改 xrdp 的窗口管理器的启动脚本
sudo vim /etc/xrdp/startwm.sh
## 注释掉最后两行（test 和 exec 开头），并添加
#test -x /etc/X11/Xsession && exec /etc/X11/Xsession
#exec /bin/sh /etc/X11/Xsession
# xfce
startxfce4

sudo /etc/init.d/xrdp start
cp ~/Downloads/wsl_shared_folder/configuration_file/.gdbinit ~
cp ~/Downloads/wsl_shared_folder/configuration_file/settings.json ~/.config/Code/User

echo -e "[boot]\nsystemd=true" | sudo tee -a /etc/wsl.conf
cd /usr/lib/wsl
sudo mkdir lib2
sudo ln -s lib/* lib2
sudo sed -i 's/usr\/lib\/wsl\/lib/usr\/lib\/wsl\/lib2/g' /etc/ld.so.conf.d/ld.wsl.conf
echo -e "[automount]\nldconfig=false" | sudo tee -a /etc/wsl.conf

# Do not install libglfw3-wayland; it is an alternative to libglfw3.  sudo apt install libglfw3 libglfw3-dev libglfw3-doc

sudo apt remove neovim --purge -y
sudo apt autoremove --purge -y
wget https://githubfast.com/neovim/neovim-releases/releases/download/v0.10.3/nvim-linux64.deb
sudo dpkg -i nvim-linux64.deb
rm nvim-linux64.deb
sudo apt install python3-neovim -y
sudo apt install ruby-dev -y
gem install neovim --bindir=$HOME/.local/bin

sudo apt purge -y clang* llvm*
sudo apt update
sudo apt autoremove --purge
sudo apt install *clang*16* *llvm*16* lld-16 lldb-16
sudo update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-16 160
sudo update-alternatives --install /usr/bin/clang clang /usr/bin/clang-16 160
sudo update-alternatives --install /usr/bin/clang-apply-replacements clang-apply-replacements /usr/bin/clang-apply-replacements-16 160
sudo update-alternatives --install /usr/bin/clang-change-namespace clang-change-namespace /usr/bin/clang-change-namespace-16 160
sudo update-alternatives --install /usr/bin/clang-check clang-check /usr/bin/clang-check-16 160
sudo update-alternatives --install /usr/bin/clang-cl clang-cl /usr/bin/clang-cl-16 160
sudo update-alternatives --install /usr/bin/clang-cpp clang-cpp /usr/bin/clang-cpp-16 160
sudo update-alternatives --install /usr/bin/clangd clangd /usr/bin/clangd-16 160
sudo update-alternatives --install /usr/bin/clang-doc clang-doc /usr/bin/clang-doc-16 160
sudo update-alternatives --install /usr/bin/clang-extdef-mapping clang-extdef-mapping /usr/bin/clang-extdef-mapping-16 160
sudo update-alternatives --install /usr/bin/clang-format clang-format /usr/bin/clang-format-16 160
sudo update-alternatives --install /usr/bin/clang-format-diff clang-format-diff /usr/bin/clang-format-diff-16 160
sudo update-alternatives --install /usr/bin/clang-include-cleaner clang-include-cleaner /usr/bin/clang-include-cleaner-16 160
sudo update-alternatives --install /usr/bin/clang-include-fixer clang-include-fixer /usr/bin/clang-include-fixer-16 160
sudo update-alternatives --install /usr/bin/clang-linker-wrapper clang-linker-wrapper /usr/bin/clang-linker-wrapper-16 160
sudo update-alternatives --install /usr/bin/clang-move clang-move /usr/bin/clang-move-16 160
sudo update-alternatives --install /usr/bin/clang-offload-bundler clang-offload-bundler /usr/bin/clang-offload-bundler-16 160
sudo update-alternatives --install /usr/bin/clang-offload-packager clang-offload-packager /usr/bin/clang-offload-packager-16 160
sudo update-alternatives --install /usr/bin/clang-pseudo clang-pseudo /usr/bin/clang-pseudo-16 160
sudo update-alternatives --install /usr/bin/clang-query clang-query /usr/bin/clang-query-16 160
sudo update-alternatives --install /usr/bin/clang-refactor clang-refactor /usr/bin/clang-refactor-16 160
sudo update-alternatives --install /usr/bin/clang-rename clang-rename /usr/bin/clang-rename-16 160
sudo update-alternatives --install /usr/bin/clang-reorder-fields clang-reorder-fields /usr/bin/clang-reorder-fields-16 160
sudo update-alternatives --install /usr/bin/clang-repl clang-repl /usr/bin/clang-repl-16 160
sudo update-alternatives --install /usr/bin/clang-scan-deps clang-scan-deps /usr/bin/clang-scan-deps-16 160
sudo update-alternatives --install /usr/bin/clang-tidy clang-tidy /usr/bin/clang-tidy-16 160
sudo update-alternatives --install /usr/bin/clang-tidy-diff clang-tidy-diff /usr/bin/clang-tidy-diff-16.py 160
sudo update-alternatives --install /usr/bin/FileCheck FileCheck /usr/bin/FileCheck-16 160
sudo update-alternatives --install /usr/bin/lld lld /usr/bin/lld-16 160
sudo update-alternatives --install /usr/bin/lldb lldb /usr/bin/lldb-16 160

sudo apt install pandoc texlive-xetex texlive-luatex pandoc-citeproc-preamble texlive-pstricks -y
sudo npm -g install instant-markdown-d@next

# install qt
sudo apt-get install build-essential libgl1-mesa-dev libxkbcommon-x11-dev libxcb-icccm4-dev libxcb-image0-dev libxcb-keysyms1-dev libxcb-render-util0-dev libxcb-cursor-dev
cd ~/wsl_shared_folder
mkdir .Qt6_Online_Installer
cd .Qt6_Online_Installer
wget https://download.qt.io/official_releases/online_installers/qt-unified-linux-x64-online.run
chmod a+x qt-unified-linux-x64-online.run
./qt-unified-linux-x64-online.run

sudo apt purge *clang*16* *llvm*16* lld-16 lldb-16
sudo update-alternatives --remove clang++ /usr/bin/clang++-16
sudo update-alternatives --remove clang /usr/bin/clang-16
sudo update-alternatives --remove clang-apply-replacements /usr/bin/clang-apply-replacements-16
sudo update-alternatives --remove clang-change-namespace /usr/bin/clang-change-namespace-16
sudo update-alternatives --remove clang-check /usr/bin/clang-check-16
sudo update-alternatives --remove clang-cl /usr/bin/clang-cl-16
sudo update-alternatives --remove clang-cpp /usr/bin/clang-cpp-16
sudo update-alternatives --remove clangd /usr/bin/clangd-16
sudo update-alternatives --remove clang-doc /usr/bin/clang-doc-16
sudo update-alternatives --remove clang-extdef-mapping /usr/bin/clang-extdef-mapping-16
sudo update-alternatives --remove clang-format /usr/bin/clang-format-16
sudo update-alternatives --remove clang-format-diff /usr/bin/clang-format-diff-16
sudo update-alternatives --remove clang-include-cleaner /usr/bin/clang-include-cleaner-16
sudo update-alternatives --remove clang-include-fixer /usr/bin/clang-include-fixer-16
sudo update-alternatives --remove clang-linker-wrapper /usr/bin/clang-linker-wrapper-16
sudo update-alternatives --remove clang-move /usr/bin/clang-move-16
sudo update-alternatives --remove clang-offload-bundler /usr/bin/clang-offload-bundler-16
sudo update-alternatives --remove clang-offload-packager /usr/bin/clang-offload-packager-16
sudo update-alternatives --remove clang-pseudo /usr/bin/clang-pseudo-16
sudo update-alternatives --remove clang-query /usr/bin/clang-query-16
sudo update-alternatives --remove clang-refactor /usr/bin/clang-refactor-16
sudo update-alternatives --remove clang-rename /usr/bin/clang-rename-16
sudo update-alternatives --remove clang-reorder-fields /usr/bin/clang-reorder-fields-16
sudo update-alternatives --remove clang-repl /usr/bin/clang-repl-16
sudo update-alternatives --remove clang-scan-deps /usr/bin/clang-scan-deps-16
sudo update-alternatives --remove clang-tidy /usr/bin/clang-tidy-16
sudo update-alternatives --remove clang-tidy-diff /usr/bin/clang-tidy-diff-16.py
sudo update-alternatives --remove FileCheck /usr/bin/FileCheck-16
sudo update-alternatives --remove lld /usr/bin/lld-16
sudo update-alternatives --remove lldb /usr/bin/lldb-16
echo "deb https://mirrors.tuna.tsinghua.edu.cn/llvm-apt/bookworm/ llvm-toolchain-bookworm-19 main" | sudo tee /etc/apt/sources.list.d/llvm.list
echo "# deb-src https://mirrors.tuna.tsinghua.edu.cn/llvm-apt/bookworm/ llvm-toolchain-bookworm-19 main" | sudo tee -a /etc/apt/sources.list.d/llvm.list
sudo wget -O /etc/apt/trusted.gpg.d/llvm.asc https://apt.llvm.org/llvm-snapshot.gpg.key
sudo apt clean
sudo apt update
sudo apt install *clang*19* *llvm*19* lld-19 lldb-19 cdecl -y
sudo update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-19 190
sudo update-alternatives --install /usr/bin/clang clang /usr/bin/clang-19 190
sudo update-alternatives --install /usr/bin/clang-apply-replacements clang-apply-replacements /usr/bin/clang-apply-replacements-19 190
sudo update-alternatives --install /usr/bin/clang-change-namespace clang-change-namespace /usr/bin/clang-change-namespace-19 190
sudo update-alternatives --install /usr/bin/clang-check clang-check /usr/bin/clang-check-19 190
sudo update-alternatives --install /usr/bin/clang-cl clang-cl /usr/bin/clang-cl-19 190
sudo update-alternatives --install /usr/bin/clang-cpp clang-cpp /usr/bin/clang-cpp-19 190
sudo update-alternatives --install /usr/bin/clangd clangd /usr/bin/clangd-19 190
sudo update-alternatives --install /usr/bin/clang-doc clang-doc /usr/bin/clang-doc-19 190
sudo update-alternatives --install /usr/bin/clang-extdef-mapping clang-extdef-mapping /usr/bin/clang-extdef-mapping-19 190
sudo update-alternatives --install /usr/bin/clang-format clang-format /usr/bin/clang-format-19 190
sudo update-alternatives --install /usr/bin/clang-format-diff clang-format-diff /usr/bin/clang-format-diff-19 190
sudo update-alternatives --install /usr/bin/clang-include-cleaner clang-include-cleaner /usr/bin/clang-include-cleaner-19 190
sudo update-alternatives --install /usr/bin/clang-include-fixer clang-include-fixer /usr/bin/clang-include-fixer-19 190
sudo update-alternatives --install /usr/bin/clang-installapi clang-installapi /usr/bin/clang-installapi-19 190
sudo update-alternatives --install /usr/bin/clang-linker-wrapper clang-linker-wrapper /usr/bin/clang-linker-wrapper-19 190
sudo update-alternatives --install /usr/bin/clang-move clang-move /usr/bin/clang-move-19 190
sudo update-alternatives --install /usr/bin/clang-nvlink-wrapper clang-nvlink-wrapper /usr/bin/clang-nvlink-wrapper-19 190
sudo update-alternatives --install /usr/bin/clang-offload-bundler clang-offload-bundler /usr/bin/clang-offload-bundler-19 190
sudo update-alternatives --install /usr/bin/clang-offload-packager clang-offload-packager /usr/bin/clang-offload-packager-19 190
sudo update-alternatives --install /usr/bin/clang-pseudo clang-pseudo /usr/bin/clang-pseudo-19 190
sudo update-alternatives --install /usr/bin/clang-query clang-query /usr/bin/clang-query-19 190
sudo update-alternatives --install /usr/bin/clang-refactor clang-refactor /usr/bin/clang-refactor-19 190
sudo update-alternatives --install /usr/bin/clang-rename clang-rename /usr/bin/clang-rename-19 190
sudo update-alternatives --install /usr/bin/clang-reorder-fields clang-reorder-fields /usr/bin/clang-reorder-fields-19 190
sudo update-alternatives --install /usr/bin/clang-repl clang-repl /usr/bin/clang-repl-19 190
sudo update-alternatives --install /usr/bin/clang-scan-deps clang-scan-deps /usr/bin/clang-scan-deps-19 190
sudo update-alternatives --install /usr/bin/clang-tidy clang-tidy /usr/bin/clang-tidy-19 190
sudo update-alternatives --install /usr/bin/clang-tidy-diff.py clang-tidy-diff.py /usr/bin/clang-tidy-diff-19.py 190
sudo update-alternatives --install /usr/bin/git-clang-format git-clang-format /usr/bin/git-clang-format-19 190
sudo update-alternatives --install /usr/bin/clang-tblgen clang-tblgen /usr/bin/clang-tblgen-19 190
sudo update-alternatives --install /usr/bin/run-clang-tidy run-clang-tidy /usr/bin/run-clang-tidy-19 190
sudo update-alternatives --install /usr/bin/run-clang-tidy.py run-clang-tidy.py /usr/bin/run-clang-tidy-19.py 190
sudo update-alternatives --install /usr/bin/rust-clang rust-clang /usr/bin/clang-19 190
sudo update-alternatives --install /usr/bin/FileCheck FileCheck /usr/bin/FileCheck-19 190
sudo update-alternatives --install /usr/bin/lld lld /usr/bin/lld-19 190
sudo update-alternatives --install /usr/bin/lldb lldb /usr/bin/lldb-19 190
sudo update-alternatives --install /usr/bin/llvm-addr2line llvm-addr2line /usr/bin/llvm-addr2line-19 190
sudo update-alternatives --install /usr/bin/llvm-ar llvm-ar /usr/bin/llvm-ar-19 190
sudo update-alternatives --install /usr/bin/llvm-as llvm-as /usr/bin/llvm-as-19 190
sudo update-alternatives --install /usr/bin/llvm-bcanalyzer llvm-bcanalyzer /usr/bin/llvm-bcanalyzer-19 190
sudo update-alternatives --install /usr/bin/llvm-bitcode-strip llvm-bitcode-strip /usr/bin/llvm-bitcode-strip-19 190
sudo update-alternatives --install /usr/bin/llvm-cat llvm-cat /usr/bin/llvm-cat-19 190
sudo update-alternatives --install /usr/bin/llvm-cfi-verify llvm-cfi-verify /usr/bin/llvm-cfi-verify-19 190
sudo update-alternatives --install /usr/bin/llvm-config llvm-config /usr/bin/llvm-config-19 190
sudo update-alternatives --install /usr/bin/llvm-cov llvm-cov /usr/bin/llvm-cov-19 190
sudo update-alternatives --install /usr/bin/llvm-c-test llvm-c-test /usr/bin/llvm-c-test-19 190
sudo update-alternatives --install /usr/bin/llvm-cvtres llvm-cvtres /usr/bin/llvm-cvtres-19 190
sudo update-alternatives --install /usr/bin/llvm-cxxdump llvm-cxxdump /usr/bin/llvm-cxxdump-19 190
sudo update-alternatives --install /usr/bin/llvm-cxxfilt llvm-cxxfilt /usr/bin/llvm-cxxfilt-19 190
sudo update-alternatives --install /usr/bin/llvm-cxxmap llvm-cxxmap /usr/bin/llvm-cxxmap-19 190
sudo update-alternatives --install /usr/bin/llvm-debuginfo-analyzer llvm-debuginfo-analyzer /usr/bin/llvm-debuginfo-analyzer-19 190
sudo update-alternatives --install /usr/bin/llvm-debuginfod llvm-debuginfod /usr/bin/llvm-debuginfod-19 190
sudo update-alternatives --install /usr/bin/llvm-debuginfod-find llvm-debuginfod-find /usr/bin/llvm-debuginfod-find-19 190
sudo update-alternatives --install /usr/bin/llvm-diff llvm-diff /usr/bin/llvm-diff-19 190
sudo update-alternatives --install /usr/bin/llvm-dis llvm-dis /usr/bin/llvm-dis-19 190
sudo update-alternatives --install /usr/bin/llvm-dlltool llvm-dlltool /usr/bin/llvm-dlltool-19 190
sudo update-alternatives --install /usr/bin/llvm-dwarfdump llvm-dwarfdump /usr/bin/llvm-dwarfdump-19 190
sudo update-alternatives --install /usr/bin/llvm-dwarfutil llvm-dwarfutil /usr/bin/llvm-dwarfutil-19 190
sudo update-alternatives --install /usr/bin/llvm-dwp llvm-dwp /usr/bin/llvm-dwp-19 190
sudo update-alternatives --install /usr/bin/llvm-exegesis llvm-exegesis /usr/bin/llvm-exegesis-19 190
sudo update-alternatives --install /usr/bin/llvm-extract llvm-extract /usr/bin/llvm-extract-19 190
sudo update-alternatives --install /usr/bin/llvm-gsymutil llvm-gsymutil /usr/bin/llvm-gsymutil-19 190
sudo update-alternatives --install /usr/bin/llvm-ifs llvm-ifs /usr/bin/llvm-ifs-19 190
sudo update-alternatives --install /usr/bin/llvm-install-name-tool llvm-install-name-tool /usr/bin/llvm-install-name-tool-19 190
sudo update-alternatives --install /usr/bin/llvm-jitlink llvm-jitlink /usr/bin/llvm-jitlink-19 190
sudo update-alternatives --install /usr/bin/llvm-jitlink-executor llvm-jitlink-executor /usr/bin/llvm-jitlink-executor-19 190
sudo update-alternatives --install /usr/bin/llvm-lib llvm-lib /usr/bin/llvm-lib-19 190
sudo update-alternatives --install /usr/bin/llvm-libtool-darwin llvm-libtool-darwin /usr/bin/llvm-libtool-darwin-19 190
sudo update-alternatives --install /usr/bin/llvm-link llvm-link /usr/bin/llvm-link-19 190
sudo update-alternatives --install /usr/bin/llvm-lipo llvm-lipo /usr/bin/llvm-lipo-19 190
sudo update-alternatives --install /usr/bin/llvm-lto llvm-lto /usr/bin/llvm-lto-19 190
sudo update-alternatives --install /usr/bin/llvm-lto2 llvm-lto2 /usr/bin/llvm-lto2-19 190
sudo update-alternatives --install /usr/bin/llvm-mc llvm-mc /usr/bin/llvm-mc-19 190
sudo update-alternatives --install /usr/bin/llvm-mca llvm-mca /usr/bin/llvm-mca-19 190
sudo update-alternatives --install /usr/bin/llvm-ml llvm-ml /usr/bin/llvm-ml-19 190
sudo update-alternatives --install /usr/bin/llvm-modextract llvm-modextract /usr/bin/llvm-modextract-19 190
sudo update-alternatives --install /usr/bin/llvm-mt llvm-mt /usr/bin/llvm-mt-19 190
sudo update-alternatives --install /usr/bin/llvm-nm llvm-nm /usr/bin/llvm-nm-19 190
sudo update-alternatives --install /usr/bin/llvm-objcopy llvm-objcopy /usr/bin/llvm-objcopy-19 190
sudo update-alternatives --install /usr/bin/llvm-objdump llvm-objdump /usr/bin/llvm-objdump-19 190
sudo update-alternatives --install /usr/bin/llvm-opt-report llvm-opt-report /usr/bin/llvm-opt-report-19 190
sudo update-alternatives --install /usr/bin/llvm-otool llvm-otool /usr/bin/llvm-otool-19 190
sudo update-alternatives --install /usr/bin/llvm-pdbutil llvm-pdbutil /usr/bin/llvm-pdbutil-19 190
sudo update-alternatives --install /usr/bin/llvm-PerfectShuffle llvm-PerfectShuffle /usr/bin/llvm-PerfectShuffle-19 190
sudo update-alternatives --install /usr/bin/llvm-profdata llvm-profdata /usr/bin/llvm-profdata-19 190
sudo update-alternatives --install /usr/bin/llvm-profgen llvm-profgen /usr/bin/llvm-profgen-19 190
sudo update-alternatives --install /usr/bin/llvm-ranlib llvm-ranlib /usr/bin/llvm-ranlib-19 190
sudo update-alternatives --install /usr/bin/llvm-rc llvm-rc /usr/bin/llvm-rc-19 190
sudo update-alternatives --install /usr/bin/llvm-readelf llvm-readelf /usr/bin/llvm-readelf-19 190
sudo update-alternatives --install /usr/bin/llvm-readobj llvm-readobj /usr/bin/llvm-readobj-19 190
sudo update-alternatives --install /usr/bin/llvm-readtapi llvm-readtapi /usr/bin/llvm-readtapi-19 190
sudo update-alternatives --install /usr/bin/llvm-reduce llvm-reduce /usr/bin/llvm-reduce-19 190
sudo update-alternatives --install /usr/bin/llvm-remarkutil llvm-remarkutil /usr/bin/llvm-remarkutil-19 190
sudo update-alternatives --install /usr/bin/llvm-rtdyld llvm-rtdyld /usr/bin/llvm-rtdyld-19 190
sudo update-alternatives --install /usr/bin/llvm-sim llvm-sim /usr/bin/llvm-sim-19 190
sudo update-alternatives --install /usr/bin/llvm-size llvm-size /usr/bin/llvm-size-19 190
sudo update-alternatives --install /usr/bin/llvm-split llvm-split /usr/bin/llvm-split-19 190
sudo update-alternatives --install /usr/bin/llvm-stress llvm-stress /usr/bin/llvm-stress-19 190
sudo update-alternatives --install /usr/bin/llvm-strings llvm-strings /usr/bin/llvm-strings-19 190
sudo update-alternatives --install /usr/bin/llvm-strip llvm-strip /usr/bin/llvm-strip-19 190
sudo update-alternatives --install /usr/bin/llvm-symbolizer llvm-symbolizer /usr/bin/llvm-symbolizer-19 190
sudo update-alternatives --install /usr/bin/llvm-tblgen llvm-tblgen /usr/bin/llvm-tblgen-19 190
sudo update-alternatives --install /usr/bin/llvm-tli-checker llvm-tli-checker /usr/bin/llvm-tli-checker-19 190
sudo update-alternatives --install /usr/bin/llvm-undname llvm-undname /usr/bin/llvm-undname-19 190
sudo update-alternatives --install /usr/bin/llvm-windres llvm-windres /usr/bin/llvm-windres-19 190
sudo update-alternatives --install /usr/bin/llvm-xray llvm-xray /usr/bin/llvm-xray-19 190
sudo apt install libc++-19-dev libc++abi-19-dev
sudo ln /mnt/c/Program\ Files/Mozilla\ Firefox/firefox.exe /usr/bin/firefox -s
sudo cp ~/Downloads/wsl_shared_folder/configuration_file/wsl.conf /etc # restart your wsl
mkdir -p /home/banana/wsl_shared_folder # also create wsl_shared_folder in D:\Users\11849\Downloads\
sudo cp ~/Downloads/wsl_shared_folder/configuration_file/wsl.conf /etc # restart your wsl
echo 'E:\\Users\11849\Downloads\wsl_shared_folder /home/banana/wsl_shared_folder drvfs defaults,uid=1000,gid=1000,metadata 0 0' | sudo tee -a /etc/fstab > /dev/null
ln -s ~/wsl_shared_folder/cpp_workspace ~
ln -s ~/wsl_shared_folder/from_gcc_to_cpp ~
ln -s ~/wsl_shared_folder/ubuntu18_zsh_configure ~
ln -s ~/wsl_shared_folder/configuration_file ~

echo '[user]' | sudo tee -a /etc/wsl.conf > /dev/null
echo 'default=banana' | sudo tee -a /etc/wsl.conf > /dev/null

# fix an error that gvim cannot use menus
export XDG_DATA_DIRS=$XDG_DATA_DIRS:/usr/share

sudo apt install libanyevent-perl libclass-refresh-perl libcompiler-lexer-perl \
libdata-dump-perl libio-aio-perl libjson-perl libmoose-perl libpadwalker-perl \
libscalar-list-utils-perl libcoro-perl cpanminus perl-doc -y
sudo cpanm --uninstall Perl::LanguageServer
sudo cpanm --uninstall YAML CPAN::DistnameInfo
sudo cpanm --uninstall CPAN
sudo cpanm --uninstall Spreadsheet::ParseExcel Spreadsheet::WriteExcel #for xls
sudo cpanm --uninstall Excel::Writer::XLSX #for xlsx
sudo cpanm --uninstall Neovim::Ext
sudo cpanm --uninstall App::cpanminus
#cpanm --uninstall Spreadsheet::Read Spreadsheet::Write Spreadsheet::XLSX
cpanm --local-lib=~/.local/perl5 AnyEvent Class::Refresh Compiler::Lexer Data::Dump JSON Moose PadWalker Scalar::List::Utils Coro App::cpanminus
cpanm --local-lib=~/.local/perl5 YAML CPAN::DistnameInfo Perl::LanguageServer CPAN Spreadsheet::ParseExcel Spreadsheet::WriteExcel Excel::Writer::XLSX
cpanm --local-lib=~/.local/perl5 Neovim::Ext Class::Refresh Compiler::Lexer Hash::SafeKeys Perl::LanguageServer Syntax::Keyword::Try Future::AsyncAwait

sudo apt install iotop

wget https://packages.microsoft.com/config/debian/12/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
rm packages-microsoft-prod.deb


# compile vim(option):
sudo apt install libgpm-dev python3-dev libluajit-5.1-dev lua5.1 luajit libluajit-5.1-common libxft-dev libgtk-3-dev libmotif-dev libx11-dev libxt-dev ruby-dev libncurses-dev libgettextpo-dev gettext libperl-dev
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
  --with-python3-config-dir=/usr/lib64/python3.11/config-3.11-x86_64-linux-gnu \
  --enable-gpm \
  --with-luajit


sudo apt install libcups2-dev

sudo apt install graphviz gtkwave
sudo npm install -g netlistsvg
sudo apt install -y autoconf gperf make gcc g++ bison flex
sudo apt install build-essential clang lld bison flex \
        libreadline-dev gawk tcl-dev libffi-dev git \
        graphviz xdot pkg-config python3 libboost-system-dev \
        libboost-python-dev libboost-filesystem-dev zlib1g-dev
cd ~
git clone https://github.com/YosysHQ/yosys.git
cd yosys
git submodule update --init --recursive
make
make test
sudo make install

cd ~
git clone https://github.com/steveicarus/iverilog.git
cd iverilog
make
make check
sudo make install
sudo npm install -g @imc-trading/svlangserver
sudo apt install apt-transport-https curl gnupg -y
curl -fsSL https://bazel.build/bazel-release.pub.gpg | gpg --dearmor >bazel-archive-keyring.gpg
sudo mv bazel-archive-keyring.gpg /usr/share/keyrings
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/bazel-archive-keyring.gpg] https://storage.googleapis.com/bazel-apt stable jdk1.8" | sudo tee /etc/apt/sources.list.d/bazel.list
sudo apt update && sudo apt install bazel

cd ~
git clone https://github.com/chipsalliance/verible
cd verible
bazel build -c opt //...
bazel test -c opt //... --test_verbose_timeout_warnings
bazel build -c opt :install-binaries
sudo .github/bin/simple-install.sh /usr/local/bin

sudo apt-get install git help2man perl python3 make autoconf g++ flex bison ccache
sudo apt-get install libgoogle-perftools-dev numactl perl-doc
sudo apt-get install libfl2  # Ubuntu only (ignore if gives error)
sudo apt-get install libfl-dev  # Ubuntu only (ignore if gives error)
sudo apt-get install zlib1g zlib1g-dev  # Ubuntu only (ignore if gives error)
sudo apt-get install ccache  # If present at build, needed for run
sudo apt-get install mold  # If present at build, needed for run
sudo apt-get install libgoogle-perftools-dev numactl
sudo apt install python3-distro libsystemc libsystemc-dev
git clone https://github.com/verilator/verilator   # Only first time
cd verilator
unset VERILATOR_ROOT
autoconf         # Create ./configure script
./configure      # Configure and create Makefile
make -j24
make test
sudo make install

# for a special tool
sudo apt install libncurses5 libncurses5-dev ksh unrar
sudo ln -s /lib64/ld-linux-x86-64.so.2 /lib64/ld-lsb-x86-64.so.3
sudo ldconfig
sudo apt install libxcb-xinerama0 libxcb-xinerama0-dev

sudo cp ~/configuration_file/local.conf /etc/fonts/ # or modify 40-nonlatin.conf, but difficult
sudo apt install shellcheck
pipx install tclint csh
