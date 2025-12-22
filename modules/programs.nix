{ config, pkgs, ... }:

{
# Install firefox.
  programs.firefox.enable = true;

# 安装  flatpak
  services.flatpak.enable = true;
  
  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    starship
    kitty
    fastfetch
    nerd-fonts.jetbrains-mono
    helix
    btop
    cmatrix
    obsidian
    yazi
    vscode
 ];
}
