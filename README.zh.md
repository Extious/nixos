# NixOS 配置

这是一个使用 Nix Flakes 管理系统和用户配置的 NixOS 配置仓库。

## 项目概述

本配置提供了一个完整的 NixOS 设置，包含以下特性：

- **窗口管理器**: Niri 与 Noctalia Shell 集成
- **显示管理器**: SDDM（使用 Catppuccin 主题）
- **显卡驱动**: NVIDIA 驱动支持
- **输入法**: Fcitx5 中文输入支持
- **虚拟化**: Docker 和 Libvirt (QEMU/KVM) 支持
- **用户管理**: 使用 Home Manager 管理用户特定配置
- **中文环境**: 完整的中文本地化和字体支持

## 项目结构

```
/etc/nixos/
├── flake.nix                    # Flake 配置和输入源
├── configuration.nix           # 主系统配置文件
├── hardware-configuration.nix  # 硬件特定配置（自动生成）
├── home.nix                    # Home Manager 用户配置
├── config.kdl                  # Niri 窗口管理器配置
└── modules/                    # 模块化配置文件
    ├── niri.nix               # Niri 窗口管理器设置
    ├── noctalia.nix           # Noctalia Shell 服务
    ├── nvidia.nix             # NVIDIA 驱动配置
    ├── chinese.nix            # 中文输入法和字体配置
    ├── virtualization.nix     # Docker 和 Libvirt 设置
    ├── sddm.nix               # SDDM 显示管理器
    └── programs.nix           # 系统程序和 v2raya
```

## 依赖项

本配置使用以下 Flake 输入：

- `nixpkgs`: NixOS 软件包（unstable 通道）
- `home-manager`: 用户环境管理
- `noctalia`: Niri 的 Noctalia Shell
- `quickshell`: Shell 集成（可选）

## 如何更新配置

修改任何配置文件后，请按照以下步骤应用更改：

### 1. 构建和测试配置

首先，构建配置以检查语法错误：

```bash
sudo nixos-rebuild build --flake /etc/nixos
```

### 2. 应用配置

如果构建成功，应用配置：

```bash
sudo nixos-rebuild switch --flake /etc/nixos
```

这将：
- 构建新的系统配置
- 切换到新的生成版本
- 立即应用所有更改

### 3. 替代方案：试运行

查看将要进行的更改而不实际应用：

```bash
sudo nixos-rebuild dry-run --flake /etc/nixos
```

### 4. 更新 Flake 输入

更新 Flake 输入（nixpkgs、home-manager 等）：

```bash
cd /etc/nixos
nix flake update
```

然后重新构建并切换：

```bash
sudo nixos-rebuild switch --flake /etc/nixos
```

### 5. 仅更新 Home Manager

如果只修改了 `home.nix` 或用户特定配置：

```bash
home-manager switch --flake /etc/nixos#zhaozhan
```

### 6. 回滚

如果出现问题，可以回滚到之前的生成版本：

```bash
sudo nixos-rebuild switch --rollback
```

或者从启动菜单引导到之前的生成版本。

## 常用配置文件

- **系统配置**: 编辑 `configuration.nix` 进行系统范围的设置
- **用户配置**: 编辑 `home.nix` 进行用户特定的软件包和设置
- **Niri 配置**: 编辑 `config.kdl` 进行窗口管理器设置
- **模块配置**: 编辑 `modules/` 目录中的文件进行特定功能配置

## 注意事项

- `hardware-configuration.nix` 文件是自动生成的。除非必要，否则不要手动编辑它。
- `modules/` 目录中的所有模块都会由 `flake.nix` 自动导入。
- 在应用重大更改之前，请确保在虚拟机中测试配置或进行备份。

