{
  pkgs,
  ...
}:
{
  imports = [
    ../../../modules-lib/pkgs-dev-python.nix
  ];

  environment.systemPackages = (
    with pkgs;
    [
      code-cursor
      claude-code
      codex

      temurin-bin-21
      nodejs
    ]
  );
}
