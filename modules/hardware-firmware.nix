{
  lib,
  config,
  pkgs,
  ...
}:
{
  hardware.enableRedistributableFirmware = true;

  services.fwupd.enable = true;

  environment.systemPackages = with pkgs; [
    linux-firmware
    sof-firmware
  ];
}
