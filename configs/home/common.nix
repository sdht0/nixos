{ config, pkgs, lib, ... }:
let
  lib' = import ../../lib { inherit config lib; };
in
{
  manual.manpages.enable = false;
  home.file = lib'.f_deepMerge [
    {
      ".zshrc".text = ''
          . ~/.bashrc
          [[ -f ~/.dotfiles/zshrc ]] && . ~/.dotfiles/zshrc || true
          [[ -f ~/.dotfiles.safe/zshrc ]] && . ~/.dotfiles.safe/zshrc || true
          '';
      ".bashrc".text = ''
        [[ -f ~/.dotfiles/bashrc ]] && . ~/.dotfiles/bashrc || true
        [[ -f ~/.dotfiles.safe/bashrc ]] && . ~/.dotfiles.safe/bashrc || true
        '';
    }
    (lib'.f_linkFiles [
      { link = ".tmux.conf";  dest = ".dotfiles/tmux.conf"; }
      { link = ".vimrc";      dest = ".dotfiles/vimrc"; }
      { link = ".gitconfig";  dest = ".dotfiles/gitconfig"; }
    ])
  ];
}
