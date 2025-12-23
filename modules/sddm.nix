{ pkgs, ... }:

{
  # 启用 SDDM 显示管理器
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true; # 保持 Wayland 模式
    theme = "catppuccin-mocha-mauve";
    package = pkgs.kdePackages.sddm; # 使用 Qt6 版本的 SDDM 以获得更好的主题支持
  };

  environment.systemPackages = with pkgs; [
    (catppuccin-sddm.override {
      flavor = "mocha";
      font  = "Noto Sans";
      fontSize = "9";
      loginBackground = true;
    })
    # 某些主题可能依赖的库
    libsForQt5.qt5.qtgraphicaleffects
    kdePackages.qt5compat
    kdePackages.qtdeclarative
    kdePackages.qtsvg
  ];
}
