{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
{
  environment.systemPackages = (
    with pkgs;
    [
      gnumake
      cmake
      gcc
    ]
  );
}
