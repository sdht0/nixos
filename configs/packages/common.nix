{ config, pkgs, host, user, ... }:
let
  nftExe = "${pkgs.nftables}/bin/nft";
in
{
  imports = [
    ./mullvad/package.nix
  ];

  programs.zsh.enable = true;
  environment.shellAliases = { ls = null; l = null; ll = null; };
  environment.shells = with pkgs; [ zsh ];
  environment.systemPackages = with pkgs; [
    linux-firmware sof-firmware
    nftables
    gitFull wget curl rsync vim gnupg tmux htop ripgrep fzf eza peco sshfs
    firefox-devedition-bin chromium
    ffmpeg gcc gnumake
    nix-output-monitor
  ];
  services.tailscale.enable = true;
  /* Additional setup for tailscale:
    sudo tailscale login
    sudo tailscale lock sign ...
    sudo tailscale lock add ...
    web: disable key expiry, add tag
  */
}
