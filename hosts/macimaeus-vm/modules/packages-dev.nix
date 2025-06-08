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

      poetry

      nodejs

      duckdb

      cloudflared
    ]
  );
}
