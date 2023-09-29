{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.programs.man;
in

{
  disabledModules = [ "system/boot/loader/systemd-boot/systemd-boot.nix" ];

  imports = [ ./systemd-boot/systemd-boot.nix ];
}
