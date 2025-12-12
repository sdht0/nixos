{ pkgs, ... }:
{
  environment.systemPackages = (
    with pkgs;
    [
      beancount
      fava
      uv
    ]
  );

  my-python.imports = [ "beancount" ];
}
