{ config, pkgs, ... }:

(final: prev: {
  yt-dlp-git = prev.yt-dlp.overrideAttrs (old: {
    name = "yt-dlp-git-21dc06";
    src = pkgs.fetchFromGitHub {
      owner  = "yt-dlp";
      repo   = "yt-dlp";
      rev    = "21dc069bea2d4d99345dd969e098f4535c751d45";
      sha256 = "sha256-ZvMvDi+Wolh61yyvZEvhJYtYC0Q5neeAchFMpuZqnws=";
    };
    patches = [ ./enhance.patch ];
  });
})
