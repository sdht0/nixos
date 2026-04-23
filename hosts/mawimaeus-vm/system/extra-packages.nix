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

      rustup
      gcc

      inputs.nixOlde.packages.${hostData.system}.nix-olde
    ]
  );

  programs.gnupg.agent.enable = true;
}
