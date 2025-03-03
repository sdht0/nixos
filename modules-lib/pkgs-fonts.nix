{ config, pkgs, ... }:
{
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    noto-fonts-cjk-sans
    # noto-fonts # Default in plasma 6
    # noto-fonts-color-emoji # Included in fonts.enableDefaultPackages
  ];
}
