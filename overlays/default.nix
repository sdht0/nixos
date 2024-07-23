{ config, pkgs, ... }@args:
[
  (final: prev: {
    yt-dlp-git = prev.yt-dlp.overrideAttrs (old: {
      name = "yt-dlp_git";
      src = pkgs.fetchFromGitHub {
        owner  = "yt-dlp";
        repo   = "yt-dlp";
        rev    = "f849d77ab54788446b995d256e1ee0894c4fb927";
        hash = "sha256-tfRQUbZYzknDqprYfTEAJrMAdhIeFysEuQnjZyX/QAU=";
      };
      patches = [ ./files/yt-dlp-enhance.patch ];
    });

    solaar = prev.solaar.overrideAttrs (old: {
      postFixup = ''
        ${old.postFixup}
        sed -i 's/Exec=solaar/Exec=solaar --window hide/' $out/share/applications/solaar.desktop
      '';
    });
  })
]
# ++ (import ./kde.nix args)
