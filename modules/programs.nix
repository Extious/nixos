{ config, pkgs, ... }:

{
  # 启用 v2raya 服务
  services.v2raya.enable = true;
  
  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    v2raya
    xdg-user-dirs
    xdg-utils
 ];

  # 修复 Electron/Chromium 应用在 Wayland 下的问题
  environment.variables.NIXOS_OZONE_WL = "1";
}
