{ username }:
{
  config,
  lib,
  lib',
  pkgs,
  ...
}:
let
  dotfiles = ".config/dotfiles";
in
{
  home.username = username;
  home.homeDirectory = "/home/${username}";

  home.file = (
    lib'.f_linkFiles config.lib.file "/home/${username}" (
      [
        {
          link = ".config/autostart/ssh-add.sh.desktop";
          dest = "${dotfiles}/scripts/ssh-agent/ssh-add.sh.desktop";
        }

        {
          link = ".ssh/config";
          dest = "${dotfiles}.safe/ssh/config";
        }
        {
          link = ".ssh/id_ed25519";
          dest = "${dotfiles}.safe/ssh/id_ed25519";
        }
        {
          link = ".ssh/id_ed25519.pub";
          dest = "${dotfiles}.safe/ssh/id_ed25519.pub";
        }

        {
          link = ".local/share/applications/ff2nix.desktop";
          dest = "${dotfiles}.safe/apps/ff2nix.desktop";
        }
      ]
      ++ (map lib'.f_autostartApplication [
        "org.kde.yakuake.desktop"
        "solaar.desktop"
        "aw-qt.desktop"
        "mullvad-vpn.desktop"
      ])
    )
  );

  programs.home-manager.enable = true;
  home.stateVersion = "23.05";
}
