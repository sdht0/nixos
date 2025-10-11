{
  pkgs,
  ...
}:
{
  my-python.imports = [
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
