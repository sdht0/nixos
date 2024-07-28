{ config, pkgs, ... }:
{
  services.earlyoom.enable = true;
  zramSwap.enable = true;
  zramSwap.memoryPercent = 25;
}
