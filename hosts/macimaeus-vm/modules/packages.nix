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

      # libreoffice-qt6-fresh
      obsidian
      activitywatch

      ffmpeg
      vlc

      # mcomix
      foliate

      inputs.nixOlde.packages.${system}.nix-olde
    ]
  );

  myPythonPkgs = [
    "pynput"
    "xlib"
  ];

  programs.gnupg.agent.enable = true;
  home-manager.backupFileExtension = "backup";
  services.mullvad-vpn.package = pkgs.mullvad-vpn;
}
