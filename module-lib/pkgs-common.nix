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
    ncdu # du
    duf # df
    fd # find
    zoxide # cd
    tldr # --help
    choose # cut
    broot # tree

    gitFull
    lazygit # git tui

    htop
    killall
    bottom # top
    glances # top
    gtop # top
    procs # ps

    sqlite
    unzip
    ffmpeg

    nftables
    wget
    curl
    rsync
    sshfs
    dig
    gping # ping
    doggo # dig

    gptfdisk
    pciutils
    dmidecode
  ];
  programs.gnupg.agent.enable = true;
  programs.nano.enable = false;
}
