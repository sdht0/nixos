{ config, lib, pkgs, ... }:
{
  services.earlyoom.enable = true;
  zramSwap = {
    enable = lib.mkDefault true;
    algorithm = "zstd";
    memoryPercent = 25;
  };
}
