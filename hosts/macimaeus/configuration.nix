{ pkgs, inputs, ... }: {
  imports = [
    ../../modules/darwin/system-nix.nix
    ../../modules/pkgs-nixdev.nix
    ./work.nix
  ];

  security.pam.enableSudoTouchIdAuth = true;

  environment.systemPackages = with pkgs; [
    tmux
    gitFull
    (pkgs.python3.withPackages (ps: with ps; [
        notebook pandas
    ]))
  ];
  programs.zsh.enable = true;
  homebrew = {
    enable = true;
    onActivation = {
      upgrade = true;
      cleanup = "uninstall";
    };

    casks = [
      "visual-studio-code"
      "firefox"
      "google-chrome"
      "utm"
      "iterm2"
      "activitywatch"
    ];
  };

  system.configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;
  system.stateVersion = 4;
}
