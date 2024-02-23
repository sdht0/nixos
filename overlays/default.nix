# import all nix files in the current folder, and execute them with args as parameters
# The return value is a list of all execution results, which is the list of overlays

{ config, pkgs, ... }:
[
  (final: prev: {
    yt-dlp-git = prev.yt-dlp.overrideAttrs (old: {
      name = "overlay-yt-dlp-git";
      src = pkgs.fetchFromGitHub {
        owner  = "yt-dlp";
        repo   = "yt-dlp";
        rev    = "d63eae7e7ffb1f3e733e552b9e5e82355bfba214";
        sha256 = "sha256-HncTDF+YbRBs8KyL76+fuH6iQuhV4PTNSGH7/fI/RN0=";
      };
      patches = [ ./files/yt-dlp-enhance.patch ];
    });
  })
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
  (final: prev: {
    obsidian = (prev.obsidian.override {
        electron = pkgs.electron_28;
      }).overrideAttrs (old: rec {
        version = "1.5.8";
        name = "overlay-${old.pname}-${version}";
        src = pkgs.fetchurl {
          url = "https://github.com/obsidianmd/obsidian-releases/releases/download/v${version}/obsidian-${version}.tar.gz";
          hash = "sha256-oc2iA2E3ac/uUNv6unzfac5meHqQzmzDVl/M9jNpS/M=";
        };
    });
  })
]
