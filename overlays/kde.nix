{ lib, config, pkgs, ... }@args:
let
  sources = lib.importJSON ./files/kde-sources.json;
in
[
  (final: prev: {
    kdePackages = prev.kdePackages.overrideScope (kfinal: kprev: {
      attica = kprev.attica.overrideAttrs (oldAttrs: {
        inherit (sources.attica) pname version;
        src = pkgs.fetchurl {
          name = sources.attica.fname;
          inherit (sources.attica) url sha256;
        };
      });
      baloo = kprev.baloo.overrideAttrs (oldAttrs: {
        inherit (sources.baloo) pname version;
        src = pkgs.fetchurl {
          name = sources.baloo.fname;
          inherit (sources.baloo) url sha256;
        };
      });
      bluez-qt = kprev.bluez-qt.overrideAttrs (oldAttrs: {
        inherit (sources.bluez-qt) pname version;
        src = pkgs.fetchurl {
          name = sources.bluez-qt.fname;
          inherit (sources.bluez-qt) url sha256;
        };
      });
      breeze-icons = kprev.breeze-icons.overrideAttrs (oldAttrs: {
        inherit (sources.breeze-icons) pname version;
        src = pkgs.fetchurl {
          name = sources.breeze-icons.fname;
          inherit (sources.breeze-icons) url sha256;
        };
      });
      extra-cmake-modules = kprev.extra-cmake-modules.overrideAttrs (oldAttrs: {
        inherit (sources.extra-cmake-modules) pname version;
        src = pkgs.fetchurl {
          name = sources.extra-cmake-modules.fname;
          inherit (sources.extra-cmake-modules) url sha256;
        };
      });
      frameworkintegration = kprev.frameworkintegration.overrideAttrs (oldAttrs: {
        inherit (sources.frameworkintegration) pname version;
        src = pkgs.fetchurl {
          name = sources.frameworkintegration.fname;
          inherit (sources.frameworkintegration) url sha256;
        };
      });
      kapidox = kprev.kapidox.overrideAttrs (oldAttrs: {
        inherit (sources.kapidox) pname version;
        src = pkgs.fetchurl {
          name = sources.kapidox.fname;
          inherit (sources.kapidox) url sha256;
        };
      });
      karchive = kprev.karchive.overrideAttrs (oldAttrs: {
        inherit (sources.karchive) pname version;
        src = pkgs.fetchurl {
          name = sources.karchive.fname;
          inherit (sources.karchive) url sha256;
        };
      });
      kauth = kprev.kauth.overrideAttrs (oldAttrs: {
        inherit (sources.kauth) pname version;
        src = pkgs.fetchurl {
          name = sources.kauth.fname;
          inherit (sources.kauth) url sha256;
        };
      });
      kbookmarks = kprev.kbookmarks.overrideAttrs (oldAttrs: {
        inherit (sources.kbookmarks) pname version;
        src = pkgs.fetchurl {
          name = sources.kbookmarks.fname;
          inherit (sources.kbookmarks) url sha256;
        };
      });
      kcalendarcore = kprev.kcalendarcore.overrideAttrs (oldAttrs: {
        inherit (sources.kcalendarcore) pname version;
        src = pkgs.fetchurl {
          name = sources.kcalendarcore.fname;
          inherit (sources.kcalendarcore) url sha256;
        };
      });
      kcmutils = kprev.kcmutils.overrideAttrs (oldAttrs: {
        inherit (sources.kcmutils) pname version;
        src = pkgs.fetchurl {
          name = sources.kcmutils.fname;
          inherit (sources.kcmutils) url sha256;
        };
      });
      kcodecs = kprev.kcodecs.overrideAttrs (oldAttrs: {
        inherit (sources.kcodecs) pname version;
        src = pkgs.fetchurl {
          name = sources.kcodecs.fname;
          inherit (sources.kcodecs) url sha256;
        };
      });
      kcolorscheme = kprev.kcolorscheme.overrideAttrs (oldAttrs: {
        inherit (sources.kcolorscheme) pname version;
        src = pkgs.fetchurl {
          name = sources.kcolorscheme.fname;
          inherit (sources.kcolorscheme) url sha256;
        };
      });
      kcompletion = kprev.kcompletion.overrideAttrs (oldAttrs: {
        inherit (sources.kcompletion) pname version;
        src = pkgs.fetchurl {
          name = sources.kcompletion.fname;
          inherit (sources.kcompletion) url sha256;
        };
      });
      kconfig = kprev.kconfig.overrideAttrs (oldAttrs: {
        inherit (sources.kconfig) pname version;
        src = pkgs.fetchurl {
          name = sources.kconfig.fname;
          inherit (sources.kconfig) url sha256;
        };
      });
      kconfigwidgets = kprev.kconfigwidgets.overrideAttrs (oldAttrs: {
        inherit (sources.kconfigwidgets) pname version;
        src = pkgs.fetchurl {
          name = sources.kconfigwidgets.fname;
          inherit (sources.kconfigwidgets) url sha256;
        };
      });
      kcontacts = kprev.kcontacts.overrideAttrs (oldAttrs: {
        inherit (sources.kcontacts) pname version;
        src = pkgs.fetchurl {
          name = sources.kcontacts.fname;
          inherit (sources.kcontacts) url sha256;
        };
      });
      kcoreaddons = kprev.kcoreaddons.overrideAttrs (oldAttrs: {
        inherit (sources.kcoreaddons) pname version;
        src = pkgs.fetchurl {
          name = sources.kcoreaddons.fname;
          inherit (sources.kcoreaddons) url sha256;
        };
      });
      kcrash = kprev.kcrash.overrideAttrs (oldAttrs: {
        inherit (sources.kcrash) pname version;
        src = pkgs.fetchurl {
          name = sources.kcrash.fname;
          inherit (sources.kcrash) url sha256;
        };
      });
      kdav = kprev.kdav.overrideAttrs (oldAttrs: {
        inherit (sources.kdav) pname version;
        src = pkgs.fetchurl {
          name = sources.kdav.fname;
          inherit (sources.kdav) url sha256;
        };
      });
      kdbusaddons = kprev.kdbusaddons.overrideAttrs (oldAttrs: {
        inherit (sources.kdbusaddons) pname version;
        src = pkgs.fetchurl {
          name = sources.kdbusaddons.fname;
          inherit (sources.kdbusaddons) url sha256;
        };
      });
      kdeclarative = kprev.kdeclarative.overrideAttrs (oldAttrs: {
        inherit (sources.kdeclarative) pname version;
        src = pkgs.fetchurl {
          name = sources.kdeclarative.fname;
          inherit (sources.kdeclarative) url sha256;
        };
      });
      kded = kprev.kded.overrideAttrs (oldAttrs: {
        inherit (sources.kded) pname version;
        src = pkgs.fetchurl {
          name = sources.kded.fname;
          inherit (sources.kded) url sha256;
        };
      });
      kdesu = kprev.kdesu.overrideAttrs (oldAttrs: {
        inherit (sources.kdesu) pname version;
        src = pkgs.fetchurl {
          name = sources.kdesu.fname;
          inherit (sources.kdesu) url sha256;
        };
      });
      kdnssd = kprev.kdnssd.overrideAttrs (oldAttrs: {
        inherit (sources.kdnssd) pname version;
        src = pkgs.fetchurl {
          name = sources.kdnssd.fname;
          inherit (sources.kdnssd) url sha256;
        };
      });
      kdoctools = kprev.kdoctools.overrideAttrs (oldAttrs: {
        inherit (sources.kdoctools) pname version;
        src = pkgs.fetchurl {
          name = sources.kdoctools.fname;
          inherit (sources.kdoctools) url sha256;
        };
      });
      kfilemetadata = kprev.kfilemetadata.overrideAttrs (oldAttrs: {
        inherit (sources.kfilemetadata) pname version;
        src = pkgs.fetchurl {
          name = sources.kfilemetadata.fname;
          inherit (sources.kfilemetadata) url sha256;
        };
        buildInputs = (oldAttrs.buildInputs or []) ++ [pkgs.kdePackages.kcodecs];
      });
      kglobalaccel = kprev.kglobalaccel.overrideAttrs (oldAttrs: {
        inherit (sources.kglobalaccel) pname version;
        src = pkgs.fetchurl {
          name = sources.kglobalaccel.fname;
          inherit (sources.kglobalaccel) url sha256;
        };
      });
      kguiaddons = kprev.kguiaddons.overrideAttrs (oldAttrs: {
        inherit (sources.kguiaddons) pname version;
        src = pkgs.fetchurl {
          name = sources.kguiaddons.fname;
          inherit (sources.kguiaddons) url sha256;
        };
      });
      kholidays = kprev.kholidays.overrideAttrs (oldAttrs: {
        inherit (sources.kholidays) pname version;
        src = pkgs.fetchurl {
          name = sources.kholidays.fname;
          inherit (sources.kholidays) url sha256;
        };
      });
      ki18n = kprev.ki18n.overrideAttrs (oldAttrs: {
        inherit (sources.ki18n) pname version;
        src = pkgs.fetchurl {
          name = sources.ki18n.fname;
          inherit (sources.ki18n) url sha256;
        };
      });
      kiconthemes = kprev.kiconthemes.overrideAttrs (oldAttrs: {
        inherit (sources.kiconthemes) pname version;
        src = pkgs.fetchurl {
          name = sources.kiconthemes.fname;
          inherit (sources.kiconthemes) url sha256;
        };
      });
      kidletime = kprev.kidletime.overrideAttrs (oldAttrs: {
        inherit (sources.kidletime) pname version;
        src = pkgs.fetchurl {
          name = sources.kidletime.fname;
          inherit (sources.kidletime) url sha256;
        };
      });
      kimageformats = kprev.kimageformats.overrideAttrs (oldAttrs: {
        inherit (sources.kimageformats) pname version;
        src = pkgs.fetchurl {
          name = sources.kimageformats.fname;
          inherit (sources.kimageformats) url sha256;
        };
      });
      kio = kprev.kio.overrideAttrs (oldAttrs: {
        inherit (sources.kio) pname version;
        src = pkgs.fetchurl {
          name = sources.kio.fname;
          inherit (sources.kio) url sha256;
        };
      });
      kirigami = kprev.kirigami.overrideAttrs (oldAttrs: {
        inherit (sources.kirigami) pname version;
        src = pkgs.fetchurl {
          name = sources.kirigami.fname;
          inherit (sources.kirigami) url sha256;
        };
      });
      kitemmodels = kprev.kitemmodels.overrideAttrs (oldAttrs: {
        inherit (sources.kitemmodels) pname version;
        src = pkgs.fetchurl {
          name = sources.kitemmodels.fname;
          inherit (sources.kitemmodels) url sha256;
        };
      });
      kitemviews = kprev.kitemviews.overrideAttrs (oldAttrs: {
        inherit (sources.kitemviews) pname version;
        src = pkgs.fetchurl {
          name = sources.kitemviews.fname;
          inherit (sources.kitemviews) url sha256;
        };
      });
      kjobwidgets = kprev.kjobwidgets.overrideAttrs (oldAttrs: {
        inherit (sources.kjobwidgets) pname version;
        src = pkgs.fetchurl {
          name = sources.kjobwidgets.fname;
          inherit (sources.kjobwidgets) url sha256;
        };
      });
      knewstuff = kprev.knewstuff.overrideAttrs (oldAttrs: {
        inherit (sources.knewstuff) pname version;
        src = pkgs.fetchurl {
          name = sources.knewstuff.fname;
          inherit (sources.knewstuff) url sha256;
        };
      });
      knotifications = kprev.knotifications.overrideAttrs (oldAttrs: {
        inherit (sources.knotifications) pname version;
        src = pkgs.fetchurl {
          name = sources.knotifications.fname;
          inherit (sources.knotifications) url sha256;
        };
      });
      knotifyconfig = kprev.knotifyconfig.overrideAttrs (oldAttrs: {
        inherit (sources.knotifyconfig) pname version;
        src = pkgs.fetchurl {
          name = sources.knotifyconfig.fname;
          inherit (sources.knotifyconfig) url sha256;
        };
      });
      kpackage = kprev.kpackage.overrideAttrs (oldAttrs: {
        inherit (sources.kpackage) pname version;
        src = pkgs.fetchurl {
          name = sources.kpackage.fname;
          inherit (sources.kpackage) url sha256;
        };
      });
      kparts = kprev.kparts.overrideAttrs (oldAttrs: {
        inherit (sources.kparts) pname version;
        src = pkgs.fetchurl {
          name = sources.kparts.fname;
          inherit (sources.kparts) url sha256;
        };
      });
      kpeople = kprev.kpeople.overrideAttrs (oldAttrs: {
        inherit (sources.kpeople) pname version;
        src = pkgs.fetchurl {
          name = sources.kpeople.fname;
          inherit (sources.kpeople) url sha256;
        };
      });
      kplotting = kprev.kplotting.overrideAttrs (oldAttrs: {
        inherit (sources.kplotting) pname version;
        src = pkgs.fetchurl {
          name = sources.kplotting.fname;
          inherit (sources.kplotting) url sha256;
        };
      });
      kpty = kprev.kpty.overrideAttrs (oldAttrs: {
        inherit (sources.kpty) pname version;
        src = pkgs.fetchurl {
          name = sources.kpty.fname;
          inherit (sources.kpty) url sha256;
        };
      });
      kquickcharts = kprev.kquickcharts.overrideAttrs (oldAttrs: {
        inherit (sources.kquickcharts) pname version;
        src = pkgs.fetchurl {
          name = sources.kquickcharts.fname;
          inherit (sources.kquickcharts) url sha256;
        };
      });
      krunner = kprev.krunner.overrideAttrs (oldAttrs: {
        inherit (sources.krunner) pname version;
        src = pkgs.fetchurl {
          name = sources.krunner.fname;
          inherit (sources.krunner) url sha256;
        };
      });
      kservice = kprev.kservice.overrideAttrs (oldAttrs: {
        inherit (sources.kservice) pname version;
        src = pkgs.fetchurl {
          name = sources.kservice.fname;
          inherit (sources.kservice) url sha256;
        };
      });
      kstatusnotifieritem = kprev.kstatusnotifieritem.overrideAttrs (oldAttrs: {
        inherit (sources.kstatusnotifieritem) pname version;
        src = pkgs.fetchurl {
          name = sources.kstatusnotifieritem.fname;
          inherit (sources.kstatusnotifieritem) url sha256;
        };
      });
      ksvg = kprev.ksvg.overrideAttrs (oldAttrs: {
        inherit (sources.ksvg) pname version;
        src = pkgs.fetchurl {
          name = sources.ksvg.fname;
          inherit (sources.ksvg) url sha256;
        };
      });
      ktexteditor = kprev.ktexteditor.overrideAttrs (oldAttrs: {
        inherit (sources.ktexteditor) pname version;
        src = pkgs.fetchurl {
          name = sources.ktexteditor.fname;
          inherit (sources.ktexteditor) url sha256;
        };
      });
      ktexttemplate = kprev.ktexttemplate.overrideAttrs (oldAttrs: {
        inherit (sources.ktexttemplate) pname version;
        src = pkgs.fetchurl {
          name = sources.ktexttemplate.fname;
          inherit (sources.ktexttemplate) url sha256;
        };
      });
      ktextwidgets = kprev.ktextwidgets.overrideAttrs (oldAttrs: {
        inherit (sources.ktextwidgets) pname version;
        src = pkgs.fetchurl {
          name = sources.ktextwidgets.fname;
          inherit (sources.ktextwidgets) url sha256;
        };
      });
      kunitconversion = kprev.kunitconversion.overrideAttrs (oldAttrs: {
        inherit (sources.kunitconversion) pname version;
        src = pkgs.fetchurl {
          name = sources.kunitconversion.fname;
          inherit (sources.kunitconversion) url sha256;
        };
      });
      kuserfeedback = kprev.kuserfeedback.overrideAttrs (oldAttrs: {
        inherit (sources.kuserfeedback) pname version;
        src = pkgs.fetchurl {
          name = sources.kuserfeedback.fname;
          inherit (sources.kuserfeedback) url sha256;
        };
      });
      kwallet = kprev.kwallet.overrideAttrs (oldAttrs: {
        inherit (sources.kwallet) pname version;
        src = pkgs.fetchurl {
          name = sources.kwallet.fname;
          inherit (sources.kwallet) url sha256;
        };
      });
      kwidgetsaddons = kprev.kwidgetsaddons.overrideAttrs (oldAttrs: {
        inherit (sources.kwidgetsaddons) pname version;
        src = pkgs.fetchurl {
          name = sources.kwidgetsaddons.fname;
          inherit (sources.kwidgetsaddons) url sha256;
        };
      });
      kwindowsystem = kprev.kwindowsystem.overrideAttrs (oldAttrs: {
        inherit (sources.kwindowsystem) pname version;
        src = pkgs.fetchurl {
          name = sources.kwindowsystem.fname;
          inherit (sources.kwindowsystem) url sha256;
        };
      });
      kxmlgui = kprev.kxmlgui.overrideAttrs (oldAttrs: {
        inherit (sources.kxmlgui) pname version;
        src = pkgs.fetchurl {
          name = sources.kxmlgui.fname;
          inherit (sources.kxmlgui) url sha256;
        };
      });
      modemmanager-qt = kprev.modemmanager-qt.overrideAttrs (oldAttrs: {
        inherit (sources.modemmanager-qt) pname version;
        src = pkgs.fetchurl {
          name = sources.modemmanager-qt.fname;
          inherit (sources.modemmanager-qt) url sha256;
        };
      });
      networkmanager-qt = kprev.networkmanager-qt.overrideAttrs (oldAttrs: {
        inherit (sources.networkmanager-qt) pname version;
        src = pkgs.fetchurl {
          name = sources.networkmanager-qt.fname;
          inherit (sources.networkmanager-qt) url sha256;
        };
      });
      prison = kprev.prison.overrideAttrs (oldAttrs: {
        inherit (sources.prison) pname version;
        src = pkgs.fetchurl {
          name = sources.prison.fname;
          inherit (sources.prison) url sha256;
        };
      });
      purpose = kprev.purpose.overrideAttrs (oldAttrs: {
        inherit (sources.purpose) pname version;
        src = pkgs.fetchurl {
          name = sources.purpose.fname;
          inherit (sources.purpose) url sha256;
        };
      });
      qqc2-desktop-style = kprev.qqc2-desktop-style.overrideAttrs (oldAttrs: {
        inherit (sources.qqc2-desktop-style) pname version;
        src = pkgs.fetchurl {
          name = sources.qqc2-desktop-style.fname;
          inherit (sources.qqc2-desktop-style) url sha256;
        };
        nativeBuildInputs = oldAttrs.nativeBuildInputs ++ [pkgs.qt6.qttools];
      });
      solid = kprev.solid.overrideAttrs (oldAttrs: {
        inherit (sources.solid) pname version;
        src = pkgs.fetchurl {
          name = sources.solid.fname;
          inherit (sources.solid) url sha256;
        };
      });
      sonnet = kprev.sonnet.overrideAttrs (oldAttrs: {
        inherit (sources.sonnet) pname version;
        src = pkgs.fetchurl {
          name = sources.sonnet.fname;
          inherit (sources.sonnet) url sha256;
        };
      });
      syndication = kprev.syndication.overrideAttrs (oldAttrs: {
        inherit (sources.syndication) pname version;
        src = pkgs.fetchurl {
          name = sources.syndication.fname;
          inherit (sources.syndication) url sha256;
        };
      });
      syntax-highlighting = kprev.syntax-highlighting.overrideAttrs (oldAttrs: {
        inherit (sources.syntax-highlighting) pname version;
        src = pkgs.fetchurl {
          name = sources.syntax-highlighting.fname;
          inherit (sources.syntax-highlighting) url sha256;
        };
      });
      threadweaver = kprev.threadweaver.overrideAttrs (oldAttrs: {
        inherit (sources.threadweaver) pname version;
        src = pkgs.fetchurl {
          name = sources.threadweaver.fname;
          inherit (sources.threadweaver) url sha256;
        };
      });
      bluedevil = kprev.bluedevil.overrideAttrs (oldAttrs: {
        inherit (sources.bluedevil) pname version;
        src = pkgs.fetchurl {
          name = sources.bluedevil.fname;
          inherit (sources.bluedevil) url sha256;
        };
      });
      breeze = kprev.breeze.overrideAttrs (oldAttrs: {
        inherit (sources.breeze) pname version;
        src = pkgs.fetchurl {
          name = sources.breeze.fname;
          inherit (sources.breeze) url sha256;
        };
      });
      breeze-gtk = kprev.breeze-gtk.overrideAttrs (oldAttrs: {
        inherit (sources.breeze-gtk) pname version;
        src = pkgs.fetchurl {
          name = sources.breeze-gtk.fname;
          inherit (sources.breeze-gtk) url sha256;
        };
      });
      drkonqi = kprev.drkonqi.overrideAttrs (oldAttrs: {
        inherit (sources.drkonqi) pname version;
        src = pkgs.fetchurl {
          name = sources.drkonqi.fname;
          inherit (sources.drkonqi) url sha256;
        };
      });
      kactivitymanagerd = kprev.kactivitymanagerd.overrideAttrs (oldAttrs: {
        inherit (sources.kactivitymanagerd) pname version;
        src = pkgs.fetchurl {
          name = sources.kactivitymanagerd.fname;
          inherit (sources.kactivitymanagerd) url sha256;
        };
      });
      kde-cli-tools = kprev.kde-cli-tools.overrideAttrs (oldAttrs: {
        inherit (sources.kde-cli-tools) pname version;
        src = pkgs.fetchurl {
          name = sources.kde-cli-tools.fname;
          inherit (sources.kde-cli-tools) url sha256;
        };
      });
      kdecoration = kprev.kdecoration.overrideAttrs (oldAttrs: {
        inherit (sources.kdecoration) pname version;
        src = pkgs.fetchurl {
          name = sources.kdecoration.fname;
          inherit (sources.kdecoration) url sha256;
        };
      });
      kde-gtk-config = kprev.kde-gtk-config.overrideAttrs (oldAttrs: {
        inherit (sources.kde-gtk-config) pname version;
        src = pkgs.fetchurl {
          name = sources.kde-gtk-config.fname;
          inherit (sources.kde-gtk-config) url sha256;
        };
      });
      kdeplasma-addons = kprev.kdeplasma-addons.overrideAttrs (oldAttrs: {
        inherit (sources.kdeplasma-addons) pname version;
        src = pkgs.fetchurl {
          name = sources.kdeplasma-addons.fname;
          inherit (sources.kdeplasma-addons) url sha256;
        };
      });
      kgamma = kprev.kgamma.overrideAttrs (oldAttrs: {
        inherit (sources.kgamma) pname version;
        src = pkgs.fetchurl {
          name = sources.kgamma.fname;
          inherit (sources.kgamma) url sha256;
        };
      });
      kglobalacceld = kprev.kglobalacceld.overrideAttrs (oldAttrs: {
        inherit (sources.kglobalacceld) pname version;
        src = pkgs.fetchurl {
          name = sources.kglobalacceld.fname;
          inherit (sources.kglobalacceld) url sha256;
        };
      });
      kinfocenter = kprev.kinfocenter.overrideAttrs (oldAttrs: {
        inherit (sources.kinfocenter) pname version;
        src = pkgs.fetchurl {
          name = sources.kinfocenter.fname;
          inherit (sources.kinfocenter) url sha256;
        };
        patches = [
          (pkgs.substituteAll {
            src = ./files/kinfocenter.patch;
            qdbus = "${lib.getBin pkgs.qt6Packages.qttools}/bin/qdbus";
            xdpyinfo = lib.getExe pkgs.xorg.xdpyinfo;
          })
        ];
      });
      kmenuedit = kprev.kmenuedit.overrideAttrs (oldAttrs: {
        inherit (sources.kmenuedit) pname version;
        src = pkgs.fetchurl {
          name = sources.kmenuedit.fname;
          inherit (sources.kmenuedit) url sha256;
        };
      });
      kpipewire = kprev.kpipewire.overrideAttrs (oldAttrs: {
        inherit (sources.kpipewire) pname version;
        src = pkgs.fetchurl {
          name = sources.kpipewire.fname;
          inherit (sources.kpipewire) url sha256;
        };
      });
      kscreen = kprev.kscreen.overrideAttrs (oldAttrs: {
        inherit (sources.kscreen) pname version;
        src = pkgs.fetchurl {
          name = sources.kscreen.fname;
          inherit (sources.kscreen) url sha256;
        };
      });
      kscreenlocker = kprev.kscreenlocker.overrideAttrs (oldAttrs: {
        inherit (sources.kscreenlocker) pname version;
        src = pkgs.fetchurl {
          name = sources.kscreenlocker.fname;
          inherit (sources.kscreenlocker) url sha256;
        };
      });
      ksshaskpass = kprev.ksshaskpass.overrideAttrs (oldAttrs: {
        inherit (sources.ksshaskpass) pname version;
        src = pkgs.fetchurl {
          name = sources.ksshaskpass.fname;
          inherit (sources.ksshaskpass) url sha256;
        };
      });
      ksystemstats = kprev.ksystemstats.overrideAttrs (oldAttrs: {
        inherit (sources.ksystemstats) pname version;
        src = pkgs.fetchurl {
          name = sources.ksystemstats.fname;
          inherit (sources.ksystemstats) url sha256;
        };
      });
      kwallet-pam = kprev.kwallet-pam.overrideAttrs (oldAttrs: {
        inherit (sources.kwallet-pam) pname version;
        src = pkgs.fetchurl {
          name = sources.kwallet-pam.fname;
          inherit (sources.kwallet-pam) url sha256;
        };
      });
      kwayland = kprev.kwayland.overrideAttrs (oldAttrs: {
        inherit (sources.kwayland) pname version;
        src = pkgs.fetchurl {
          name = sources.kwayland.fname;
          inherit (sources.kwayland) url sha256;
        };
      });
      kwin = kprev.kwin.overrideAttrs (oldAttrs: {
        inherit (sources.kwin) pname version;
        src = pkgs.fetchurl {
          name = sources.kwin.fname;
          inherit (sources.kwin) url sha256;
        };
      });
      kwrited = kprev.kwrited.overrideAttrs (oldAttrs: {
        inherit (sources.kwrited) pname version;
        src = pkgs.fetchurl {
          name = sources.kwrited.fname;
          inherit (sources.kwrited) url sha256;
        };
      });
      layer-shell-qt = kprev.layer-shell-qt.overrideAttrs (oldAttrs: {
        inherit (sources.layer-shell-qt) pname version;
        src = pkgs.fetchurl {
          name = sources.layer-shell-qt.fname;
          inherit (sources.layer-shell-qt) url sha256;
        };
      });
      libkscreen = kprev.libkscreen.overrideAttrs (oldAttrs: {
        inherit (sources.libkscreen) pname version;
        src = pkgs.fetchurl {
          name = sources.libkscreen.fname;
          inherit (sources.libkscreen) url sha256;
        };
      });
      libksysguard = kprev.libksysguard.overrideAttrs (oldAttrs: {
        inherit (sources.libksysguard) pname version;
        src = pkgs.fetchurl {
          name = sources.libksysguard.fname;
          inherit (sources.libksysguard) url sha256;
        };
      });
      libplasma = kprev.libplasma.overrideAttrs (oldAttrs: {
        inherit (sources.libplasma) pname version;
        src = pkgs.fetchurl {
          name = sources.libplasma.fname;
          inherit (sources.libplasma) url sha256;
        };
      });
      milou = kprev.milou.overrideAttrs (oldAttrs: {
        inherit (sources.milou) pname version;
        src = pkgs.fetchurl {
          name = sources.milou.fname;
          inherit (sources.milou) url sha256;
        };
      });
      ocean-sound-theme = kprev.ocean-sound-theme.overrideAttrs (oldAttrs: {
        inherit (sources.ocean-sound-theme) pname version;
        src = pkgs.fetchurl {
          name = sources.ocean-sound-theme.fname;
          inherit (sources.ocean-sound-theme) url sha256;
        };
      });
      plasma5support = kprev.plasma5support.overrideAttrs (oldAttrs: {
        inherit (sources.plasma5support) pname version;
        src = pkgs.fetchurl {
          name = sources.plasma5support.fname;
          inherit (sources.plasma5support) url sha256;
        };
      });
      plasma-activities = kprev.plasma-activities.overrideAttrs (oldAttrs: {
        inherit (sources.plasma-activities) pname version;
        src = pkgs.fetchurl {
          name = sources.plasma-activities.fname;
          inherit (sources.plasma-activities) url sha256;
        };
      });
      plasma-activities-stats = kprev.plasma-activities-stats.overrideAttrs (oldAttrs: {
        inherit (sources.plasma-activities-stats) pname version;
        src = pkgs.fetchurl {
          name = sources.plasma-activities-stats.fname;
          inherit (sources.plasma-activities-stats) url sha256;
        };
      });
      plasma-browser-integration = kprev.plasma-browser-integration.overrideAttrs (oldAttrs: {
        inherit (sources.plasma-browser-integration) pname version;
        src = pkgs.fetchurl {
          name = sources.plasma-browser-integration.fname;
          inherit (sources.plasma-browser-integration) url sha256;
        };
      });
      plasma-desktop = kprev.plasma-desktop.overrideAttrs (oldAttrs: {
        inherit (sources.plasma-desktop) pname version;
        src = pkgs.fetchurl {
          name = sources.plasma-desktop.fname;
          inherit (sources.plasma-desktop) url sha256;
        };
      });
      plasma-disks = kprev.plasma-disks.overrideAttrs (oldAttrs: {
        inherit (sources.plasma-disks) pname version;
        src = pkgs.fetchurl {
          name = sources.plasma-disks.fname;
          inherit (sources.plasma-disks) url sha256;
        };
      });
      plasma-integration = kprev.plasma-integration.overrideAttrs (oldAttrs: {
        inherit (sources.plasma-integration) pname version;
        src = pkgs.fetchurl {
          name = sources.plasma-integration.fname;
          inherit (sources.plasma-integration) url sha256;
        };
      });
      plasma-nano = kprev.plasma-nano.overrideAttrs (oldAttrs: {
        inherit (sources.plasma-nano) pname version;
        src = pkgs.fetchurl {
          name = sources.plasma-nano.fname;
          inherit (sources.plasma-nano) url sha256;
        };
      });
      plasma-nm = kprev.plasma-nm.overrideAttrs (oldAttrs: {
        inherit (sources.plasma-nm) pname version;
        src = pkgs.fetchurl {
          name = sources.plasma-nm.fname;
          inherit (sources.plasma-nm) url sha256;
        };
      });
      plasma-pa = kprev.plasma-pa.overrideAttrs (oldAttrs: {
        inherit (sources.plasma-pa) pname version;
        src = pkgs.fetchurl {
          name = sources.plasma-pa.fname;
          inherit (sources.plasma-pa) url sha256;
        };
        buildInputs = (oldAttrs.buildInputs or []) ++ [pkgs.kdePackages.pulseaudio-qt];
      });
      plasma-systemmonitor = kprev.plasma-systemmonitor.overrideAttrs (oldAttrs: {
        inherit (sources.plasma-systemmonitor) pname version;
        src = pkgs.fetchurl {
          name = sources.plasma-systemmonitor.fname;
          inherit (sources.plasma-systemmonitor) url sha256;
        };
      });
      plasma-workspace = kprev.plasma-workspace.overrideAttrs (oldAttrs: {
        inherit (sources.plasma-workspace) pname version;
        src = pkgs.fetchurl {
          name = sources.plasma-workspace.fname;
          inherit (sources.plasma-workspace) url sha256;
        };
      });
      plasma-workspace-wallpapers = kprev.plasma-workspace-wallpapers.overrideAttrs (oldAttrs: {
        inherit (sources.plasma-workspace-wallpapers) pname version;
        src = pkgs.fetchurl {
          name = sources.plasma-workspace-wallpapers.fname;
          inherit (sources.plasma-workspace-wallpapers) url sha256;
        };
      });
      polkit-kde-agent-1 = kprev.polkit-kde-agent-1.overrideAttrs (oldAttrs: {
        inherit (sources.polkit-kde-agent-1) pname version;
        src = pkgs.fetchurl {
          name = sources.polkit-kde-agent-1.fname;
          inherit (sources.polkit-kde-agent-1) url sha256;
        };
      });
      powerdevil = kprev.powerdevil.overrideAttrs (oldAttrs: {
        inherit (sources.powerdevil) pname version;
        src = pkgs.fetchurl {
          name = sources.powerdevil.fname;
          inherit (sources.powerdevil) url sha256;
        };
      });
      print-manager = kprev.print-manager.overrideAttrs (oldAttrs: {
        inherit (sources.print-manager) pname version;
        src = pkgs.fetchurl {
          name = sources.print-manager.fname;
          inherit (sources.print-manager) url sha256;
        };
      });
      qqc2-breeze-style = kprev.qqc2-breeze-style.overrideAttrs (oldAttrs: {
        inherit (sources.qqc2-breeze-style) pname version;
        src = pkgs.fetchurl {
          name = sources.qqc2-breeze-style.fname;
          inherit (sources.qqc2-breeze-style) url sha256;
        };
      });
      systemsettings = kprev.systemsettings.overrideAttrs (oldAttrs: {
        inherit (sources.systemsettings) pname version;
        src = pkgs.fetchurl {
          name = sources.systemsettings.fname;
          inherit (sources.systemsettings) url sha256;
        };
      });
      xdg-desktop-portal-kde = kprev.xdg-desktop-portal-kde.overrideAttrs (oldAttrs: {
        inherit (sources.xdg-desktop-portal-kde) pname version;
        src = pkgs.fetchurl {
          name = sources.xdg-desktop-portal-kde.fname;
          inherit (sources.xdg-desktop-portal-kde) url sha256;
        };
      });
      gwenview = kprev.gwenview.overrideAttrs (oldAttrs: {
        inherit (sources.gwenview) pname version;
        src = pkgs.fetchurl {
          name = sources.gwenview.fname;
          inherit (sources.gwenview) url sha256;
        };
      });
      yakuake = kprev.yakuake.overrideAttrs (oldAttrs: {
        inherit (sources.yakuake) pname version;
        src = pkgs.fetchurl {
          name = sources.yakuake.fname;
          inherit (sources.yakuake) url sha256;
        };
      });
      spectacle = kprev.spectacle.overrideAttrs (oldAttrs: {
        inherit (sources.spectacle) pname version;
        src = pkgs.fetchurl {
          name = sources.spectacle.fname;
          inherit (sources.spectacle) url sha256;
        };
      });
      okular = kprev.okular.overrideAttrs (oldAttrs: {
        inherit (sources.okular) pname version;
        src = pkgs.fetchurl {
          name = sources.okular.fname;
          inherit (sources.okular) url sha256;
        };
      });
      konsole = kprev.konsole.overrideAttrs (oldAttrs: {
        inherit (sources.konsole) pname version;
        src = pkgs.fetchurl {
          name = sources.konsole.fname;
          inherit (sources.konsole) url sha256;
        };
      });
      dolphin = kprev.dolphin.overrideAttrs (oldAttrs: {
        inherit (sources.dolphin) pname version;
        src = pkgs.fetchurl {
          name = sources.dolphin.fname;
          inherit (sources.dolphin) url sha256;
        };
      });
      kate = kprev.kate.overrideAttrs (oldAttrs: {
        inherit (sources.kate) pname version;
        src = pkgs.fetchurl {
          name = sources.kate.fname;
          inherit (sources.kate) url sha256;
        };
      });
      ark = kprev.ark.overrideAttrs (oldAttrs: {
        inherit (sources.ark) pname version;
        src = pkgs.fetchurl {
          name = sources.ark.fname;
          inherit (sources.ark) url sha256;
        };
      });
      kdeconnect-kde = kprev.kdeconnect-kde.overrideAttrs (oldAttrs: {
        inherit (sources.kdeconnect-kde) pname version;
        src = pkgs.fetchurl {
          name = sources.kdeconnect-kde.fname;
          inherit (sources.kdeconnect-kde) url sha256;
        };
      });
      kwalletmanager = kprev.kwalletmanager.overrideAttrs (oldAttrs: {
        inherit (sources.kwalletmanager) pname version;
        src = pkgs.fetchurl {
          name = sources.kwalletmanager.fname;
          inherit (sources.kwalletmanager) url sha256;
        };
      });
      kio-extras = kprev.kio-extras.overrideAttrs (oldAttrs: {
        inherit (sources.kio-extras) pname version;
        src = pkgs.fetchurl {
          name = sources.kio-extras.fname;
          inherit (sources.kio-extras) url sha256;
        };
      });
      kio-admin = kprev.kio-admin.overrideAttrs (oldAttrs: {
        inherit (sources.kio-admin) pname version;
        src = pkgs.fetchurl {
          name = sources.kio-admin.fname;
          inherit (sources.kio-admin) url sha256;
        };
      });
      kdegraphics-thumbnailers = kprev.kdegraphics-thumbnailers.overrideAttrs (oldAttrs: {
        inherit (sources.kdegraphics-thumbnailers) pname version;
        src = pkgs.fetchurl {
          name = sources.kdegraphics-thumbnailers.fname;
          inherit (sources.kdegraphics-thumbnailers) url sha256;
        };
      });
      baloo-widgets = kprev.baloo-widgets.overrideAttrs (oldAttrs: {
        inherit (sources.baloo-widgets) pname version;
        src = pkgs.fetchurl {
          name = sources.baloo-widgets.fname;
          inherit (sources.baloo-widgets) url sha256;
        };
      });
      ffmpegthumbs = kprev.ffmpegthumbs.overrideAttrs (oldAttrs: {
        inherit (sources.ffmpegthumbs) pname version;
        src = pkgs.fetchurl {
          name = sources.ffmpegthumbs.fname;
          inherit (sources.ffmpegthumbs) url sha256;
        };
      });
      libkexiv2 = kprev.libkexiv2.overrideAttrs (oldAttrs: {
        inherit (sources.libkexiv2) pname version;
        src = pkgs.fetchurl {
          name = sources.libkexiv2.fname;
          inherit (sources.libkexiv2) url sha256;
        };
      });
      kdegraphics-mobipocket = kprev.kdegraphics-mobipocket.overrideAttrs (oldAttrs: {
        inherit (sources.kdegraphics-mobipocket) pname version;
        src = pkgs.fetchurl {
          name = sources.kdegraphics-mobipocket.fname;
          inherit (sources.kdegraphics-mobipocket) url sha256;
        };
      });
      libkdcraw = kprev.libkdcraw.overrideAttrs (oldAttrs: {
        inherit (sources.libkdcraw) pname version;
        src = pkgs.fetchurl {
          name = sources.libkdcraw.fname;
          inherit (sources.libkdcraw) url sha256;
        };
      });
      kaccounts-integration = kprev.kaccounts-integration.overrideAttrs (oldAttrs: {
        inherit (sources.kaccounts-integration) pname version;
        src = pkgs.fetchurl {
          name = sources.kaccounts-integration.fname;
          inherit (sources.kaccounts-integration) url sha256;
        };
      });
      kde-inotify-survey = kprev.kde-inotify-survey.overrideAttrs (oldAttrs: {
        inherit (sources.kde-inotify-survey) pname version;
        src = pkgs.fetchurl {
          name = sources.kde-inotify-survey.fname;
          inherit (sources.kde-inotify-survey) url sha256;
        };
      });
      khelpcenter = kprev.khelpcenter.overrideAttrs (oldAttrs: {
        inherit (sources.khelpcenter) pname version;
        src = pkgs.fetchurl {
          name = sources.khelpcenter.fname;
          inherit (sources.khelpcenter) url sha256;
        };
      });
      dolphin-plugins = kprev.dolphin-plugins.overrideAttrs (oldAttrs: {
        inherit (sources.dolphin-plugins) pname version;
        src = pkgs.fetchurl {
          name = sources.dolphin-plugins.fname;
          inherit (sources.dolphin-plugins) url sha256;
        };
      });
      colord-kde = kprev.colord-kde.overrideAttrs (oldAttrs: {
        inherit (sources.colord-kde) pname version;
        src = pkgs.fetchurl {
          name = sources.colord-kde.fname;
          inherit (sources.colord-kde) url sha256;
        };
      });
      pulseaudio-qt = kprev.pulseaudio-qt.overrideAttrs (oldAttrs: {
        inherit (sources.pulseaudio-qt) pname version;
        src = pkgs.fetchurl {
          name = sources.pulseaudio-qt.fname;
          inherit (sources.pulseaudio-qt) url sha256;
        };
      });
      kio-fuse = kprev.kio-fuse.overrideAttrs (oldAttrs: {
        inherit (sources.kio-fuse) pname version;
        src = pkgs.fetchurl {
          name = sources.kio-fuse.fname;
          inherit (sources.kio-fuse) url sha256;
        };
      });
    });
  })
]
