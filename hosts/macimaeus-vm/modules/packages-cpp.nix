{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ../../../modules-lib/option-nix-ld-include.nix
  ];

  environment.systemPackages = (
    with pkgs;
    [
      (jetbrains.clion.overrideAttrs  (old: {
        postFixup = ''
          ${old.postFixup}
          patchelf --replace-needed libxml2.so.2 libxml2.so $out/clion/bin/lldb/linux/*/lib/liblldb.so
        '';
      }))

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
      meilisearch
      qdrant
    ]
  );

  programs.nix-ld.libraries = with pkgs; [
    pkgsStatic.openssl
  ];

  programs.nix-ld-includes = {
    enable = true;
    packages = with pkgs; [
      pkgsStatic.openssl
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
