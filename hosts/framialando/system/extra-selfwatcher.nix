{
  config,
  lib,
  pkgs,
  hostData,
  ...
}:
let
  mainUser = hostData.users.mainuser.username;
  home = "/home/${mainUser}";
in
{
  myPythonPkgs = [
    "pynput"
    "xlib"
  ];

  systemd.services."selfwatcher" = {
    after = [ "display-manager.service" ];
    wantedBy = [ "display-manager.service" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${config.myPythonSet}/bin/python ${home}/.config/dotfiles.safe/scripts/selfwatcher.py";
      User = mainUser;
      Restart = "always";
      RestartSec = 10;
    };
    environment = {
      PATH = lib.mkForce "/run/current-system/sw/bin";
    };
  };
}
