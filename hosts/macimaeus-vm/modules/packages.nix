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
      libreoffice-qt
      obsidian
      ffmpeg
      vlc
      mcomix
      foliate
      activitywatch
      inputs.nixOlde.packages.${system}.nix-olde
      vscode
      rustup
      gnumake
      gcc
      temurin-bin-21
      # thunderbird
      # zoom-us slack
      # jetbrains-toolbox
      # drawio
      # zotero # no aarch64
    ]
  );
}
