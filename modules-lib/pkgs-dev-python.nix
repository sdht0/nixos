{
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    ruff
    uv
  ];
}
