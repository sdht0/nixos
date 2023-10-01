{ config, pkgs, ... }:

{
  nixpkgs.overlays = [(final: prev: {
    yt-dlp-git = prev.yt-dlp.overrideAttrs (old: {
      name = "yt-dlp-git-c54ddfba";
      src = pkgs.fetchFromGitHub {
        owner  = "yt-dlp";
        repo   = "yt-dlp";
        rev    = "c54ddfba0f7d68034339426223d75373c5fc86df";
        sha256 = "sha256-zmBHXeNwMYf+6pGBjDmo+vbyVZlBOQDOXsI1xcbTz5Y=";
      };
      patches = [ ./enhance.patch ];
    });
  })];

  environment.systemPackages = with pkgs; [ yt-dlp-git ];
}
