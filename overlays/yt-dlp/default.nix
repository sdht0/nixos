{ config, pkgs, ... }:

(final: prev: {
  yt-dlp-git-overlay = prev.yt-dlp.overrideAttrs (old: {
    name = "yt-dlp-git";
    src = pkgs.fetchFromGitHub {
      owner  = "yt-dlp";
      repo   = "yt-dlp";
      rev    = "d63eae7e7ffb1f3e733e552b9e5e82355bfba214";
      sha256 = "sha256-HncTDF+YbRBs8KyL76+fuH6iQuhV4PTNSGH7/fI/RN0=";
    };
    patches = [ ./enhance.patch ];
  });
})
