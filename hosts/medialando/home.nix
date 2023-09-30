{ config, pkgs, ... }:

{
  imports = [ ../../configs/home/common.nix ];

  programs.home-manager.enable = true;
  home.stateVersion = "23.05";
}
