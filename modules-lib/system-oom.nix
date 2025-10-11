{ lib, ... }:
{
  services.earlyoom.enable = true;

  zramSwap = {
    enable = lib.mkDefault false;
    algorithm = "zstd";
    memoryPercent = 25;
  };
}
