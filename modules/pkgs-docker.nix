{ config, pkgs, ... }:
{
  virtualisation.docker = {
    enable = true;
    autoPrune.enable = true;
    autoPrune.dates = "daily";
  };
}
