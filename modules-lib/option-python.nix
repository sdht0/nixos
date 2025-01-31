{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    myPythonVer = lib.mkOption {
      type = lib.types.package;
      default = pkgs.python3;
    };
    myPythonPkgs = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ ];
    };
    myPythonSet = lib.mkOption {
      type = lib.types.package;
      default = config.myPythonVer.withPackages (ps: lib.attrsets.attrVals config.myPythonPkgs ps);
    };
  };

  config = {
    myPythonPkgs = [
      "pandas"
      "requests"
    ];
    environment.systemPackages = [
      config.myPythonSet
    ];
  };
}
