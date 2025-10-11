{ pkgs, ... }:
{
  programs.niri.enable = true;
  programs.xwayland.enable = true;
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;

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
    waybar # top bar
  ];

  services.libinput.enable = true;
}
