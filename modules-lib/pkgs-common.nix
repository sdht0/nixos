{
  lib,
  config,
  pkgs,
  ...
}:
{
  programs.zsh.enable = true;
  environment.shells = with pkgs; [ zsh ];

  environment.systemPackages = with pkgs; [
    starship # prompt

    gitFull
    # gitui # git tui

    vim
    tmux
    ripgrep # grep
    fzf # fuzzy search
    eza # ls
    jaq # jq
    bc # calculator
    peco # interactive filtering
    difftastic # semantic diffs
    bat # cat
    dua # du
    duf # df
    fd # find
    choose # cut
    broot # tree
    tokei # cloc
    lsof

    shellcheck

    gnupg

    zstd
    unzip

    htop
    bottom # top
    glances # top
    procs # ps

    gping # ping
    doggo # dig
  ];
}
