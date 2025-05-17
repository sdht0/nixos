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
      temurin-bin-21

      poetry

      nodejs

      duckdb

      cloudflared
    ]
  );
}
