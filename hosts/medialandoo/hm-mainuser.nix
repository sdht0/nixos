{ username }:
{
  config,
  lib,
  pkgs,
  ...
}:
let
  lib' = import ../../lib { inherit config lib; };
in
{
  home.username = username;
  home.homeDirectory = "/home/${username}";

  programs.home-manager.enable = true;
  home.stateVersion = "23.05";
}
