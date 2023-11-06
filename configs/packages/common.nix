{ lib, config, pkgs, ... }:
let
  lib' = import ../../lib { inherit config lib; };
  nftExe = "${pkgs.nftables}/bin/nft";
in
{
  imports = [
    ./extra-setup.nix
    ./mullvad/package.nix
  ];

  environment.systemPackages = with pkgs; [
    firefox-devedition chromium
    nftables killall
    gitFull wget curl rsync vim tmux htop ripgrep fzf eza peco sshfs
    ffmpeg gcc gnumake
    nix-output-monitor nvd
  ];
  programs.gnupg.agent.enable = true;

  services.tailscale.enable = true;
  environment.etc = (lib'.extraScript "tailscaleLogin" ''
    sudo tailscale login
    echo "TODOs:"
    echo "sudo tailscale lock sign ."
    echo "sudo tailscale lock add ."
    echo "web: disable key expiry, add tag"
  '');
}
