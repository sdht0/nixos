{ config, pkgs, ... }:

(final: prev: {
  rust-rover-overlay = prev.jetbrains.rust-rover.overrideAttrs (old: {
    src = pkgs.fetchurl {
      url = "https://download.jetbrains.com/rustrover/RustRover-233.10527.212.tar.gz";
      sha256 = "8f523786bcfb0f112d1112c7c65f2fbda0112952357c931f215b628530c550cf";
    };
  });
})
