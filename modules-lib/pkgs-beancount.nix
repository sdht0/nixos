{ pkgs, ... }:
{
  environment.systemPackages = (with pkgs; [ beancount fava ]);

  my-python.imports = [ "beancount" ];
}
