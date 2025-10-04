{
  config,
  lib,
  pkgs,
  ...
}:
{
  programs.niri.enable = true;
  programs.xwayland.enable = true;

  programs.waybar.enable = true; # top bar
  environment.systemPackages = with pkgs; [
    alacritty # terminal
    fuzzel # application launcher
    mako # notifications
    swaylock # screen locker
    swayidle # idle management
    swaybg # wallpaper
    xwayland-satellite
  ];

  services.libinput.enable = true;
  services.pipewire.enable = true;
}
