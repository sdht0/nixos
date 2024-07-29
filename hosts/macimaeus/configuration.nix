{ pkgs, inputs, ... }: {
  imports = [
    ../../modules/darwin/system-nix.nix
    ../../modules/pkgs-nixdev.nix
  ];

  environment.systemPackages = with pkgs; [
    tmux gitFull
    python3
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
    ];
  };

  system.configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;
  system.stateVersion = 4;
}
