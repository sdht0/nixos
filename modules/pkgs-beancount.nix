{ config, pkgs, ... }:
{
  myPythonPkgs = [
      "beancount"
  ];

  environment.systemPackages = (with pkgs; [
    fava
  ]);
}
