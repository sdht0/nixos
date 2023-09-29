{ config, pkgs, ... }:

{
  # Display
  hardware.opengl.enable = true;
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
  # Additional setup for plasma: panels, shortcuts, ssh agent, autostart, wallpapers
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [ xdg-desktop-portal-kde ];
  };

  # Audio
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # Networking
  networking.networkmanager.enable = true;
  networking.firewall.enable = false;
  services.resolved = {
    enable = true;
    dnssec = "false";
    domains = [ "~." ];
    fallbackDns = [ "1.1.1.1#one.one.one.one" "1.0.0.1#one.one.one.one" ];
  };

  # Extra packages
  environment.systemPackages = with pkgs; [
    libnotify xclip
    yakuake konsole kate
    plasma5Packages.ksshaskpass plasma5Packages.kdeconnect-kde plasma5Packages.ffmpegthumbs
    libsForQt5.qt5.qtimageformats
  ];
}
