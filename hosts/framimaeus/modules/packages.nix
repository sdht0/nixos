{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    rclone
    isync

    gnumake
    cmake
    gcc
  ];
}
