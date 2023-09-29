{ config, pkgs, ... }:

{
  imports = [
    ../../configs/system/syncthing.nix
  ];

  environment.systemPackages = with pkgs; [ ];
}
