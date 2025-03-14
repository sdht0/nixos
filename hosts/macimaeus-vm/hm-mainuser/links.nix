{
  config,
  lib,
  lib',
  ...
}:
let
  dotfiles = ".config/dotfiles";
in
{
  home.file = (
    lib'.linkFiles_f config.lib.file "/home/${config.home.username}" (
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
      ++ (map lib'.autostartApplication_f [
        "org.kde.yakuake.desktop"
        "aw-qt.desktop"
        "mullvad-vpn.desktop"
      ])
    )
  );
}
