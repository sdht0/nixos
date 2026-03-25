{ pkgs, ... }:
{
  services.xserver = {
    enable = true;
    videoDrivers = [ "modesetting" ];
  };
  services.desktopManager.plasma6.enable = true;
  services.desktopManager.plasma6.enableQt5Integration = false;
  services.displayManager.plasma-login-manager.enable = true;

  environment.systemPackages =
    (with pkgs; [
      libnotify
      xclip
      xdotool
      qt6.qtimageformats
    ])
    ++ (with pkgs.kdePackages; [
      yakuake
      plasma-disks
      kgamma
      kconfig
    ]);
  imports = [ ./pkgs-graphics.nix ];
  environment.plasma6.excludePackages = [
    pkgs.kdePackages.kwin-x11
    pkgs.kdePackages.discover
  ];

  services.colord.enable = true;
  services.orca.enable = false;
  programs.kdeconnect.enable = false;
}
