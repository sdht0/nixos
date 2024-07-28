{ lib, config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    chromium yt-dlp nodejs
    (pkgs.python3.withPackages (ps: with ps;
      [ pip beautifulsoup4 dateutil lxml ]) # download.sh
    )
  ];
  programs.npm.enable = true;
}
