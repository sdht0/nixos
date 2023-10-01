{ config, pkgs, host, user, ... }:
let
  nftExe = "${pkgs.nftables}/bin/nft";
in
{
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
  services.mullvad-vpn = {
    enable = true;
    package = pkgs.mullvad-vpn;
  };
  systemd.services.mullvad-daemon.environment = {
    TALPID_NET_CLS_MOUNT_DIR= "/run/mullvad";
  };
  # Make mullvad play well with tailscale
  systemd.services.mullvad-daemon = {
    preStart = ''
      ${nftExe} -f '${./mullvad/mullvad-ts.nft}'
    '';
    # FIXME: Remove when https://github.com/mullvad/mullvadvpn-app/pull/5011 is in a release
    postStart = ''
      sleep 3 && \
      ${nftExe} list ruleset |& grep 'table inet mullvad {' && \
        ${nftExe} insert rule inet mullvad forward ip daddr 100.64.0.0/10 accept || \
        true
    '';
    postStop = ''
      ${nftExe} -f '${./mullvad/mullvad-ts-cleanup.nft}'
    '';
  };
  /* Additional setup for mullvad:
    mullvad account login
    mullvad relay set location ... && \
    mullvad relay set tunnel-protocol wireguard && \
    mullvad auto-connect set on && \
    mullvad lan set allow && \
    mullvad lockdown-mode set on
  */
}
