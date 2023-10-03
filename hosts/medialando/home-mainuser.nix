{ username }:
{ config, lib, pkgs, ... }:
{
  home.username = username;
  home.homeDirectory = "/home/${username}";

  imports = [ ../../configs/home/common.nix ];

  programs.home-manager.enable = true;
  home.stateVersion = "23.05";
}
