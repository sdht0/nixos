{ config, pkgs, ... }:
{
  environment.systemPackages = (with pkgs; [
    nixd nixfmt-rfc-style
    nixpkgs-review
  ]);
}