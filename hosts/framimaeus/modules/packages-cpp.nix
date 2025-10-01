{
  config,
  lib,
  pkgs,
  ...
}:
let
  opensslStatic = pkgs.openssl.override { static = true; };
in
{
  imports = [
    ../../../modules-lib/option-nix-ld-include.nix
  ];

  environment.systemPackages = (
    with pkgs;
    [
      jetbrains.clion

      gnumake
      cmake
      ninja
      gcc

      gtest

      clang-tools
      cppcheck
      cpplint
      codechecker

      perf
      valgrind
      gdb
    ]
  );

  programs.nix-ld.libraries = [
    opensslStatic
  ];

  programs.nix-ld-includes = {
    enable = true;
    packages = with pkgs; [
      opensslStatic
      duckdb
    ];
  };

  environment.variables = {
    NUM_THREADS = "10";
  };

  myPythonPkgs = [
    "networkx"
    "pytest"
    "tabulate"
    "pandas"
  ];
}
