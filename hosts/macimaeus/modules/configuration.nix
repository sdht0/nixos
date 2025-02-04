{
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    ../../../modules-lib/option-python.nix

    ../../../modules-lib/system-nix-darwin.nix
    ../../../modules-lib/system-basic-darwin.nix
    ../../../modules-lib/pkgs-common-darwin.nix
    ../../../modules-lib/pkgs-dev-nix.nix
  ];

  programs.nix-index.enable = true;

  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      upgrade = true;
      cleanup = "zap";
    };

    brews = [
      "curl" # avoid nixpkgs' version?
    ];

    casks = [
      "utm"
      "iterm2"
      "zoom"
      "firefox"
      "google-chrome"
      "tor-browser"
      "font-hack-nerd-font"
      "visual-studio-code"
      "stats"
    ];
  };

  system = {
    stateVersion = 5;
    configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;
    activationScripts.postUserActivation.text = ''
      # activateSettings -u will reload the settings from the database and apply them to the current session,
      # so we do not need to logout and login again to make the changes take effect.
      /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
    '';

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
  security.pam.enableSudoTouchIdAuth = true;
}
