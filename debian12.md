sudo apt install -y make cmake valgrind gcc g++
sudo apt install -y vim npm nodejs vim-gtk3
sudo apt install -y clang clangd clang-format clang-tidy
sudo apt install -y zsh bear git curl wget p7zip-full
git config --global user.name "Huaxiao Liang"
git config --global user.email "1184903633@qq.com"
git config --global alias.logline "log --graph --abbrev-commit"
git config --global core.editor gvim
git config --global protocol.https.allow always
git config --global push.default "current"
git config --global diff.tool gvimdiff
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh
sh install.sh
bash -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"
cp ~/Documents/configuration_file/.vimrc ~
cp ~/Documents/configuration_file/.c_cpp ~/.vim -r
cp ~/Documents/configuration_file/coc-settings.json ~/.vim
cp ~/Documents/configuration_file/ys_modified.zsh-theme ~/.oh-my-zsh/custom
sudo reboot
cd ~/Downloads
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/DejaVuSansMono.zip
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/FantasqueSansMono.zip
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/UbuntuMono.zip
x DejaVuSansMono.zip FantasqueSansMono.zip UbuntuMono.zip
sudo mv DejaVuSansMono/ FantasqueSansMono UbuntuMono /usr/share/fonts
cd /usr/share/fonts\
sudo chown root:root DejaVuSansMono FantasqueSansMono UbuntuMono -R
sudo chmod 755 DejaVuSansMono FantasqueSansMono UbuntuMono -R
sudo fc-cache -fv
sudo apt install -y fd-find procs exa zoxide ripgrep bat hyperfine duf httpie
sudo apt install -y cargo
cargo install du-dust bottom procs#not do for root
sudo apt install -y python3 python3-pip pipx
pip install pysnooper ipdb --break-system-packages
pip install pylint yapf futures isort pygments cmake_format vim-vint cmakelang pyright --break-system-packages
pip install cppman you-get sphinx sphinx-rtd-theme --break-system-packages
sudo apt install -y neovim xclip
pip install neovim --break-system-packages
sudo npm install -g neovim
sudo apt install -y opencl-headers ocl-icd-dev
sudo apt install -y clinfo libboost-dev tcl-dev
sudo apt install perl libdb-dev
sudo su
cpan YAML #sudo
cpan Perl::LanguageServer #sudo
cpan install CPAN
cpan App::cpanminus
cpan Spreadsheet::ParseExcel Spreadsheet::WriteExcel #for xls
cpan Excel::Writer::XLSX #for xlsx
#cpanm --uninstall Spreadsheet::Read Spreadsheet::Write Spreadsheet::XLSX
exit
mkdir -p ~/Downloads/debian-program
cd ~/Downloads/debian-program
wget https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64
sudo apt install --fix-broken
