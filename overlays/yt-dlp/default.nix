{ config, pkgs, ... }:

(final: prev: {
  yt-dlp-git-overlay = prev.yt-dlp.overrideAttrs (old: {
    name = "yt-dlp-git";
    src = pkgs.fetchFromGitHub {
      owner  = "yt-dlp";
      repo   = "yt-dlp";
      rev    = "a174c453ee1e853c584ceadeac17eef2bd433dc5";
      sha256 = "sha256-OErBcvaFifm074vRenHl5q5ScVRO7bcNM/xtEJ34ddM=";
    };
    patches = [ ./enhance.patch ];
  });
})
