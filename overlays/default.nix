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
        url = "https://download.jetbrains.com/rustrover/RustRover-233.13135.116.tar.gz";
        sha256 = "b2e6f76b9eb1d7d68a0ac874954aa394be1426e07a767bdebf1a421021764c0a";
      };
      buildInputs = old.buildInputs ++ [prev.xorg.libX11 prev.libGL prev.fontconfig];
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
