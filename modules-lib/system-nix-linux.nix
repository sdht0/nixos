{
  hostData,
  ...
}:
{
  imports = [
    ./system-nix-common.nix
    ./system-nix-command-not-found.nix
  ];

  systemd.services.nix-daemon.environment.TMPDIR = "/var/tmp/nix-daemon";

  system.rebuild.enableNg = true;

  nix.gc.automatic = true;
  nix.gc.dates = "daily";
  nix.gc.options = "--delete-older-than 15d";

  systemd.tmpfiles.rules = [
    "d /var/log/nixos 0700 ${hostData.users.mainuser.username} ${hostData.users.mainuser.username} -"
  ];
}
