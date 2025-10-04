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
    alacritty
    fuzzel
    swaylock
    mako
    swayidle
  ];

  services.libinput.enable = true;
  services.pipewire.enable = true;
}
