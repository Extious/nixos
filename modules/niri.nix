{ config, pkgs, ... }:

{

# niri设置
programs.niri.enable = true;

  environment.systemPackages = with pkgs; [
    fuzzel
    alacritty
    bibata-cursors
  ];

  environment.variables = {
    XCURSOR_THEME = "Bibata-Modern-Ice";
    XCURSOR_SIZE = "24";  
  };

  # 将配置文件链接到 /etc/xdg/niri/config.kdl，使 Niri 能读取到它
  environment.etc."xdg/niri/config.kdl".source = ../config.kdl;
}
