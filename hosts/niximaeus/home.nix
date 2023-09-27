{ config, pkgs, user, ... }:

{
  home.username = user.username;
  home.homeDirectory = "/home/${user.username}";

  programs.home-manager.enable = true;
  home.stateVersion = "23.05";
}
