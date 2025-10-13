{
  config,
  ...
}:
{
  home.homeDirectory = "/home/${config.home.username}";
  programs.home-manager.enable = true;
  fonts.fontconfig.enable = false;
  home.stateVersion = "25.05";
}
