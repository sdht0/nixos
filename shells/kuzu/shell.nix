#!/usr/bin/env nix-shell

{
  pkgs ? import <nixpkgs> { },
}:

pkgs.mkShell {
  nativeBuildInputs = with pkgs; [
    nodejs
    cmake
    gcc
    emscripten
    pkg-config
    clang
  ];

  buildInputs = with pkgs; [
    pkgsStatic.openssl
    duckdb
  ];

  shellHook = ''
    exec zsh
  '';
}

# (
#   let base = pkgs.appimageTools.defaultFhsEnvArgs; in
#   pkgs.buildFHSEnv (base // {
#     name = "FHS";
#     targetPkgs = pkgs: (with pkgs; [
#       gcc openssl cmake emscripten nodejs_23 pkg-config
#     ]);
#     nativeBuildInputs =with pkgs; [  stdenv.cc.cc.lib ];
#     runScript = "zsh";
#     extraOutputsToInstall = [ "dev" ];
#     profile = ''
#       export CMAKE_LIBRARY_PATH="${pkgs.glibc.dev}/lib"
#     '';
#   })
# ).env
