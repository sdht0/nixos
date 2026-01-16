{ pkgs, ... }:
{
  environment.systemPackages = (
    with pkgs;
    [
      nixd
      nixfmt
      nixpkgs-review
    ]
  );
}
