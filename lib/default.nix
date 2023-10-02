{ lib, config }:
rec {
  # Creates links from a list [{ link = ...; dest = ...; } ...]
  linkFiles = list:
    let mapFn = { link, dest }:
      let
        # Prefix home directory if `dest` is not an absolute path
        prefix = if (lib.hasPrefix "/" dest) then "" else "${config.home.homeDirectory}/";
      in {
        ${link}.source =
          config.lib.file.mkOutOfStoreSymlink  "${prefix}${dest}";
      };
    in
      deepMerge (map mapFn list);

  autostartApplication = app: {
    link = ".config/autostart/${app}";
    dest = "/run/current-system/sw/share/applications/${app}";
  };

  extraScript = name: text: {
    "extra-setup/${name}".text = ''
      toRun() {
        ${text}
      }
    '';
  };

  deepMerge = list: builtins.foldl' (merged: new: lib.recursiveUpdate merged new) {} list;
}
