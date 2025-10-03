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
    lib'.linkFiles_f config.lib.file "/home/${config.home.username}" [
      {
        link = ".ssh/authorized_hosts";
        dest = "${dotfiles}.safe/ssh/authorized_hosts";
      }
    ]
  );
}
