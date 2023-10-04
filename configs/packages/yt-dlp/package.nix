{ config, pkgs, ... }:

{
  nixpkgs.overlays = [(final: prev: {
    yt-dlp-git = prev.yt-dlp.overrideAttrs (old: {
      name = "yt-dlp-git-cc8d844";
      src = pkgs.fetchFromGitHub {
        owner  = "yt-dlp";
        repo   = "yt-dlp";
        rev    = "cc8d8441524ec3442d7c0d3f8f33f15b66aa06f3";
        sha256 = "sha256-/R5fLzmpywl4ureGS7j/MRd7Y0jGZpJ9dEuXM333kzs=";
      };
      patches = [ ./enhance.patch ];
    });
  })];

  environment.systemPackages = with pkgs; [ yt-dlp-git ];
}
