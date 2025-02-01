{ pkgs, inputs, ... }:
{
  imports = [
    ../../../modules-lib/option-python.nix

    ../../../modules-lib/system-nix-common.nix
    ../../../modules-lib/system-nix-darwin.nix
  ];

  system.defaults.finder.AppleShowAllFiles = true;

  environment.systemPackages = with pkgs; [
    vim
    tmux
    ripgrep
    fzf
    eza
    jq
    aha
    starship
    peco
    bat
    dua
    ncdu
    duf
    fd
    gitFull
    htop
    bottom
    glances
    procs
  ];
  programs.zsh.enable = true;
  homebrew = {
    enable = true;
    onActivation = {
      upgrade = true;
      cleanup = "uninstall";
    };

    casks = [
      "utm"
      "iterm2"
      "zoom"
      "firefox"
      "google-chrome"
      "tor-browser"
      "font-hack-nerd-font"
    ];
  };

  system.configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;
  system.stateVersion = 4;
}
