{ config, pkgs, ... }:
{
  myPythonPkgs = [
    "titlecase"
    "selenium"
    "bibtexparser"
  ];

  # environment.systemPackages = (with pkgs; [ chromedriver ]);
}
