{ lib, config }:
{
  linkFiles = list:
    builtins.foldl'
      (set: { link, dest }: lib.recursiveUpdate set {
        home.file.${link}.source =
          config.lib.file.mkOutOfStoreSymlink  "${config.home.homeDirectory}/${dest}";
      })
      {} list;
}
