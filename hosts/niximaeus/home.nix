{ config, pkgs, user, ... }:

{
  home.username = user.username;
  home.homeDirectory = "/home/${user.username}";

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

  home.file.".ssh/config".source =
    config.lib.file.mkOutOfStoreSymlink  "${config.home.homeDirectory}/.dotfiles.safe/ssh/config";

  home.file.".ssh/id_ed25519".source =
    config.lib.file.mkOutOfStoreSymlink  "${config.home.homeDirectory}/.dotfiles.safe/ssh/id_ed25519";

  home.file.".ssh/id_ed25519.pub".source =
    config.lib.file.mkOutOfStoreSymlink  "${config.home.homeDirectory}/.dotfiles.safe/ssh/id_ed25519.pub";

  programs.home-manager.enable = true;
  home.stateVersion = "23.05";
}
