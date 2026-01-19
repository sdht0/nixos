{ pkgs, ... }:
{
  services.ollama.enable = true;
  services.ollama.package = pkgs.ollama-rocm;
  services.ollama.host = "0.0.0.0";
}
