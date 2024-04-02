{ lib, config }:
rec {
  # Creates links from a list [{ link = ...; dest = ...; } ...]
  f_linkFiles = list:
    let f_map = { link, dest }:
      let
        # Prefix home directory if `dest` is not an absolute path
        prefix = if (lib.hasPrefix "/" dest) then "" else "${config.home.homeDirectory}/";
      in {
        ${link}.source =
          config.lib.file.mkOutOfStoreSymlink  "${prefix}${dest}";
      };
    in
      f_deepMerge (map f_map list);

  f_autostartApplication = app: {
    link = ".config/autostart/${app}";
    dest = "/run/current-system/sw/share/applications/${app}";
  };

  f_extraScript = name: text: {
    "extra-setup/${name}".text = ''
      toRun() {
        ${text}
      }
    '';
  };

  f_deepMerge = list: builtins.foldl' (merged: new: lib.recursiveUpdate merged new) {} list;
}
