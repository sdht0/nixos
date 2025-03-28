{ config, pkgs, ... }:
{
  nixpkgs.overlays = [
    (final: prev: {
      yt-dlp = prev.yt-dlp.overrideAttrs (old: {
        # name = "yt-dlp_git";
        # src = pkgs.fetchFromGitHub {
        #   owner  = "yt-dlp";
        #   repo   = "yt-dlp";
        #   rev    = "f849d77ab54788446b995d256e1ee0894c4fb927";
        #   hash = "sha256-tfRQUbZYzknDqprYfTEAJrMAdhIeFysEuQnjZyX/QAU=";
        # };
        patches = [ ./files/yt-dlp-enhance.patch ];
      });

      solaar = prev.solaar.overrideAttrs (old: {
        postFixup = ''
          ${old.postFixup}
          sed -i 's/Exec=solaar/Exec=solaar --window hide/' $out/share/applications/solaar.desktop
        '';
      });

      obsidian = prev.obsidian.override (old: {
        electron = pkgs.electron-bin;
      });

      eza = prev.eza.overrideAttrs (old: {
        patches = old.patches ++ [ ./files/eza.patch ];
      });
    })
  ];
  # ++ (import ./kde.nix args)
}
