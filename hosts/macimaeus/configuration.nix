{ pkgs, inputs, ... }: {
  imports = [
    ../../modules/darwin/system-nix.nix
    ../../modules/pkgs-nixdev.nix
  ];

  security.pam.enableSudoTouchIdAuth = true;

  environment.systemPackages = with pkgs; [
    tmux
    gitFull
    python3
    cmake
    awscli2
  ];
  programs.zsh.enable = true;
  homebrew = {
    enable = true;

    casks = [
      "visual-studio-code"
      "slack"
      "firefox"
      "google-chrome"
      "utm"
      "zoom"
      "rustrover"
      "docker"
      "iterm2"
      "activitywatch"
    ];
  };

  system.configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;
  system.stateVersion = 4;
}
