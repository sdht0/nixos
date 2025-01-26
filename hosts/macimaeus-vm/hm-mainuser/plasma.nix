{
  config,
  lib,
  lib',
  users,
  ...
}:
{
  programs.plasma = {
    enable = true;
    shortcuts = {
      "ksmserver"."Log Out" = "Ctrl+Alt+Del";
      "kwin"."Grid View" = "Meta+G";
      "kwin"."Show Desktop" = "Meta+D";
      "kwin"."Switch One Desktop Down" = "Meta+Ctrl+Down";
      "kwin"."Switch One Desktop Up" = "Meta+Ctrl+Up";
      "kwin"."Switch One Desktop to the Left" = "Meta+Ctrl+Left";
      "kwin"."Switch One Desktop to the Right" = "Meta+Ctrl+Right";
      "kwin"."Switch Window Down" = "Meta+Alt+Down";
      "kwin"."Switch Window Left" = "Meta+Alt+Left";
      "kwin"."Switch Window Right" = "Meta+Alt+Right";
      "kwin"."Switch Window Up" = "Meta+Alt+Up";
      "kwin"."Switch to Desktop 1" = [
        "Ctrl+F1"
        "Meta+1,Ctrl+F1,Switch to Desktop 1"
      ];
      "kwin"."Switch to Desktop 2" = [
        "Ctrl+F2"
        "Meta+2,Ctrl+F2,Switch to Desktop 2"
      ];
      "kwin"."Switch to Desktop 3" = [
        "Ctrl+F3"
        "Meta+3,Ctrl+F3,Switch to Desktop 3"
      ];
      "kwin"."Switch to Desktop 4" = [
        "Ctrl+F4"
        "Meta+4,Ctrl+F4,Switch to Desktop 4"
      ];
      "kwin"."Switch to Next Desktop" = "Meta+`,,Switch to Next Desktop";
      "kwin"."Switch to Previous Desktop" = "Meta+~,,Switch to Previous Desktop";
      "kwin"."Walk Through Windows" = "Alt+Tab";
      "kwin"."Walk Through Windows (Reverse)" = "Alt+Shift+Tab";
      "kwin"."Walk Through Windows of Current Application" = "Alt+`";
      "kwin"."Walk Through Windows of Current Application (Reverse)" = "Alt+~";
      "kwin"."Window Maximize" = "Meta+PgUp";
      "kwin"."Window Minimize" = "Meta+PgDown";
      "kwin"."Window Quick Tile Bottom" = "Meta+Down";
      "kwin"."Window Quick Tile Left" = "Meta+Left";
      "kwin"."Window Quick Tile Right" = "Meta+Right";
      "kwin"."Window Quick Tile Top" = "Meta+Up";
      "kwin"."Window to Desktop 1" = "Meta+!,,Window to Desktop 1";
      "kwin"."Window to Desktop 2" = "Meta+@,,Window to Desktop 2";
      "kwin"."Window to Desktop 3" = "Meta+#,,Window to Desktop 3";
      "kwin"."Window to Desktop 4" = "Meta+$,,Window to Desktop 4";
      "yakuake"."toggle-window-state" = "Meta+E,F12,Open/Retract Yakuake";
    };
    configFile = {
      "dolphinrc"."CompactMode"."PreviewSize" = 22;
      "dolphinrc"."ContextMenu"."ShowSortBy" = false;
      "dolphinrc"."ContextMenu"."ShowViewMode" = false;
      "dolphinrc"."DetailsMode"."IconSize" = 22;
      "dolphinrc"."DetailsMode"."PreviewSize" = 22;
      "dolphinrc"."General"."HomeUrl" = "/home/artimaeus/Downloads";
      "dolphinrc"."General"."RememberOpenedTabs" = false;
      "dolphinrc"."General"."ShowFullPath" = true;
      "dolphinrc"."General"."ShowSelectionToggle" = false;
      "dolphinrc"."IconsMode"."PreviewSize" = 256;
      "dolphinrc"."KFileDialog Settings"."Places Icons Auto-resize" = false;
      "dolphinrc"."KFileDialog Settings"."Places Icons Static Size" = 22;
      "dolphinrc"."MainWindow/Toolbar mainToolBar"."ToolButtonStyle" = "IconOnly";
      "dolphinrc"."Toolbar mainToolBar"."ToolButtonStyle" = "IconOnly";
      "kcminputrc"."Keyboard"."NumLock" = 0;
      "kcminputrc"."Mouse"."X11LibInputXAccelProfileFlat" = true;
      "kcminputrc"."Mouse"."XLbInptAccelProfileFlat" = false;
      "kcminputrc"."Mouse"."XLbInptNaturalScroll" = true;
      "kded5rc"."Module-browserintegrationreminder"."autoload" = false;
      "kded5rc"."Module-device_automounter"."autoload" = false;
      "kdeglobals"."DirSelect Dialog"."DirSelectDialog Size" = "864,540";
      "kdeglobals"."General"."AccentColor" = "61,174,233";
      "kdeglobals"."General"."LastUsedCustomAccentColor" = "61,174,233";
      "kdeglobals"."KDE"."ShowDeleteCommand" = true;
      "kdeglobals"."KDE"."SingleClick" = true;
      "kdeglobals"."KFileDialog Settings"."Allow Expansion" = false;
      "kdeglobals"."KFileDialog Settings"."Automatically select filename extension" = true;
      "kdeglobals"."KFileDialog Settings"."Breadcrumb Navigation" = true;
      "kdeglobals"."KFileDialog Settings"."Decoration position" = 0;
      "kdeglobals"."KFileDialog Settings"."LocationCombo Completionmode" = 5;
      "kdeglobals"."KFileDialog Settings"."PathCombo Completionmode" = 5;
      "kdeglobals"."KFileDialog Settings"."Show Bookmarks" = false;
      "kdeglobals"."KFileDialog Settings"."Show Full Path" = false;
      "kdeglobals"."KFileDialog Settings"."Show Inline Previews" = false;
      "kdeglobals"."KFileDialog Settings"."Show Preview" = false;
      "kdeglobals"."KFileDialog Settings"."Show Speedbar" = true;
      "kdeglobals"."KFileDialog Settings"."Show hidden files" = true;
      "kdeglobals"."KFileDialog Settings"."Sort by" = "Name";
      "kdeglobals"."KFileDialog Settings"."Sort directories first" = true;
      "kdeglobals"."KFileDialog Settings"."Sort hidden files last" = false;
      "kdeglobals"."KFileDialog Settings"."Sort reversed" = false;
      "kdeglobals"."KFileDialog Settings"."Speedbar Width" = 128;
      "kdeglobals"."KFileDialog Settings"."View Style" = "Detail";
      "kdeglobals"."KShortcutsDialog Settings"."Dialog Size" = "600,480";
      "kdeglobals"."PreviewSettings"."EnableRemoteFolderThumbnail" = false;
      "kdeglobals"."PreviewSettings"."MaximumRemoteSize" = 0;
      "kdeglobals"."WM"."activeBackground" = "114,193,235";
      "kdeglobals"."WM"."activeBlend" = "252,252,252";
      "kdeglobals"."WM"."activeForeground" = "0,0,0";
      "kdeglobals"."WM"."inactiveBackground" = "239,240,241";
      "kdeglobals"."WM"."inactiveBlend" = "75,71,67";
      "kdeglobals"."WM"."inactiveForeground" = "189,195,199";
      "kiorc"."Executable scripts"."behaviourOnLaunch" = "alwaysAsk";
      "klipperrc"."General"."IgnoreImages" = false;
      "klipperrc"."General"."MaxClipItems" = 1000;
      "kscreenlockerrc"."Daemon"."Autolock" = false;
      "kscreenlockerrc"."Daemon"."LockOnResume" = false;
      "kscreenlockerrc"."Daemon"."Timeout" = 0;
      "kservicemenurc"."Show"."compressfileitemaction" = true;
      "kservicemenurc"."Show"."extractfileitemaction" = true;
      "kservicemenurc"."Show"."forgetfileitemaction" = true;
      "ksmserverrc"."General"."loginMode" = "emptySession";
      "kwinrc"."Desktops"."Number" = 3;
      "kwinrc"."Desktops"."Rows" = 1;
      "kwinrc"."Plugins"."magiclampEnabled" = true;
      "kwinrc"."Plugins"."slideEnabled" = false;
      "kwinrc"."Plugins"."squashEnabled" = false;
      "kwinrc"."Plugins"."wobblywindowsEnabled" = true;
      "kwinrc"."Windows"."RollOverDesktops" = true;
      "kwinrc"."org.kde.kdecoration2"."ButtonsOnLeft" = "M";
      "kwinrc"."org.kde.kdecoration2"."ButtonsOnRight" = "HSFAIX";
      "plasmanotifyrc"."Notifications"."PopupPosition" = "BottomRight";
      "spectaclerc"."General"."clipboardGroup" = "PostScreenshotCopyImage";
      "spectaclerc"."General"."launchAction" = "UseLastUsedCapturemode";
    };
  };
}
