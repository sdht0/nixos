{ config, pkgs, ... }:
{
  fonts.packages = with pkgs; [
    jetbrains-mono
    meslo-lgs-nf
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
  ];
}
