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
    choose # cut
    broot # tree

    gnupg

    gitFull
    lazygit # git tui

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
