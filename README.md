Zoe's Dotfiles
===============

A home for my dot files. I use thoughtbot's [rcm](https://github.com/thoughtbot/rcm) to install/update the files

CAUTION
-------
Currently there is an issue with the `zshrc` that will cause your system to go wonky. Like, vim won't work. When prompted to overwrite your `zshrc` the answer is `n` for no.

Install    
-------

Clone down this repo

    git clone git://github.com/peterbsmith2/dotfiles.git ~/.dotfiles

Install [rcm](https://github.com/thoughtbot/rcm) on Mac:

    brew bundle

Install [rcm](https://github.com/thoughtbot/rcm) on Ubuntu:

    sudo add-apt-repository ppa:martin-frost/thoughtbot-rcm
    sudo apt-get update
    sudo apt-get install rcm

Install:

    # install the dotfiles
    rcup -x README.md
    # setup vim vundle
    git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
    vim +BundleInstall +qall

This creates the symlinks for all files stored in .dotfiles

Additional Software (Install these before dotfiles on a fresh install)
------------------

- [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh) OR [prezto](https://github.com/sorin-ionescu/prezto) as a ZSH framework
- [rbenv](https://github.com/sstephenson/rbenv) for the rubies on mac
- [The Silver Searcher](https://github.com/ggreer/the_silver_searcher) fast file search
