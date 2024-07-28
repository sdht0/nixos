{ config, pkgs, ... }:
{
  environment.systemPackages = (with pkgs; [
    chromedriver
    (pkgs.python312.withPackages (ps: with ps; [
        notebook titlecase selenium bibtexparser
    ]))
  ]
}
