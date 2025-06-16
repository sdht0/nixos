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
      vscode
      jetbrains.pycharm-community-bin

      claude-code
      code-cursor

      temurin-bin-21
      nodejs
    ]
  );
}
