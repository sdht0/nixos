{ config, pkgs, ... }:
[
  (final: prev: {
    yt-dlp-git = prev.yt-dlp.overrideAttrs (old: {
      name = "overlay-yt-dlp-git";
      src = pkgs.fetchFromGitHub {
        owner  = "yt-dlp";
        repo   = "yt-dlp";
        rev    = "d63eae7e7ffb1f3e733e552b9e5e82355bfba214";
        sha256 = "sha256-HncTDF+YbRBs8KyL76+fuH6iQuhV4PTNSGH7/fI/RN0=";
      };
      patches = [ ./files/yt-dlp-enhance.patch ];
    });
  })
  (final: prev: {
    solaar = prev.solaar.overrideAttrs (old: {
      name = "overlay-${old.pname}-${old.version}";
      postFixup = ''
        ${old.postFixup}
        sed -i 's/Exec=solaar/Exec=solaar --window hide/' $out/share/applications/solaar.desktop
      '';
    });
  })
]
