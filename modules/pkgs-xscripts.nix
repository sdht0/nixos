{ config, pkgs, ... }:
{
  myPythonPkgs = [
    "beautifulsoup4"
    "dateutil"
    "lxml"
  ];

  environment.systemPackages = (
    with pkgs;
    [
      chromium
      yt-dlp
      deno
    ]
  );
}
