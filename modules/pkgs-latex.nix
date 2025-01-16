{ config, pkgs, ... }:
{
  environment.systemPackages = (
    with pkgs;
    [
      bibtool
      texliveFull
    ]
  );
}
