{ pkgs, ... }:
{
  hardware.enableRedistributableFirmware = true;

  environment.systemPackages = with pkgs; [
    linux-firmware
    sof-firmware
    efibootmgr
  ];

  services.fwupd.enable = true;
}
