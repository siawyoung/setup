#!/bin/bash
# Simple setup.sh for configuring Ubuntu 12.04 LTS EC2 instance
# for headless setup. 

# Install nvm: node-version manager
# https://github.com/creationix/nvm
sudo apt-get install -y git
sudo apt-get install -y curl
curl https://raw.github.com/creationix/nvm/master/install.sh | sh

# Load nvm and install latest production node
source $HOME/.nvm/nvm.sh
nvm install v0.10
nvm use v0.10

# Install jshint to allow checking of JS code within vim 
# http://jshint.com/
npm install -g jshint

# Install rlwrap to provide libreadline features with node
# See: http://nodejs.org/api/repl.html#repl_repl
sudo apt-get install -y rlwrap

# Install Heroku toolbelt
# https://toolbelt.heroku.com/debian
wget -qO- https://toolbelt.heroku.com/install-ubuntu.sh | sh

# git pull and install dotfiles as well
cd $HOME
if [ -d ./dotfiles/ ]; then
    mv dotfiles dotfiles.old
fi
if [ -d .emacs.d/ ]; then
    mv .emacs.d .emacs.d~
fi
git clone https://github.com/startup-class/dotfiles.git
ln -sb dotfiles/.screenrc .
ln -sb dotfiles/.bash_profile .
ln -sb dotfiles/.bashrc .
ln -sb dotfiles/.bashrc_custom .
ln -sf dotfiles/.emacs.d .

# Also creates a dotfile for jshint and vim
touch dotfiles/.jshintrc
ln -sb dotfiles/.jshintrc .
touch dotfiles/.vimrc
ln -sb dotdiles/.vimrc .


# Installs pathogen, makes it easier to install vim plugins
mkdir -p ~/.vim/autoload ~/.vim/bundle
curl -Sso ~/.vim/autoload/pathogen.vim https://raw.github.com/tpope/vim-pathogen/master/autoload/pathogen.vim

# Sets vim config for pathogen, also sets tab width to 4
echo -e "execute pathogen#infect()\nsyntax on\nfiletype plugin indent on\n:set expandtab tabstop=4 shiftwidth=4" >> .vimrc

# Installa jshint for vim
cd ~/.vim/bundle/jshint2.vim/
git clone https://github.com/Shutnik/jshint2.vim
