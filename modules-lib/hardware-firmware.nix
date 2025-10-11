{
  lib,
  config,
  pkgs,
  ...
}:
{
  hardware.enableRedistributableFirmware = true;

  environment.systemPackages = with pkgs; [
    linux-firmware
    sof-firmware
  ];

  services.fwupd.enable = true;
}
