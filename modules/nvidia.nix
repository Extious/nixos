{ config, pkgs, ... }:

{
  # 启用 NVIDIA 驱动
  hardware.nvidia = {
    # Modesetting is required.
    modesetting.enable = true;
    powerManagement.enable = true; # 休眠后唤醒不会花屏
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  # 加载 Xorg 和 Wayland 的 Nvidia 驱动
  services.xserver.videoDrivers = ["nvidia"];

}