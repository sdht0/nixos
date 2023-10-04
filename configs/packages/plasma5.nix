{ config, pkgs, ... }:

{
  services.xserver = {
    enable = true;
    videoDrivers = [ "modesetting" ];
  };
  services.xserver.libinput.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;
  services.xserver.displayManager = {
    autoLogin = {
      enable = true;
      user = "artimaeus";
    };
    sddm = {
      enable = true;
      settings = {
        General = {
          DisplayServer = "x11-user";
        };
      };
    };
  };
  environment.plasma5.excludePackages = with pkgs.plasma5Packages; [ elisa oxygen ];
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [ xdg-desktop-portal-kde ];
  };

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
    jack.enable = true;
  };

  environment.systemPackages = with pkgs; [
    libnotify xclip
    yakuake konsole kate kio-fuse
    plasma5Packages.ksshaskpass plasma5Packages.kdeconnect-kde plasma5Packages.ffmpegthumbs
    libsForQt5.qt5.qtimageformats
  ];
}
