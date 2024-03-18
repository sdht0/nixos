{ lib, config, pkgs, ... }:
let
  lib' = import ../../lib { inherit config lib; };
in
{
  imports = [
    ./extra-setup.nix
    ./mullvad/package.nix
  ];

  environment.systemPackages = with pkgs; [
    chromium
    nftables killall gitFull wget curl rsync vim tmux htop ripgrep fzf eza peco sshfs ffmpeg dig bc aha
    pciutils
    nix-output-monitor nvd
  ];
  programs.gnupg.agent.enable = true;
  programs.nano.enable = false;

  services.tailscale.enable = true;
  systemd.services.tailscaled.serviceConfig.Environment = [ "TS_NO_LOGS_NO_SUPPORT=true" ];
  environment.etc = (lib'.extraScript "tailscaleLogin" ''
    sudo tailscale login
    echo "TODOs:"
    echo "sudo tailscale lock sign ."
    echo "sudo tailscale lock add ."
    echo "web: disable key expiry, add tag"
  '');
}
