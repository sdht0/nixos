{ config, pkgs, ... }@args:
[
  (final: prev: {
    yt-dlp-git = prev.yt-dlp.overrideAttrs (old: {
      name = "overlay-yt-dlp-git";
      src = pkgs.fetchFromGitHub {
        owner  = "yt-dlp";
        repo   = "yt-dlp";
        rev    = "f849d77ab54788446b995d256e1ee0894c4fb927";
        hash = "sha256-tfRQUbZYzknDqprYfTEAJrMAdhIeFysEuQnjZyX/QAU=";
      };
      patches = [ ./files/yt-dlp-enhance.patch ];
    });

    solaar = prev.solaar.overrideAttrs (old: {
      name = "overlay-${old.pname}-${old.version}";
      postFixup = ''
        ${old.postFixup}
        sed -i 's/Exec=solaar/Exec=solaar --window hide/' $out/share/applications/solaar.desktop
      '';
    });

    fprintd = prev.fprintd.overrideAttrs (_: {
      mesonCheckFlags = [
        "--no-suite" "fprintd:TestPamFprintd"
      ];
    });

    difftastic = pkgs.callPackage ./difft.nix { };
  })
]
++ (import ./kde.nix args)
