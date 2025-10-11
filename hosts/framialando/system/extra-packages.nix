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

      ffmpeg
      vlc

      foliate

      inputs.nixOlde.packages.${system}.nix-olde
    ]
  );

  programs.gnupg.agent.enable = true;
}
