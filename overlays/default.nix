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
        url = "https://download.jetbrains.com/rustrover/RustRover-233.13135.127.tar.gz";
        sha256 = "8d3e95f563641c20109ddd7572382663202c048a49b3ee0880cf4f69457d7f29";
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
