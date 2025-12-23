{ config, pkgs, ... }:

{
  # 安装 Firefox
  programs.firefox.enable = true;

  # 安装 Flatpak
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
