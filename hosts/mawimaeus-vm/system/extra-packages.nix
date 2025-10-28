{
  pkgs,
  inputs,
  ...
}:
{
  environment.systemPackages = (
    with pkgs;
    [
      firefox

      obsidian
      activitywatch
      libreoffice-qt6-fresh

      ffmpeg
      vlc

      foliate
      mcomix

      code-cursor
    ]
  );

  programs.gnupg.agent.enable = true;
}
