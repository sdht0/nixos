{ lib, config, testuser, ... }:

{
  home.username = testuser.username;
  home.homeDirectory = "/home/${testuser.username}";

  imports = [ ../../configs/home/common.nix ];

  programs.home-manager.enable = true;
  home.stateVersion = "23.05";
}
