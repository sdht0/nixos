{ lib, config, testuser2, ... }:

{
  home.username = testuser2.username;
  home.homeDirectory = "/home/${testuser2.username}";

  imports = [ ../../configs/home/common.nix ];

  programs.home-manager.enable = true;
  home.stateVersion = "23.05";
}
