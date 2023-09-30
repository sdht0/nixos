{ config, pkgs, user, ... }:

{
  home.username = user.username;
  home.homeDirectory = "/home/${user.username}";

  home.file.".bashrc".text = ''
    . ~/.dotfiles/bashrc
    [[ -f ~/.dotfiles.safe/bashrc ]] && . ~/.dotfiles.safe/bashrc
    '';

  home.file.".zshrc".text = ''
    . ~/.bashrc
    . ~/.dotfiles/zshrc
    [[ -f ~/.dotfiles.safe/zshrc ]] && . ~/.dotfiles.safe/zshrc
    '';

  home.file.".tmux.conf".source =
    config.lib.file.mkOutOfStoreSymlink  "${config.home.homeDirectory}/.dotfiles/tmux.conf";

  home.file.".vimrc".source =
    config.lib.file.mkOutOfStoreSymlink  "${config.home.homeDirectory}/.dotfiles/vimrc";

  home.file.".gitconfig".source =
    config.lib.file.mkOutOfStoreSymlink  "${config.home.homeDirectory}/.dotfiles/gitconfig";
}
