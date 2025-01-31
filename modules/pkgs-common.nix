{
  lib,
  config,
  pkgs,
  ...
}:
{
  programs.zsh.enable = true;
  environment.shells = with pkgs; [ zsh ];
  environment.shellAliases = {
    ls = null;
    l = null;
    ll = null;
  }; # Remove defaults

  environment.systemPackages = with pkgs; [
    vim
    tmux
    htop
    killall
    ripgrep # grep
    fzf # fuzzy search
    eza # ls
    jq # json
    bc # calculator
    aha # html
    starship # prompt
    peco # interactive filtering
    difftastic # semantic diffs
    bat # cat
    dua # du
    fd # find
    zoxide # cd
    tldr # --help

    gitFull
    lazygit # git tui

    sqlite
    unzip
    ffmpeg

    nftables
    dig
    wget
    curl
    rsync
    sshfs

    gptfdisk
    pciutils
    dmidecode
  ];
  programs.gnupg.agent.enable = true;
  programs.nano.enable = false;
}
