apt install nodejs
apt install npm
apt install python
apt install pip

pip install --upgrade pynvim
npm i -g yarn

curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
mv nvim.appimage /usr/local/bin/nv

sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

nv init.vim
read -p "Run :PlugInstall then press [Enter] to continue"

cd plugged/coc.nvim && yarn install
