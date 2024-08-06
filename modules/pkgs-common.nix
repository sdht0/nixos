{ lib, config, pkgs, ... }:
{
  programs.zsh.enable = true;
  environment.shells = with pkgs; [ zsh ];
  environment.shellAliases = { ls = null; l = null; ll = null; }; # Remove defaults

  environment.systemPackages = with pkgs; [
    nftables dig wget curl rsync sshfs
    vim tmux gitFull ripgrep fzf eza
    bc aha difftastic jq peco
    ffmpeg
    htop pciutils killall
  ];
  programs.gnupg.agent.enable = true;
  programs.nano.enable = false;
}
