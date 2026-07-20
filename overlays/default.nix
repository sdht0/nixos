{ config, pkgs, ... }:
{
  nixpkgs.overlays = [
    (final: prev: {
      yt-dlp = prev.yt-dlp.overrideAttrs (old: {
        patches = [ ./files/yt-dlp-enhance.patch ];
      });
    })
  ];
  # ++ (import ./kde.nix args)
}
