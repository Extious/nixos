{ config, pkgs, inputs, ... }:

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

  # 将配置文件链接到 /etc/xdg/niri/config.kdl
  # 这样配置会随 NixOS 系统部署自动生效，无需手动建立软链接
  environment.etc."xdg/niri/config.kdl".source = "${inputs.self}/config.kdl";

  # 强制将用户配置文件链接到系统配置，防止 Niri 自动生成默认配置覆盖它
  systemd.user.tmpfiles.rules = [
    "L+ %h/.config/niri/config.kdl - - - - /etc/xdg/niri/config.kdl"
  ];
}
