{ lib, config, pkgs, ... }:
{
  programs.zsh.enable = true;
  environment.shells = with pkgs; [ zsh ];
  environment.shellAliases = { ls = null; l = null; ll = null; }; # Remove defaults

  environment.systemPackages = with pkgs; [
    nftables dig wget curl rsync sshfs
    vim tmux gitFull ripgrep fzf eza
    bc aha jq peco
    ffmpeg
    htop pciutils killall dmidecode
    sqlite
  ];
  programs.gnupg.agent.enable = true;
  programs.nano.enable = false;
}
