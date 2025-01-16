{ lib, config, pkgs, ... }:
{
  programs.zsh.enable = true;
  environment.shells = with pkgs; [ zsh ];
  environment.shellAliases = { ls = null; l = null; ll = null; }; # Remove defaults

  environment.systemPackages = with pkgs; [
    nftables dig wget curl rsync sshfs
    vim tmux ripgrep fzf eza
    gitFull lazygit
    bc aha jq peco difftastic
    ffmpeg
    htop pciutils killall dmidecode
    sqlite
  ];
  programs.gnupg.agent.enable = true;
  programs.nano.enable = false;
}
