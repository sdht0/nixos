{ pkgs, ... }:
{
  services.xserver = {
    enable = true;
    videoDrivers = [ "modesetting" ];
  };
  services.desktopManager.plasma6.enable = true;
  services.desktopManager.plasma6.enableQt5Integration = false;
  services.displayManager.plasma-login-manager.enable = true;

  services.colord.enable = true;
  services.orca.enable = false;

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
  programs.kdeconnect.enable = true;
}
