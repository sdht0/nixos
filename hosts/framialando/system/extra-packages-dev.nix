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
      code-cursor
      claude-code
      codex

      temurin-bin-21
      nodejs
    ]
  );
}
