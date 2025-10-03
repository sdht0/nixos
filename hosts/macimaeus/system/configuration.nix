{
  lib,
  hostData,
  inputs,
  ...
}:
{
  imports = [
    ../../../modules-lib/option-python.nix

    ../../../modules-lib/system-nix-darwin.nix
    ../../../modules-lib/system-basic-darwin.nix
    ../../../modules-lib/pkgs-common-darwin.nix
    # ../../../modules-lib/pkgs-dev-nix.nix
  ];

  system.primaryUser = hostData.mainuser;

  launchd.user.agents.selfwatcher = {
    command = "/Users/artimaeus/.config/dotfiles.safe/scripts/selfwatcher";
    serviceConfig = {
      RunAtLoad = true;
      KeepAlive = true;
      StandardOutPath = "/Users/artimaeus/.cache/selfwatcher.log";
      StandardErrorPath = "/Users/artimaeus/.cache/selfwatcher.err";
    };
  };

  programs.nix-index.enable = true;

  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      upgrade = true;
      cleanup = "zap";
    };

    casks = lib.map (n: { name = n; greedy = true; }) [
      "utm"
      "iterm2"
      "zoom"
      "firefox"
      "tor-browser"
      "font-jetbrains-mono-nerd-font"
      "stats"
      "ollama-app"
    ];
  };

  system = {
    stateVersion = 5;
    configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;

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
    };
  };
}
