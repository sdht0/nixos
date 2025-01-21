{
  config,
  pkgs,
  hostData,
  ...
}:
let
  inherit (hostData.users.mainuser) username;
in
{
  environment.systemPackages = with pkgs; [ syncthing ];
  services.syncthing = {
    enable = true;
    user = username;
    dataDir = "/home/${username}";
    configDir = "/home/${username}/.config/dotfiles.safe/syncthing";
  };
}
