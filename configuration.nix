{ config, pkgs, ... }:
{
  hardware.enableRedistributableFirmware = true;
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Hardware
  imports = [ ./niximaeus.nix ];
  services.fwupd.enable = true;
  hardware.logitech.wireless.enable = true;

  # System
  time.timeZone = "America/Toronto";
  i18n.defaultLocale = "en_CA.UTF-8";

  # Boot
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 10;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/efi";

  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelParams = [ "quiet" "nowatchdog" ];

  # Users
  users.users.artimaeus = {
    uid = 1000;
    group = "artimaeus";
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [ "wheel" ];
  };
  users.groups.artimaeus.gid = 1000;

  # Display
  hardware.opengl.enable = true;
  services.xserver = {
    enable = true;
    videoDrivers = [ "modesetting" ];
    libinput.enable = true;
    displayManager = {
      plasma5.enable = true;
      sddm.enable = true;
    };
  };
  environment.plasma5.excludePackages = with pkgs.plasma5Packages; [elisa oxygen];
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [ xdg-desktop-portal-kde ];
  };

  # Audio
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # Networking
  networking.networkmanager.enable = true;
  networking.firewall.enable = false;
  services.resolved = {
    enable = true;
    dnssec = "false";
    domains = [ "~." ];
    fallbackDns = [ "1.1.1.1#one.one.one.one" "1.0.0.1#one.one.one.one" ];
  };

  # System packages
  programs.zsh.enable = true;
  environment.shellAliases = { ls = null; l = null; ll = null; };
  environment.shells = with pkgs; [ zsh ];
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    meslo-lgs-nf
    jetbrains-mono
  ];
  environment.systemPackages = with pkgs; [
    linux-firmware sof-firmware
    intel-gpu-tools libva-utils
    yakuake konsole kate plasma5Packages.ksshaskpass plasma5Packages.kdeconnect-kde plasma5Packages.ffmpegthumbs
    vim wget curl rsync git tmux htop ripgrep fzf eza peco sshfs
    firefox-devedition-bin chromium thunderbird slack
    obsidian fava zotero
    ffmpeg vlc calibre mcomix
    activitywatch solaar syncthing
    vscode nil nixfmt
    rustup gcc gnumake jetbrains.rust-rover
    (pkgs.python3.withPackages (ps: with ps; [beancount pip jupyter notebook ipykernel]))
  ];
  services.tailscale.enable = true;
  services.mullvad-vpn = {
    enable = true;
    package = pkgs.mullvad-vpn;
  };
  systemd.services.mullvad-daemon.environment = {
    TALPID_NET_CLS_MOUNT_DIR= "/run/mullvad";
  };
  services.syncthing = {
    enable = true;
    systemService = false;
    user = "artimaeus";
    dataDir = "/home/artimaeus";
  };
  # services.openssh.enable = true;

  system.stateVersion = "23.05";
}
