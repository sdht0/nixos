{
  ...
}:
{
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      upgrade = true;
      cleanup = "zap";
    };
    global.autoUpdate = false;

    casks = [
      "utm"
      "iterm2"
      "zoom"
      "firefox"
      "tor-browser"
      "font-jetbrains-mono-nerd-font"
      "stats"
      "ollama-app"
    ];
    greedyCasks = true;
  };
}
