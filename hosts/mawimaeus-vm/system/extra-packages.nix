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
      antigravity-ide
      antigravity-hub

      rustup
      gcc
    ]
  );

  programs.gnupg.agent.enable = true;
}
