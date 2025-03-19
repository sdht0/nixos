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

      clang-tools
      cppcheck
      cpplint
      codechecker

      gnumake
      cmake
      gcc

      config.boot.kernelPackages.perf
      valgrind
      gdb
    ]
  );
  myPythonPkgs = [
    "networkx"
  ];
}
