{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.programs.nix-ld-includes;

  nix-ld-includes = pkgs.buildEnv {
    name = "ld-include-path";
    pathsToLink = [ "/include" ];
    paths = map lib.getDev cfg.packages;
    extraPrefix = "/share/nix-ld-includes";
    ignoreCollisions = true;
  };
in
{
  options.programs.nix-ld-includes = {
    enable = lib.mkEnableOption ''nix-ld-includes'';
    packages = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      description = "Packages whose /include is made available.";
      default = [ ];
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ nix-ld-includes ];

    environment.pathsToLink = [ "/share/nix-ld-includes" ];

    environment.sessionVariables = {
      CMAKE_LIBRARY_PATH = "/run/current-system/sw/share/nix-ld/lib";
      CMAKE_INCLUDE_PATH = "/run/current-system/sw/share/nix-ld-includes/include";
      NIX_CFLAGS_COMPILE = "-isystem /run/current-system/sw/share/nix-ld-includes/include";
    };

    programs.nix-ld-includes.packages = with pkgs; [
      zlib
      stdenv.cc.cc
      stdenv.cc.libc
      openssl
    ];
  };
}
