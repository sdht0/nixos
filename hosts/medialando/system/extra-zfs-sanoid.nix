{ config, pkgs, ... }:
{
  services.sanoid.enable = true;
  services.sanoid.interval = "hourly";

  services.sanoid.datasets.zroot = {
    recursive = true;
    processChildrenOnly = true;
    autoprune = true;
    autosnap = true;
    monthly = 2;
    daily = 3;
    hourly = 2;
  };

  services.sanoid.datasets.medialand = {
    recursive = true;
    processChildrenOnly = true;
    autoprune = true;
    autosnap = true;
    monthly = 3;
    daily = 7;
    hourly = 2;
  };
}
