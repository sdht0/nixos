{ lib }:
rec {
  deepMerge_f = list: builtins.foldl' (merged: new: lib.recursiveUpdate merged new) { } list;

  # Creates links from a list [{ link = ...; dest = ...; } ...]
  linkFiles_f =
    fileModule: homeDirectory: list:
    let
      f_map =
        { link, dest }:
        let
          # Prefix home directory if `dest` is not an absolute path
          prefix = if (lib.hasPrefix "/" dest) then "" else "${homeDirectory}/";
        in
        {
          ${link}.source = fileModule.mkOutOfStoreSymlink "${prefix}${dest}";
        };
    in
    deepMerge_f (map f_map list);

  autostartApplication_f = app: {
    link = ".config/autostart/${app}";
    dest = "/run/current-system/sw/share/applications/${app}";
  };

  extraScript_f = name: text: {
    "extra-setup/${name}".text = ''
      toRun() {
        ${text}
      }
    '';
  };

  filesInDir_f = dir: lib.optionalAttrs (builtins.pathExists dir) (builtins.readDir dir);

  nixFilesInDir_f =
    dir:
    lib.attrsets.mapAttrsToList (name: _: dir + "/${name}") (
      lib.filterAttrs (n: _: lib.hasSuffix ".nix" n) (filesInDir_f dir)
    );
}
