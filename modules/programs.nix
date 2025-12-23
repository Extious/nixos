{ config, pkgs, ... }:

{
  # 安装 Firefox
  programs.firefox.enable = true;

  # 安装 Flatpak
  services.flatpak.enable = true;

  # 启用 v2raya 服务
  services.v2raya.enable = true;
  
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
    yazi
    vscode
    v2raya
    qq
    gemini-cli
    
    # Screenshot tools
    grim
    slurp
    wl-clipboard
 ];

  # 修复 Electron/Chromium 应用在 Wayland 下的问题
  environment.variables.NIXOS_OZONE_WL = "1";
}
