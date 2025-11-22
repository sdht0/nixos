{
  pkgs,
  ...
}:
{
  my-python.imports = [
    "beautifulsoup4"
    "python-dateutil"
    "lxml"
    "requests"
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
