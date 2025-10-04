{
  config,
  lib,
  pkgs,
  ...
}:
{
  programs.niri.enable = true;
  programs.xwayland.enable = true;
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;

  programs.waybar.enable = true; # top bar
  environment.systemPackages = with pkgs; [
    alacritty # terminal
    xwayland-satellite
    brightnessctl
    cliphist
    dunst
    fuzzel # application launcher
    niriswitcher
    pamixer
    pwvucontrol
    swaybg # wallpaper
    swayidle # idle management
    swaylock-effects
    swww
    wlogout
    swaylock # screen locker
    udiskie
    nautilus
  ];

  services.libinput.enable = true;
}
