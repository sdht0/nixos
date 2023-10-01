{ config, pkgs, lib, user, ... }:

let
  lib' = import ../../lib { inherit config lib; };
in
lib.recursiveUpdate {
  home.username = user.username;
  home.homeDirectory = "/home/${user.username}";

  /*
    git clone git@github.com:sdht0/dotfiles.git .dotfiles && \
    cd .dotfiles && \
    git submodule init && \
    git submodule update --recursive --remote
  */

  home.file.".bashrc".text = ''
    . ~/.dotfiles/bashrc
    [[ -f ~/.dotfiles.safe/bashrc ]] && . ~/.dotfiles.safe/bashrc
    '';

  home.file.".zshrc".text = ''
    . ~/.bashrc
    . ~/.dotfiles/zshrc
    [[ -f ~/.dotfiles.safe/zshrc ]] && . ~/.dotfiles.safe/zshrc
    '';
}
(lib'.linkFiles [
  { link = ".tmux.conf";  dest = ".dotfiles/tmux.conf"; }
  { link = ".vimrc";      dest = ".dotfiles/vimrc"; }
  { link = ".gitconfig";  dest = ".dotfiles/gitconfig"; }
])
