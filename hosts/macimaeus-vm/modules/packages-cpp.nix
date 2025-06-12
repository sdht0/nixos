{
  config,
  lib,
  pkgs,
  ...
}:
{
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

      config.boot.kernelPackages.perf
      valgrind
      gdb

      duckdb
    ]
  );

  programs.nix-ld.libraries = with pkgs; [
    pkgsStatic.openssl
  ];

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
