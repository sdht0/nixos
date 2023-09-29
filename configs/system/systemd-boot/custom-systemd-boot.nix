{ config, lib, pkgs, ... }:
{
  disabledModules = [ "system/boot/loader/systemd-boot/systemd-boot.nix" ];
  imports = [ ./systemd-boot/systemd-boot.nix ];
}
