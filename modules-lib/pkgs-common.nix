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
    vim
    tmux
    ripgrep # grep
    fzf # fuzzy search
    eza # ls
    jaq # jq
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
    choose # cut
    broot # tree
    tokei # cloc

    shellcheck

    gnupg

    gitFull
    gitui # git tui

    zstd
    unzip

    htop
    bottom # top
    glances # top
    gtop # top
    procs # ps

    gping # ping
    doggo # dig
  ];
}
