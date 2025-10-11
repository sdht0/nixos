{ lib, ... }:
{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.efiSysMountPoint = lib.mkDefault "/boot";

  boot.loader.systemd-boot.configurationLimit = 10;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.consoleMode = "max";
  boot.loader.timeout = 0;
}
