{ config, user, ... }:

{
  home.username = user.username;
  home.homeDirectory = "/home/${user.username}";

  imports = [ ../../configs/home/common.nix ];

  home.file.".ssh/config".source =
    config.lib.file.mkOutOfStoreSymlink  "${config.home.homeDirectory}/.dotfiles.safe/ssh/config";

  home.file.".ssh/id_ed25519".source =
    config.lib.file.mkOutOfStoreSymlink  "${config.home.homeDirectory}/.dotfiles.safe/ssh/id_ed25519";

  home.file.".ssh/id_ed25519.pub".source =
    config.lib.file.mkOutOfStoreSymlink  "${config.home.homeDirectory}/.dotfiles.safe/ssh/id_ed25519.pub";

  home.file.".config/plasma-workspace/env/ssh-agent.sh".source =
    config.lib.file.mkOutOfStoreSymlink  "${config.home.homeDirectory}/.dotfiles/ssh_agent/ssh-agent.sh";

  home.file.".config/autostart/ssh-add.sh.desktop".source =
    config.lib.file.mkOutOfStoreSymlink  "${config.home.homeDirectory}/.dotfiles.safe/apps/ssh-add.sh.desktop";

  home.file.".local/share/applications/ff2.desktop".source =
    config.lib.file.mkOutOfStoreSymlink  "${config.home.homeDirectory}/.dotfiles.safe/apps/ff2.desktop";

  home.file.".local/share/applications/ff2nix.desktop".source =
    config.lib.file.mkOutOfStoreSymlink  "${config.home.homeDirectory}/.dotfiles.safe/apps/ff2nix.desktop";

  programs.home-manager.enable = true;
  home.stateVersion = "23.05";
}
