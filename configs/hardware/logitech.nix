{ config, pkgs, ... }:

{
  hardware.logitech.wireless.enable = true;
  environment.systemPackages = with pkgs; [ solaar ];
}
