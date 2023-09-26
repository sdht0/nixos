{ config, pkgs, ... }:
{
  imports =
    [
      ./hardware-configuration.nix
    ];

  networking.hostName = "niximaeus";
  time.timeZone = "America/Toronto";
  i18n.defaultLocale = "en_CA.UTF-8";

  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 10;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/efi";
  boot.kernelParams = [ "quiet" ];
  hardware.cpu.intel.updateMicrocode = true;
  services.fwupd.enable = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;

  users.users.sdh = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [ "wheel" ];
  };

  services.xserver.enable = true;
  services.xserver.videoDrivers = [ "modesetting" ];
  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
    ];
  };
  services.xserver.libinput.enable = true;
  services.xserver.displayManager.sddm.enable = true;

  services.xserver.desktopManager.plasma5.enable = true;
  environment.plasma5.excludePackages = with pkgs.libsForQt5; [
    elisa
    oxygen
  ];
  xdg = {
    portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-kde
      ];
    };
  };

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
    jack.enable = true;
  };

  networking.networkmanager.enable = true;
  networking.firewall.enable = false;
  services.resolved = {
    enable = true;
    dnssec = "false";
    domains = [ "~." ];
    fallbackDns = [ "1.1.1.1#one.one.one.one" "1.0.0.1#one.one.one.one" ];
  };

  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  environment.systemPackages = with pkgs; [
    linux-firmware sof-firmware
    vlc
    yakuake konsole kate
    vim wget curl rsync git tmux htop ripgrep fzf eza peco sshfs
    firefox chromium
    vscode obsidian calibre tailscale
    ffmpeg
  ];
  programs.zsh.enable = true;
  environment.shells = with pkgs; [ zsh ];
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    meslo-lgs-nf
  ];
  services.openssh.enable = true;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}
