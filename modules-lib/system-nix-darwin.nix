{
  ...
}:
{
  imports = [ ./system-nix-common.nix ];

  nix.gc.automatic = true;
  nix.gc.interval = [
    {
      Hour = 3;
      Minute = 15;
    }
  ];
  nix.gc.options = "--delete-older-than 15d";
}
