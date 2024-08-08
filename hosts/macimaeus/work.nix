{ lib, config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    cmake
    awscli2
    teleport
    k9s
  ];
}
