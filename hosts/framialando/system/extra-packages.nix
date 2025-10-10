{
  pkgs,
  ...
}:
{
  imports = [
    ../../../modules-lib/pkgs-dev-python.nix
  ];

  environment.systemPackages = (
    with pkgs;
    [
      firefox

      ffmpeg
      vlc
    ]
  );

  programs.gnupg.agent.enable = true;
}
