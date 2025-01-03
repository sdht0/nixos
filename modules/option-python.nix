{ config, lib, pkgs, ... }:

{
  options = {
    myPythonPkgs = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
    };
  };
}
