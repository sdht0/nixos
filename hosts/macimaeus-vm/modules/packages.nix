{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
{
  environment.systemPackages = (
    with pkgs;
    [
      firefox
      (chromium.override {
        enableWideVine = false;
        # commandLineArgs = [
        #   "--enable-features=VaapiVideoEncoder,VaapiVideoDecodeLinuxGL"
        #   "--ignore-gpu-blocklist"
        #   "--enable-zero-copy"
        # ];
      })

      libreoffice-qt-fresh
      obsidian
      activitywatch

      ffmpeg
      vlc

      mcomix
      foliate

      inputs.nixOlde.packages.${system}.nix-olde

      vscode
      rustup
      temurin-bin-21

      jetbrains.clion

      # thunderbird
      # zoom-us slack
      # jetbrains-toolbox
      # drawio
      # zotero # no aarch64
    ]
  );
  programs.gnupg.agent.enable = true;
  home-manager.backupFileExtension = "backup";
}
