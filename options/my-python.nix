{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.my-python = {
    enable = lib.mkEnableOption "my-python";
    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.python3;
    };
    imports = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ ];
    };
    final = lib.mkOption {
      type = lib.types.package;
    };
  };

  config = lib.mkIf config.my-python.enable {
    my-python.final = config.my-python.package.withPackages (
      ps: lib.attrsets.attrVals config.my-python.imports ps
    );
    environment.systemPackages = [
      config.my-python.final
    ];
  };
}
