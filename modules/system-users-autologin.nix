{ config, pkgs, hostData, ... }:
{
  services.displayManager.autoLogin = {
    enable = true;
    user = hostData.users.mainuser.username;
  };
}
