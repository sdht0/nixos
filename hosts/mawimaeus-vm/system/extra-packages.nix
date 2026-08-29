{
  pkgs,
  inputs,
  hostData,
  ...
}:
{
  environment.systemPackages = (
    with pkgs;
    [
      firefox
      chromium

      obsidian
      libreoffice-qt-stable

      ffmpeg
      vlc

      foliate
      mcomix

      vscode
      antigravity-cli

      rustup
      gcc
    ]
  );

  programs.gnupg.agent.enable = true;
}
