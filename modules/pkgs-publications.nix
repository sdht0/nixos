{ config, pkgs, ... }:
{
  myPythonPkgs = [
      "notebook" "titlecase" "selenium" "bibtexparser"
  ];

  environment.systemPackages = (with pkgs; [
    chromedriver
  ]);
}
