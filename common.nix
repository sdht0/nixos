{ config, pkgs, ... }:
{
  hardware.enableRedistributableFirmware = true;
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Hardware
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
  # Additional setup for user:
  # 1. Get ssh keys, ~/.bashrc, ~/.bash_history
  # 2. git clone git@github.com:sdht0/dotfiles.git ; git submodule update --recursive --remote ; bash ./setup.sh

  # Display
  hardware.opengl.enable = true;
  services.xserver = {
    enable = true;
    videoDrivers = [ "modesetting" ];
  };
  services.xserver.libinput.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;
  services.xserver.displayManager.sddm.enable = true;
  environment.plasma5.excludePackages = with pkgs.plasma5Packages; [elisa oxygen];
  # Additional setup for plasma: panels, shortcuts, ssh agent, autostart, wallpapers
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
    noto-fonts noto-fonts-cjk noto-fonts-emoji
    jetbrains-mono meslo-lgs-nf
  ];
  environment.systemPackages = with pkgs; [
    linux-firmware sof-firmware
    intel-gpu-tools libva-utils
    yakuake konsole kate libnotify xclip
    plasma5Packages.ksshaskpass plasma5Packages.kdeconnect-kde plasma5Packages.ffmpegthumbs
    libsForQt5.qt5.qtimageformats
    vim gnupg wget curl rsync git tmux htop ripgrep fzf eza peco sshfs
    firefox-devedition-bin chromium thunderbird slack
    obsidian fava zotero
    ffmpeg vlc calibre mcomix
    activitywatch solaar syncthing
    vscode nil nixfmt nix-output-monitor
    rustup gcc gnumake jetbrains.rust-rover
    (pkgs.python3.withPackages (ps: with ps; [
        beancount pip jupyter notebook ipykernel
    ]))
  ];
  services.tailscale.enable = true;
  # Additional setup for tailscale:
  # 1. Login: sudo tailscale login
  # 2. On signing node: a) Add new node: sudo tailscale lock sign ... ; b) Make it a signing node: sudo tailscale lock add ...
  # 3. On web: disable key expiry, add tag
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
