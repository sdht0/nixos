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

      ruff
      uv

      temurin-bin-21
      nodejs
    ]
  );
}
