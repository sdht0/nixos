{ config, lib, pkgs, ... }:

{
  imports = [
    ../../configs/packages/common.nix

    ../../configs/packages/letsencrypt.nix
    ../../configs/packages/sshd.nix
    ../../configs/packages/syncthing.nix
    ../../configs/packages/yt-dlp/package.nix
  ];

  environment.systemPackages = with pkgs; [
    nodejs
    (pkgs.python3.withPackages (ps: with ps; [ pip beautifulsoup4 dateutil lxml ]))
  ];
  virtualisation.docker.enable = true;
  programs.npm.enable = true;
}
