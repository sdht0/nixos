{ config, pkgs, user, ... }:

{
  environment.systemPackages = with pkgs; [ syncthing ];
  services.syncthing = {
    enable = true;
    systemService = false;
    user = user.username;
    dataDir = "/home/${user.username}";
  };
}
