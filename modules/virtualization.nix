# virtualization.nix
{pkgs, ...}: {
  # 只能启用 docker 或 podman 其中之一 -- 不能同时启用
  virtualisation = {
    docker = {
      enable = true;
    };

    podman.enable = false;

    libvirtd = {
      enable = true;
      onBoot = "start";
      onShutdown = "shutdown";
      qemu = {
        runAsRoot = false;
        swtpm.enable = true; # TPM 模拟
        verbatimConfig = ''
          user = "qemu-libvirtd"
          group = "kvm"
          dynamic_ownership = 1
          remember_owner = 0
        '';
      };
      allowedBridges = [
        "virbr0" # 默认 NAT 网桥
        "br0" # 自定义网桥（如果需要）
      ];
    };

    # 内核模块以提高虚拟机性能
    spiceUSBRedirection.enable = true;
  };

  programs = {
    virt-manager.enable = true;
    dconf.enable = true; # virt-manager 设置需要
  };

  environment.systemPackages = with pkgs; [
    virt-viewer # 查看虚拟机
    lazydocker
    docker-client
    qemu_kvm # KVM 支持
    OVMF # UEFI 固件
    swtpm # TPM 模拟
    libguestfs # 虚拟机磁盘工具
    virt-top # 监控虚拟机性能
    spice # SPICE 协议支持
    spice-gtk # SPICE 客户端 GTK
    spice-protocol # SPICE 协议头
    virglrenderer # 虚拟 GPU 支持
    mesa # 虚拟机的 OpenGL 支持
  ];

  # 启用必要的内核模块以提高虚拟机性能
  boot.kernelModules = ["kvm-intel" "vfio-pci"];

  # 添加启动内核参数以获得更好的图形支持
  boot.kernelParams = [
    "intel_iommu=on"
    "iommu=pt"
  ];

  # 启用 OpenGL 支持
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # 创建具有正确权限的默认 ISO 和 VM 目录
  systemd.tmpfiles.rules = [
    "d /var/lib/libvirt/isos 0755 qemu-libvirtd kvm -"
    "d /var/lib/libvirt/images 0755 qemu-libvirtd kvm -"
  ];
}
