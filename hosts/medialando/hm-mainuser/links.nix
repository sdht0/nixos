{
  config,
  lib,
  lib',
  users,
  ...
}:
let
  username = users.mainuser.username;
  dotfiles = ".config/dotfiles";
in
{
  home.file = (
    lib'.f_linkFiles config.lib.file "/home/${username}" [
      {
        link = ".ssh/authorized_hosts";
        dest = "${dotfiles}.safe/ssh/authorized_hosts";
      }
    ]
  );
}
