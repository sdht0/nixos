{ config, pkgs, mainuser, ... }:

{
  environment.systemPackages = with pkgs; [ syncthing ];
  services.syncthing = {
    enable = true;
    systemService = false;
    user = mainuser.username;
    dataDir = "/home/${mainuser.username}";
  };
}
