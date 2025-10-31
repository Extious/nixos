# NixOS Configuration for zhaozhan

## 项目结构
```
.
|-- flake.nix                  # Flake 入口，聚合所有输出与模块
|-- flake.lock                 # 锁定上游依赖版本
|-- home/                      # Home Manager 设置入口与细部分层
|   |-- default.nix            # 定义用户 home 设置的主文件
|   |-- lib/                   # 共享函数库与辅助脚本
|   |-- programs/              # 依据用途拆分的程序配置
|   `-- tweaks/                # 颜色、壁纸等额外调优
|-- hosts/                     # 主机与用户映射
|   |-- hosts.nix              # 列出机器、用户与公钥
|   |-- default.nix            # 生成 NixOS 与 Home Manager 配置
|   `-- nixos/                 # 主机 nixos 的专属模块
|       |-- hardware-configuration.nix
|       |-- os.nix             # 主机专属的 NixOS 模块
|       `-- home.nix           # 主机专属的 Home Manager 模块
|-- modules/                   # 可重用的 NixOS / Home Manager 模块
|   `-- home-manager/          # 颜色、桌面、壁纸等自定义模块
|-- nix/                       # Nix 通用配置（channels、substituters 等）
|-- os/                        # 系统级模块（programs、system、stylix）
|-- overlays/                  # 针对 nixpkgs 的 overlay 定义
|-- pkgs/                      # 自制软件包、主题与配色
|-- secrets/                   # agenix 密钥与密文配置
`-- templates/                 # 可复用的 flake 模板
```

## 部署步骤
- **准备环境**：确保目标主机已启用 `flakes` 与 `nix-command`，并导入 `secrets` 中引用的私钥至 `root` 与 `zhaozhan` 的 `~/.ssh`。
- **获取项目**：
  ```bash
  git clone <repo-url> ~/nixos-config
  cd ~/nixos-config
  ```
- **部署系统**：使用 Flake 目标 `nixos` 套用 NixOS 配置。
  ```bash
  sudo nixos-rebuild switch --flake .#nixos
  ```
- **部署用户环境**：启用 `zhaozhan` 的 Home Manager 配置。
  ```bash
  nix run .#homeConfigurations.zhaozhan@nixos.activationPackage
  ```
- **管理密钥**：如需重新加密密钥，确保安装 `agenix` 并执行：
  ```bash
  agenix -e secrets/<name>.age
  ```
- **日常更新**：
  ```bash
  nix flake update
  sudo nixos-rebuild switch --flake .#nixos
  nix run .#homeConfigurations.zhaozhan@nixos.activationPackage
  ```
