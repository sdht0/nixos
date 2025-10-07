{
  ...
}:
{
  launchd.user.agents.selfwatcher = {
    command = "/Users/artimaeus/.config/dotfiles.safe/scripts/selfwatcher";
    serviceConfig = {
      RunAtLoad = true;
      KeepAlive = true;
      StandardOutPath = "/Users/artimaeus/.cache/selfwatcher.log";
      StandardErrorPath = "/Users/artimaeus/.cache/selfwatcher.err";
    };
  };
}
