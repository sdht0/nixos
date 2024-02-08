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
        url = "https://download.jetbrains.com/rustrover/RustRover-233.14015.147.tar.gz";
        sha256 = "356c0d491045097f1b7fc82368d1b34c8025edc029a004c7dad47746834df083";
      };
      buildInputs = old.buildInputs ++ [prev.xorg.libX11 prev.libGL prev.fontconfig];
      postPatch = builtins.replaceStrings ["patch"] ["true #patch"] old.postPatch;
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
  (final: prev: {
    mcomix-overlay = prev.mcomix.overrideAttrs (old: rec {
      version = "3.1.0";
      src = pkgs.fetchurl {
        url = "mirror://sourceforge/mcomix/mcomix-${version}.tar.gz";
        hash = "sha256-+Shuun/7w86VKBNamTmCPEJfO76fdKY5+HBvzCi0xCc=";
      };
      postInstall = ''
        cp -a share $out/
      '';
    });
  })
]
