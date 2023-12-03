{ config, pkgs, lib, ... }:
let
  lib' = import ../../lib { inherit config lib; };
in
{
  manual.manpages.enable = false;
  home.file = lib'.deepMerge [
    {
      ".zshrc".text = ''
          . ~/.bashrc
          [[ -f ~/.dotfiles/zshrc ]] && . ~/.dotfiles/zshrc
          [[ -f ~/.dotfiles.safe/zshrc ]] && . ~/.dotfiles.safe/zshrc
          '';
      ".bashrc".text = ''
        [[ -f ~/.dotfiles/bashrc ]] && . ~/.dotfiles/bashrc
        [[ -f ~/.dotfiles.safe/bashrc ]] && . ~/.dotfiles.safe/bashrc
        '';
    }
    (lib'.linkFiles [
      { link = ".tmux.conf";  dest = ".dotfiles/tmux.conf"; }
      { link = ".vimrc";      dest = ".dotfiles/vimrc"; }
      { link = ".gitconfig";  dest = ".dotfiles/gitconfig"; }
    ])
  ];
}
