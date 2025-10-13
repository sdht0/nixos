{ pkgs, ... }:
{
  programs.zsh.enable = true;
  environment.shells = with pkgs; [ zsh ];

  my-python.enable = true;

  environment.systemPackages = with pkgs; [
    tmux
    fzf # fuzzy search
    mcfly # shell history
    mcfly-fzf
    peco # interactive filtering
    starship # prompt

    gitFull
    gitui # git tui

    vim
    eza # ls
    ripgrep # grep
    zoxide # cd
    jaq # jq
    bc # calculator
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
    mtr # traceroute
  ];
}
