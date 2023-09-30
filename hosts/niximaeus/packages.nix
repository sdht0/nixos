{ config, pkgs, ... }:

{
  imports = [
    ../../configs/packages/common.nix
    ../../configs/packages/plasma5.nix
    ../../configs/packages/syncthing.nix
  ];

  environment.systemPackages = with pkgs; [
    thunderbird slack
    ffmpeg vlc calibre mcomix
    nil nixfmt
    rustup gcc lldb openjdk17-bootstrap gnumake vscode jetbrains.rust-rover
    obsidian fava zotero activitywatch
    (pkgs.python3.withPackages (ps: with ps; [
        beancount pip jupyter notebook ipykernel
    ]))
    noto-fonts noto-fonts-cjk noto-fonts-emoji
    jetbrains-mono meslo-lgs-nf
  ];
}
