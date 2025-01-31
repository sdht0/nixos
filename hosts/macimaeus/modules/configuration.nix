{ pkgs, inputs, ... }:
{
  imports = [
    ../../../modules-lib/system-nix-common.nix
    ../../../modules-lib/system-nix-darwin.nix
    ../../../modules-lib/pkgs-nixdev.nix
  ];

  security.pam.enableSudoTouchIdAuth = true;
  system.defaults.finder.AppleShowAllFiles = true;

  environment.systemPackages = with pkgs; [
    tmux
    gitFull
    ripgrep
    fzf
    eza
    aha
    jq
    peco
    (pkgs.python3.withPackages (
      ps: with ps; [
        notebook
        pandas
      ]
    ))
  ];
  programs.zsh.enable = true;
  homebrew = {
    enable = true;
    onActivation = {
      upgrade = true;
      cleanup = "uninstall";
    };

    casks = [
      "zoom"
      "utm"
      "rustrover"
      "visual-studio-code"
      "firefox"
      "google-chrome"
      "iterm2"
      "font-hack-nerd-font"
    ];
  };

  system.configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;
  system.stateVersion = 4;
}
