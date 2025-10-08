{
  lib,
  hostData,
  inputs,
  ...
}:
{
  system.primaryUser = hostData.mainuser;

  system = {
    stateVersion = 6;
    configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;

    # Don't create empty /Applications/Nix Apps dir.
    activationScripts.applications.text = lib.mkForce "";

    defaults = {
      finder = {
        AppleShowAllFiles = true;
        AppleShowAllExtensions = true;
        FXPreferredViewStyle = "Nlsv";
        ShowPathbar = true;
        ShowStatusBar = true;
        QuitMenuItem = true;
        _FXSortFoldersFirst = true;
      };

      trackpad = {
        TrackpadRightClick = true;
      };

      dock = {
        tilesize = 42;
        minimize-to-application = true;
      };

      menuExtraClock.ShowDate = 1;
      controlcenter.BatteryShowPercentage = true;
      SoftwareUpdate.AutomaticallyInstallMacOSUpdates = true;
      hitoolbox.AppleFnUsageType = "Do Nothing";
      loginwindow.GuestEnabled = false;
      WindowManager.EnableTiledWindowMargins = false;
      NSGlobalDomain.AppleShowScrollBars = "Always";
    };
  };
}
