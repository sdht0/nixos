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
      # activitywatch
      libreoffice-qt6-fresh

      ffmpeg
      vlc

      foliate
      # mcomix

      code-cursor
      antigravity
    ]
  );

  programs.gnupg.agent.enable = true;
}
