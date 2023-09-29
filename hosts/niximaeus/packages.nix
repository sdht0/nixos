{ config, pkgs, ... }:

{
  imports = [
    ../../configs/system/syncthing.nix
  ];

  environment.systemPackages = with pkgs; [
    chromium thunderbird slack
    ffmpeg vlc calibre mcomix
    nil nixfmt nix-output-monitor
    rustup gcc gnumake vscode jetbrains.rust-rover
    obsidian fava zotero activitywatch
    (pkgs.python3.withPackages (ps: with ps; [
        beancount pip jupyter notebook ipykernel
    ]))
  ];
}
