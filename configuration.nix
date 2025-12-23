# 编辑此配置文件以定义系统上应安装的内容。
# 可以在 configuration.nix(5) 手册页和 NixOS 手册中找到帮助
# （通过运行 ‘nixos-help’ 访问）。

{ config, pkgs, ... }:

{
  imports =
    [ # 包含硬件扫描结果
      ./hardware-configuration.nix
    ];

  # 引导加载程序
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.supportedFilesystems = [ "ntfs" ];

  networking.hostName = "nixos"; # 定义主机名
  # networking.wireless.enable = true;  # 通过 wpa_supplicant 启用无线支持

  # 配置网络代理（如果需要）
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # 启用网络管理
  networking.networkmanager.enable = true;

  # 开启flake
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # 镜像源配置
  nix.settings = {
    substituters = [
      "https://mirrors.ustc.edu.cn/nix-channels/store?priority=10"
      "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store?priority=5"
      "https://cache.nixos.org/"
    ];
    # 增加下载缓冲区大小
    download-buffer-size = 524288000;
  };

  # 设置时区
  time.timeZone = "Asia/Shanghai";

  # 启用 X11 窗口系统
  services.xserver.enable = true;

  # 启用 GDM 显示管理器
  services.displayManager.gdm.enable = true;
  # 禁用 GNOME 桌面环境
  services.desktopManager.gnome.enable = false;

  # 配置 X11 键盘映射
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };


  # 为gnome视频软件使用openGl
  environment.sessionVariables = {
    GDK_GL = "gles";
  };

  # 启用 CUPS 打印服务
  services.printing.enable = true;

  # 启用 PipeWire 音频支持
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true; 
    # 如果你想使用 JACK 应用程序，请取消注释
    #jack.enable = true;
  };

  # 启用触摸板支持（大多数桌面管理器默认启用）
  # services.xserver.libinput.enable = true;

  # 定义用户账户。别忘了用 ‘passwd’ 设置密码。
  users.users.zhaozhan = {
    isNormalUser = true;
    description = "zhaozhan";
    # initialPassword = "zhao";
    extraGroups = [ "networkmanager" "wheel" "libvirtd" "qemu" "kvm" ];
    packages = with pkgs; [
    #  thunderbird
    ];
  };

  # 允许安装非自由软件
  nixpkgs.config.allowUnfree = true;

  # 禁用 Hyprland
  programs.hyprland.enable = false; 

  # Enable nix-ld for running unpatched dynamic binaries
  programs.nix-ld.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
   gnome-extension-manager
    gst_all_1.gst-plugins-base
    gst_all_1.gst-plugins-good
    gst_all_1.gst-plugins-bad
    gst_all_1.gst-plugins-ugly
  ];


  # Enable the OpenSSH daemon.
   services.openssh.enable = true;

  # This value determines the NixOS release from which the default
  system.stateVersion = "25.05"; # Did you read the comment?

}
