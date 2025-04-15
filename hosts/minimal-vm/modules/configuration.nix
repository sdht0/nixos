{
  config,
  lib,
  pkgs,
  hostData,
  ...
}:
{
  documentation.doc.enable = false;
  nix.enable = false;
  system.switch.enableNg = false;
  system.rebuild.enableNg = false;
  boot.initrd.systemd.enable = false;
  programs.nano.enable = false;
  security.sudo.enable = false;
  programs.command-not-found.enable = false;
  fonts.fontconfig.enable = false;
  services.xserver.enable = false;

  system.switch.enable = true;

  nixpkgs.hostPlatform = hostData.system;
  networking.hostName = hostData.hostname;
  time.timeZone = hostData.timezone;
  i18n.defaultLocale = hostData.locale;

  fileSystems."/" = {
    device = "/dev/disk/by-label/LINUX";
    fsType = "ext4";
  };
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.efiSysMountPoint = lib.mkDefault "/boot";

  system.stateVersion = "24.05";
}
