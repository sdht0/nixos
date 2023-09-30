{ lib, config, ... }:

let
  lib' = import ../../lib { inherit config lib; };
in
lib.recursiveUpdate {
  imports = [ ../../configs/home/common.nix ];

  programs.home-manager.enable = true;
  home.stateVersion = "23.05";
}
(lib'.linkFiles [
  { link = ".ssh/config";         dest = ".dotfiles.safe/ssh/config"; }
  { link = ".ssh/id_ed25519";     dest = ".dotfiles.safe/ssh/id_ed25519"; }
  { link = ".ssh/id_ed25519.pub"; dest = ".dotfiles.safe/ssh/id_ed25519.pub"; }

  { link = ".config/plasma-workspace/env/ssh-agent.sh"; dest = ".dotfiles/ssh_agent/ssh-agent.sh"; }
  { link = ".config/autostart/ssh-add.sh.desktop";      dest = ".dotfiles.safe/apps/ssh-add.sh.desktop"; }

  { link = ".local/share/applications/ff2.desktop";     dest = ".dotfiles.safe/apps/ff2.desktop"; }
  { link = ".local/share/applications/ff2nix.desktop";  dest = ".dotfiles.safe/apps/ff2nix.desktop"; }
])
