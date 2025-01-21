{
  config,
  pkgs,
  hostData,
  ...
}:
let
  inherit (hostData.users.mainuser) username;
  configDir = "/home/${username}/.config/dotfiles.safe/syncthing";
in
{
  environment.systemPackages = with pkgs; [ syncthing ];
  services.syncthing = {
    enable = true;
    user = username;
    dataDir = "/home/${username}";
    inherit configDir;
  };
  systemd.services.syncthing = {
    unitConfig = {
      ConditionPathExists = configDir;
    };
  };
}
