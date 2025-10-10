{
  pkgs,
  ...
}:
{
  imports = [ ./pkgs-common.nix ];

  environment.systemPackages = with pkgs; [
    coreutils
  ];
}
