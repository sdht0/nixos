# import all nix files in the current folder, and execute them with args as parameters
# The return value is a list of all execution results, which is the list of overlays

{ config, pkgs, ... }@args:

(builtins.map
  (f: (import (./. + "/${f}") args))
  (builtins.filter
    (f: f != "default.nix") # Don't include this file itself
    (builtins.attrNames (builtins.readDir ./.)))
) ++ [
  (final: prev: {
    rust-rover-overlay = prev.jetbrains.rust-rover.overrideAttrs (old: {
      src = pkgs.fetchurl {
        url = "https://download.jetbrains.com/rustrover/RustRover-233.11799.306.tar.gz";
        sha256 = "59cd5fac710b153efab94341594751bb50cdb1dff5d2292bb8067ec87085ad35";
      };
      buildInputs = old.buildInputs ++ [prev.xorg.libX11 prev.libGL prev.fontconfig];
    });
  })
  (final: prev: {
    obsidian-overlay = prev.obsidian.overrideAttrs (old: {
      version = "1.5.3";
      src = pkgs.fetchurl {
        url = "https://github.com/obsidianmd/obsidian-releases/releases/download/v1.5.3/obsidian-1.5.3.tar.gz";
        hash = "sha256-F7nqWOeBGGSmSVNTpcx3lHRejSjNeM2BBqS9tsasTvg=";
      };
    });
  })
  (final: prev: {
    solaar-overlay = prev.solaar.overrideAttrs (old: {
      postFixup = ''
        ${old.postFixup}
        sed -i 's/Exec=solaar/Exec=solaar --window hide/' $out/share/applications/solaar.desktop
      '';
    });
  })
]
