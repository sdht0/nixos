#!/usr/bin/env nix-shell

{
  pkgs ? import <nixpkgs> { },
}:

pkgs.mkShell {
  nativeBuildInputs = with pkgs; [
    # nodejs
    # emscripten
    pkg-config
  ];

  buildInputs = with pkgs; [
    openssl
    # clang-tools
    # cppcheck
  ];
}
