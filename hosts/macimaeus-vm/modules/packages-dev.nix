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
      temurin-bin-21

      claude-code

      nodejs
    ]
  );
}
