#!/usr/bin/env nix-shell

{
  pkgs ? import <nixpkgs> { },
}:

pkgs.mkShell {
  nativeBuildInputs = with pkgs; [
    pkg-config
    gtest.dev
    # emscripten
  ];

  buildInputs = with pkgs; [
    openssl
    # clang-tools
    # cppcheck
  ];
}
