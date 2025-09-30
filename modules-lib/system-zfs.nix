{ config, pkgs, ... }:

{
  boot.supportedFilesystems = [ "zfs" ];
  networking.hostId = "3eb4f87f";

  services.sanoid.enable = true;
  services.sanoid.interval = "hourly";
  services.sanoid.datasets.medialand = {
    recursive = true;
    processChildrenOnly = true;
    autoprune = true;
    autosnap = true;
    daily = 7;
    monthly = 5;
    hourly = 2;
  };
}
