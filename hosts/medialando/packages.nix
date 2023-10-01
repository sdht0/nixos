{ config, pkgs, user, ... }:

{
  imports = [
    ../../configs/packages/common.nix

    ../../configs/packages/letsencrypt.nix
    ../../configs/packages/sshd.nix
    ../../configs/packages/syncthing.nix
    ../../configs/packages/yt-dlp/package.nix
  ];

  environment.systemPackages = with pkgs; [ nodejs ];
  virtualisation.docker.enable = true;
  programs.npm.enable = true;
}
