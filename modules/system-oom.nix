{ config, pkgs, ... }:
{
  services.earlyoom.enable = true;
  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 25;
  };
}
