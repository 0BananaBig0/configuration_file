sudo dnf groupinstall "Xfce"
sudo dnf install -y make cmake valgrind gcc g++
sudo dnf install -y vim npm nodejs
sudo dnf install -y gvim
sudo dnf install -y vim-X11
sudo dnf install -y clang-tools-extra clang
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
systemctl set-default  graphical.target 
sudo reboot
sudo dnf install -y zsh
sudo dnf install -y bear
sudo dnf install -y git
ssh-keygen -t rsa -C "1184903633@qq.com"
cat ~/.ssh/id_rsa.pub 
cd ~/Documents
git clone git@gitee.com:banana33/configuration_file.git
wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh
sh install.sh
bash -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"
cp ~/Documents/configuration_file/.vimrc ~
cp ~/Documents/configuration_file/.c_cpp ~/.vim -r
cp ~/Documents/configuration_file/coc-settings.json ~/.vim
#cp ~/Documents/configuration_file/.zshrc ~
cp ~/Documents/configuration_file/ys_modified.zsh-theme ~/.oh-my-zsh/custom
sudo dnf install -y sqlite
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
sudo dnf install -y fd-find procs exa zoxide ripgrep bat hyperfine duf httpie
sudo dnf install -y cargo
cargo install du-dust bottom #not do for root
sudo dnf install -y python3 python3-pip
python3 -m pip install pysnooper ipdb
python3 -m pip install pylint yapf futures isort pygments cmake_format vim-vint cmakelang pyright
python3 -m pip install cppman you-get sphinx sphinx-rtd-theme
sudo dnf install -y neovim xclip
python3 -m pip install neovim
sudo npm install -g neovim
sudo dnf install -y p7zip.x86_64 p7zip-plugins.x86_64
sudo dnf install -y opencl-headers.noarch
sudo dnf install ocl-icd-devel ocl-icd.x86_64 -y
sudo dnf install -y clinfo boost-devel tcl-devel
git config --global user.name "Huaxiao Liang"
git config --global user.email "1184903633@qq.com"
git config --global alias.logline "log --graph --abbrev-commit"
git config --global core.editor gvim
git config --global protocol.https.allow always
git config --global push.default "current"
git config --global diff.tool gvimdiff
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
sudo dnf update
sudo dnf install code
sudo dnf install perl cpan libdb
sudo su
cpan YAML #sudo
cpan Perl::LanguageServer #sudo
cpan install CPAN
cpan App::cpanminus
cpan Spreadsheet::ParseExcel Spreadsheet::WriteExcel #for xls
cpan Excel::Writer::XLSX #for xlsx
#cpanm --uninstall Spreadsheet::Read Spreadsheet::Write Spreadsheet::XLSX
exit
