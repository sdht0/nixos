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
  ];

  buildInputs = with pkgs; [
    openssl
    duckdb
    gdb
    valgrind
    gdb
    clang-tools
    cppcheck
  ];
}
