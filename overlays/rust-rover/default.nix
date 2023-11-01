{ config, pkgs, ... }:

(final: prev: {
  rust-rover-latest = prev.jetbrains.rust-rover.overrideAttrs (old: {
    src = pkgs.fetchurl {
      url = "https://download.jetbrains.com/rustrover/RustRover-233.8264.32.tar.gz";
      sha256 = "sha256-UVD8M4WqpRi8L7lzf5Bz2kYLdtE9TAnWtMTZEr84E5s=";
    };
  });
})
