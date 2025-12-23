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
    yazi
    vscode
    clash-verge-rev
    qq
    (pkgs.callPackage "${pkgs.path}/pkgs/by-name/we/wechat/linux.nix" {
      pname = "wechat";
      version = "4.1.0.13";
      src = pkgs.fetchurl {
        url = "https://dldir1v6.qq.com/weixin/Universal/Linux/WeChatLinux_x86_64.AppImage";
        hash = "sha256-d/zdb69gmIcgAFCbWLKGfmD8ZFfuDlYdOy7vUJ7SiXc=";
      };
      meta = pkgs.wechat.meta;
    })
 ];
}
