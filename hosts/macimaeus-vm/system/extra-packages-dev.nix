{
  pkgs,
  ...
}:
{
  environment.systemPackages = (
    with pkgs;
    [
      code-cursor
      claude-code
      codex

      gnumake
      cmake
      ninja
      gcc
      clang-tools

      perf
      valgrind
      gdb

      rustup
      jetbrains.rust-rover

      ruff
      uv

      temurin-bin-21
      nodejs
    ]
  );
}
