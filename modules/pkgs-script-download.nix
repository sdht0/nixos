{ lib, config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    chromium yt-dlp deno
    (pkgs.python3.withPackages (ps: with ps;
      [ pip beautifulsoup4 dateutil lxml ])
    )
  ];
}
