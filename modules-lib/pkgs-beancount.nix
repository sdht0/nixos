{ config, pkgs, ... }:
{
  my-python.imports = [ "beancount" ];

  environment.systemPackages = (with pkgs; [ fava ]);
}
