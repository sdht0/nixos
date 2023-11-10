{ config, pkgs, ... }:

(final: prev: {
  rust-rover-latest = prev.jetbrains.rust-rover.overrideAttrs (old: {
    src = pkgs.fetchurl {
      url = "https://download.jetbrains.com/rustrover/RustRover-233.10527.39.tar.gz";
      sha256 = "sha256-8B7+SM7+cOhjqXsjW6oLY6d/GtHeJ0ye5b+gONoQtJw=";
    };
  });
})
