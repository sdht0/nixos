{ lib, config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    cmake
    awscli2
    teleport
    k9s
    postgresql
  ];

  homebrew = {
    taps = [
      "materializeinc/cockroach"
      "materializeinc/crosstools"
    ];

    brews = [
      "materializeinc/cockroach/cockroach"
      "materializeinc/crosstools/aarch64-unknown-linux-gnu"
    ];

    casks = [
      "slack"
      "zoom"
      "rustrover"
      "docker"
      "1password"
      "headlamp"
    ];
  };
}
