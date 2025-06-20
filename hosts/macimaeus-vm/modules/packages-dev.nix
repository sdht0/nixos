{
  config,
  lib,
  pkgs,
  ...
}:
{
  environment.systemPackages = (
    with pkgs;
    [
      vscode
      jetbrains.pycharm-community-bin

      claude-code
      (code-cursor.overrideAttrs (oldAttrs: rec {
        pname = "code-cursor";
        version = "1.1.3";
        src = pkgs.appimageTools.extract {
          inherit pname version;
          src = pkgs.fetchurl {
            url = "https://downloads.cursor.com/production/979ba33804ac150108481c14e0b5cb970bda3266/linux/arm64/Cursor-1.1.3-aarch64.AppImage";
            hash = "sha256-1uWfTOrBcCX6QWTwB9C45RsjLqu2C89DQkqKFTHsKxg=";
          };
        };
        sourceRoot = "${pname}-${version}-extracted/usr/share/cursor";
      }))

      temurin-bin-21
      nodejs
    ]
  );
}
