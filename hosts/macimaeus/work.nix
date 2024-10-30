{ lib, config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    cmake
    postgresql
  ];

  homebrew = {
    taps = [
      "materializeinc/cockroach"
      # "materializeinc/crosstools"
    ];

    brews = [
      "materializeinc/cockroach/cockroach"
      # "materializeinc/crosstools/aarch64-unknown-linux-gnu"
    ];
  };
}
