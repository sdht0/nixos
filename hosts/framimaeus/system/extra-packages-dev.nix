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

      rustup
      jetbrains.rust-rover

      gnumake
      cmake
      ninja
      gcc
      clang-tools

      valgrind
      gdb

      ruff
      uv

      temurin-bin-21
      nodejs
    ]
  );
}
