{ config, pkgs, ... }:

{
  virtualisation.docker = {
    enable = true;
    package = pkgs.docker_26;
    autoPrune.enable = true;
    autoPrune.dates = "daily";
  };
}
