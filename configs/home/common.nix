{ config, pkgs, user, ... }:

{
  home.file.".bashrc".source =
    config.lib.file.mkOutOfStoreSymlink  "${config.home.homeDirectory}/.dotfiles.safe/.bashrc";

  home.file.".zshrc".source =
    config.lib.file.mkOutOfStoreSymlink  "${config.home.homeDirectory}/.dotfiles.safe/.zshrc";

  home.file.".tmux.conf".source =
    config.lib.file.mkOutOfStoreSymlink  "${config.home.homeDirectory}/.dotfiles/tmux.conf";

  home.file.".vimrc".source =
    config.lib.file.mkOutOfStoreSymlink  "${config.home.homeDirectory}/.dotfiles/vimrc";

  home.file.".gitconfig".source =
    config.lib.file.mkOutOfStoreSymlink  "${config.home.homeDirectory}/.dotfiles/gitconfig";
}
