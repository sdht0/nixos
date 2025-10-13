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

      valgrind
      gdb

      ruff
      uv

      temurin-bin-21
      nodejs
    ]
  );
}
