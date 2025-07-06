{ config, pkgs, ... }:
{
  nixpkgs.overlays = [
    (final: prev: {
      yt-dlp = prev.yt-dlp.overrideAttrs (old: {
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

      checksec = pkgs.callPackage ./checksec.nix {};

      jetbrains-clion = prev.jetbrains.clion.overrideAttrs (old: {
        postFixup = ''
          ${old.postFixup}
          patchelf --replace-needed libxml2.so.2 libxml2.so $out/clion/bin/lldb/linux/*/lib/liblldb.so
        '';
      });

      jetbrains-rust-rover = prev.jetbrains.rust-rover.overrideAttrs (old: {
        postFixup = ''
          ${old.postFixup}
          patchelf --replace-needed libxml2.so.2 libxml2.so $out/rust-rover/bin/lldb/linux/*/lib/liblldb.so
        '';
      });

      pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [ (pyfinal: pyprev: {
        xlib = pyprev.xlib.overridePythonAttrs (oldAttrs: {
          patches = [
            # https://github.com/NixOS/nixpkgs/issues/395872
            (pkgs.fetchpatch {
              name = "xlib-fix-randr-error";
              url = "https://github.com/python-xlib/python-xlib/pull/242/commits/52800b1925c0e15a6d97487750db490f064376d8.patch";
              hash = "sha256-uAaVEOX8227BV+qeYG0tf0sByg4LN2BvfapKkogY4UY=";
            })
          ];
        });
      })];
    })
  ];
  # ++ (import ./kde.nix args)
}
