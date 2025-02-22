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
      rustup
      temurin-bin-21

      duckdb
    ]
  );
}
