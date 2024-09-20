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
sudo sed -i 's/http/https/g' /etc/apt/sources.list # modify http to https
apt update
# no need mount on disk in wsl2 and install nvidia-driver
ln -s /mnt/d/Users/11849/Documents
ln -s /mnt/d/Users/11849/Videos
ln -s /mnt/d/Users/11849/Downloads
ln -s /mnt/d/Users/11849/Desktop WDesktop
sudo apt install -y make cmake valgrind gcc g++
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
wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh
sh install.sh
bash -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"
cp ~/Documents/configuration_file/ys_modified.zsh-theme ~/.oh-my-zsh/custom
cp ~/Documents/configuration_file/.zshrc ~
rm install.sh
exit
cd ~/Downloads
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/DejaVuSansMono.zip
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/FantasqueSansMono.zip
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/UbuntuMono.zip
x DejaVuSansMono.zip FantasqueSansMono.zip UbuntuMono.zip
sudo mv DejaVuSansMono/ FantasqueSansMono UbuntuMono /usr/share/fonts
cd /usr/share/fonts\
sudo chown root:root DejaVuSansMono FantasqueSansMono UbuntuMono -R
sudo chmod 755 DejaVuSansMono FantasqueSansMono UbuntuMono -R
sudo fc-cache -fv
sudo apt install -y cargo rustc
sudo apt install -y python3 python3-pip pipx
sudo apt install -y neovim xclip
sudo apt install -y fd-find exa zoxide ripgrep bat hyperfine duf httpie
cargo install du-dust@0.8.6 bottom@0.6.3 procs@0.13.0 --locked #not do for root
pipx install ipdb
pipx install pylint
pipx install yapf
pipx install pygments
pipx install cmakelang
pipx install pyright
pipx install cppman
pipx install you-get
pipx install sphinx
pipx install sphinx-rtd-theme --include-deps
pip install pysnooper futures neovim --break-system-packages #not do for root
mkdir ~/.config/nvim -p
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
cp ~/Documents/configuration_file/.vimrc ~
cp ~/Documents/configuration_file/.c_cpp ~/.vim -r
cp ~/Documents/configuration_file/coc-settings.json ~/.vim
ln -s ~/.vimrc ~/.config/nvim/init.vim
sudo npm install -g neovim
sudo apt install -y opencl-headers ocl-icd-dev ocl-icd-opencl-dev pocl-opencl-icd
sudo apt install -y clinfo libboost-all-dev tcl-dev
sudo apt install perl libdb-dev
cd ~
wget https://vscode.download.prss.microsoft.com/dbazure/download/stable/38c31bc77e0dd6ae88a4e9cc93428cc27a56ba40/code_1.93.1-1726079302_amd64.deb
sudo dpkg -i code_*.deb
rm code_*.deb
sudo apt install --fix-broken -y
cd ~
wget https://ftp.gnu.org/gnu/bison/bison-3.3.tar.gz
x bison-3.3.tar.gz
sudo apt install m4
cd bison-3.3
./configure
make
sudo make install
cd ~
sudo rm bison* -r
# Fix an error of ping
sudo setcap cap_net_raw+p /bin/ping
sudo mkdir /usr/share/fonts/win11 # to differentiate self-built font links from system font files
sudo ln -s /mnt/c/Windows/Fonts/* /usr/share/fonts/win11
sudo apt install firefox-esr -y
# if you can't open GUI, add "export DISPLAY=:0" to your .zshrc or .bashrc
sudo apt install dbus-x11 xfce4 xfce4-goodies xrdp flex -y
# 先备份配置
sudo cp /etc/xrdp/xrdp.ini /etc/xrdp/xrdp.ini.backup
# 修改配置文件
## 设置 xrdp 的默认服务端口为 3390，即微软远程桌面协议惹默认端口
sudo sed -i 's/3389/3390/g' /etc/xrdp/xrdp.ini
## 修改 位/像素（bpp）
sudo sed -i 's/max_bpp=32/#max_bpp=32\nmax_bpp=128/g' /etc/xrdp/xrdp.ini
sudo sed -i 's/xserverbpp=24/#xserverbpp=24\nxserverbpp=128/g' /etc/xrdp/xrdp.ini
$ 指定 x windows system 启动使用我们安装的 xfce4
echo xfce4-session > ~/.xsession
# 修改 xrdp 的窗口管理器的启动脚本
sudo vim /etc/xrdp/startwm.sh
## 注释掉最后两行（test 和 exec 开头），并添加
#test -x /etc/X11/Xsession && exec /etc/X11/Xsession
#exec /bin/sh /etc/X11/Xsession
# xfce
startxfce4

sudo /etc/init.d/xrdp start
cp ~/Documents/configuration_file/.gdbinit ~
cp ~/Documents/configuration_file/settings.json ~/.config/Code/User

echo -e "[boot]\nsystemd=true" | sudo tee -a /etc/wsl.conf
cd /usr/lib/wsl
sudo mkdir lib2
sudo ln -s lib/* lib2
sudo sed -i 's/usr\/lib\/wsl\/lib/usr\/lib\/wsl\/lib2/g' /etc/ld.so.conf.d/ld.wsl.conf
echo -e "[automount]\nldconfig=false" | sudo tee -a /etc/wsl.conf

sudo cpan YAML CPAN::DistnameInfo
sudo apt install libanyevent-perl libclass-refresh-perl libcompiler-lexer-perl \
libdata-dump-perl libio-aio-perl libjson-perl libmoose-perl libpadwalker-perl \
libscalar-list-utils-perl libcoro-perl -y
sudo cpan Perl::LanguageServer
sudo cpan install CPAN
sudo cpan App::cpanminus
sudo cpan Spreadsheet::ParseExcel Spreadsheet::WriteExcel #for xls
sudo cpan Excel::Writer::XLSX #for xlsx
#cpanm --uninstall Spreadsheet::Read Spreadsheet::Write Spreadsheet::XLSX

# Do not install libglfw3-wayland; it is an alternative to libglfw3.
sudo apt install libglfw3 libglfw3-dev libglfw3-doc

sudo apt remove neovim --purge -y
sudo apt autoremove --purge -y
wget https://githubfast.com/neovim/neovim-releases/releases/download/v0.10.1/nvim-linux64.deb
sudo dpkg -i nvim-linux64.deb
rm nvim-linux64.deb
sudo apt install python3-neovim -y
sudo cpanm -n Neovim::Ext
sudo apt install ruby-dev -y
sudo gem install neovim

sudo apt purge -y clang* llvm*
sudo apt update
sudo apt autoremove --purge
sudo apt install *clang*16* *llvm*16*
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
