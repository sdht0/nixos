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
      runScript = "zsh";
      extraOutputsToInstall = [ "dev" ];
    }
  )
).env
