{ config, pkgs, ... }:
{
  boot.plymouth.enable = true;
  boot.plymouth.theme = "breeze";
  boot.plymouth.themePackages = [
    (pkgs.kdePackages.breeze-plymouth.override {
      logoFile = config.boot.plymouth.logo;
      logoName = "nixos";
      osName = "NixOS";
    })
  ];
}
