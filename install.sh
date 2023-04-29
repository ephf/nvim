apt install nodejs -y
apt install npm -y
apt install python -y
apt install pip -y
apt install fuse -y
apt install vim-gtk -y

pip install --upgrade pynvim
npm i -g yarn
npm i -g node

curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
mv nvim.appimage /usr/local/bin/nv

sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

nv init.vim
cd plugged/coc.nvim && yarn install
