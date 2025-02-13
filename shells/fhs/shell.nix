#!/usr/bin/env nix-shell

{
  pkgs ? import <nixpkgs> { },
}:

(
  let
    base = pkgs.appimageTools.defaultFhsEnvArgs;
  in
  pkgs.buildFHSEnv (
    base
    // {
      name = "FHS";
      targetPkgs = pkgs: (with pkgs; [ python3 python3Packages.pip ]);
      runScript = "zsh";
      extraOutputsToInstall = [ "dev" ];
    }
  )
).env
