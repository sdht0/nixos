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

      inputs.nixOlde.packages.${system}.nix-olde
    ]
  );

  programs.gnupg.agent.enable = true;
}
