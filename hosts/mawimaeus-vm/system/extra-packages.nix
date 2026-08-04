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
      libreoffice-qt6-fresh

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
