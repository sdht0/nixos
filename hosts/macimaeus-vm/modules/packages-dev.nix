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
      rustup
      temurin-bin-21

      jetbrains.clion

      clang-tools
      cppcheck
      cpplint
      codechecker
    ]
  );
}
