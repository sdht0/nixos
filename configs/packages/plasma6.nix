{ config, pkgs, ... }:

{
  services.xserver = {
    enable = true;
    videoDrivers = [ "modesetting" ];
  };
  services.desktopManager.plasma6.enable = true;
  services.desktopManager.plasma6.enableQt5Integration = false;
  services.xserver.displayManager = {
    defaultSession = "plasmax11";
    sddm = {
      enable = true;
      settings = {
        General = {
          DisplayServer = "x11-user"; # Rootless xorg
        };
      };
    };
  };

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
    jack.enable = true;
  };

  services.colord.enable = true;

  environment.systemPackages = (with pkgs; [
    libnotify xclip xdotool
    vulkan-tools vulkan-validation-layers glxinfo
    qt6.qtimageformats
  ]) ++ (with pkgs.kdePackages; [
    yakuake plasma-disks kgamma
  ]);
  programs.kdeconnect.enable = true;
}
