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

      obsidian
      activitywatch
      libreoffice-qt6-fresh

      ffmpeg
      vlc

      foliate
      mcomix

      code-cursor

      rustup

      inputs.nixOlde.packages.${hostData.system}.nix-olde
    ]
  );

  programs.gnupg.agent.enable = true;
}
