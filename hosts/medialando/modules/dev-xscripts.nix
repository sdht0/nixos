{
  config,
  pkgs,
  pkgs2505,
  ...
}:
{
  myPythonPkgs = [
    "beautifulsoup4"
    "dateutil"
    "lxml"
  ];

  environment.systemPackages = (
    (with pkgs; [
      chromium
      yt-dlp
    ])
    ++ (with pkgs2505; [
      deno
    ])
  );
}
