{ lib, config }:
{
  # Creates links from a list [{ link = ...; dest = ...; } ...]
  linkFiles = list:
    builtins.foldl'
      (set: { link, dest }:
        let
          # Prefix home directory if `dest` is not an absolute path
          prefix = if (lib.hasPrefix "/" dest) then "" else "${config.home.homeDirectory}/";
        in
          # Deeply merge attribute names
          lib.recursiveUpdate set {
            home.file.${link}.source =
              config.lib.file.mkOutOfStoreSymlink  "${prefix}${dest}";
          })
      {} list;

  autostartApplication = app: {
    link = ".config/autostart/${app}";
    dest = "/run/current-system/sw/share/applications/${app}";
  };
}
