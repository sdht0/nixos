#!/usr/bin/env nix-shell

{
  pkgs ? import <nixpkgs> { },
}:

pkgs.mkShell {
  nativeBuildInputs = with pkgs; [
    nodejs
    gnumake
    cmake
    gcc
    emscripten
    pkg-config
    clang
  ];

  buildInputs = with pkgs; [
    pkgsStatic.openssl
    duckdb
    gdb
    valgrind
    gdb
  ];

  shellHook = ''
    exec zsh
  '';
}

# (pkgs.buildFHSEnv {
#   name = "FHS";
#   targetPkgs =
#     pkgs:
#     (with pkgs; [
#       nodejs
#       cmake
#       gcc
#       emscripten
#       pkg-config
#       clang
#       pkgsStatic.openssl
#       duckdb
#       gdb
#     ]);
#   runScript = "zsh";
#   extraOutputsToInstall = [ "dev" ];
# }).env
