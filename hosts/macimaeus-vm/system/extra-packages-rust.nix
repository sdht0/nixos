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
      rustup
      jetbrains.rust-rover
    ]
  );
}
