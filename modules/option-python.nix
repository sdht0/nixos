{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    myPythonVer = lib.mkOption { type = lib.types.package; };
    myPythonPkgs = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ ];
    };
    myPythonSet = lib.mkOption {
      type = lib.types.package;
      default = config.myPythonVer.withPackages (ps: lib.attrsets.attrVals config.myPythonPkgs ps);
    };
  };
}
