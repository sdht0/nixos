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
        url = "https://download.jetbrains.com/rustrover/RustRover-233.10527.212.tar.gz";
        sha256 = "8f523786bcfb0f112d1112c7c65f2fbda0112952357c931f215b628530c550cf";
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
