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
    rust-rover = prev.jetbrains.rust-rover.overrideAttrs (old: {
      name = "overlay-${old.pname}-${old.version}";
      src = pkgs.fetchurl {
        url = "https://download.jetbrains.com/rustrover/RustRover-233.14015.147.tar.gz";
        sha256 = "356c0d491045097f1b7fc82368d1b34c8025edc029a004c7dad47746834df083";
      };
      buildInputs = old.buildInputs ++ [prev.xorg.libX11 prev.libGL prev.fontconfig];
      postPatch = builtins.replaceStrings ["patch"] ["true #patch"] old.postPatch;
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
