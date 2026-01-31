# NixOS Configuration

This is a NixOS configuration repository using Nix Flakes for managing system and user configurations.

## Project Overview

This configuration provides a complete NixOS setup with the following features:

- **Window Manager**: Niri with Noctalia Shell integration
- **Display Manager**: SDDM with Catppuccin theme
- **Graphics**: NVIDIA driver support
- **Input Method**: Fcitx5 with Chinese input support
- **Virtualization**: Docker and Libvirt (QEMU/KVM) support
- **User Management**: Home Manager for user-specific configurations
- **Chinese Environment**: Full Chinese locale and font support

## Project Structure

```
/etc/nixos/
├── flake.nix                    # Flake configuration and inputs
├── configuration.nix           # Main system configuration
├── hardware-configuration.nix  # Hardware-specific configuration (auto-generated)
├── home.nix                    # Home Manager user configuration
├── config.kdl                  # Niri window manager configuration
└── modules/                    # Modular configuration files
    ├── niri.nix               # Niri window manager setup
    ├── noctalia.nix           # Noctalia Shell service
    ├── nvidia.nix             # NVIDIA driver configuration
    ├── chinese.nix            # Chinese input method and fonts
    ├── virtualization.nix     # Docker and Libvirt setup
    ├── sddm.nix               # SDDM display manager
    └── programs.nix           # System programs and v2raya
```

## Dependencies

This configuration uses the following Flake inputs:

- `nixpkgs`: NixOS packages (unstable channel)
- `home-manager`: User environment management
- `noctalia`: Noctalia Shell for Niri
- `quickshell`: Shell integration (optional)

## How to Update Configuration

After modifying any configuration files, follow these steps to apply changes:

### 1. Build and Test Configuration

First, build the configuration to check for syntax errors:

```bash
sudo nixos-rebuild build --flake /etc/nixos
```

### 2. Apply Configuration

If the build succeeds, apply the configuration:

```bash
sudo nixos-rebuild switch --flake /etc/nixos
```

This will:
- Build the new system configuration
- Switch to the new generation
- Apply all changes immediately

### 3. Alternative: Dry Run

To see what would change without applying:

```bash
sudo nixos-rebuild dry-run --flake /etc/nixos
```

### 4. Update Flake Inputs

To update the Flake inputs (nixpkgs, home-manager, etc.):

```bash
cd /etc/nixos
nix flake update
```

Then rebuild and switch:

```bash
sudo nixos-rebuild switch --flake /etc/nixos
```

### 5. Update Home Manager Only

If you only modified `home.nix` or user-specific configurations:

```bash
home-manager switch --flake /etc/nixos#zhaozhan
```

### 6. Rollback

If something goes wrong, you can rollback to the previous generation:

```bash
sudo nixos-rebuild switch --rollback
```

Or boot into a previous generation from the boot menu.

## Common Configuration Files

- **System Configuration**: Edit `configuration.nix` for system-wide settings
- **User Configuration**: Edit `home.nix` for user-specific packages and settings
- **Niri Configuration**: Edit `config.kdl` for window manager settings
- **Module Configuration**: Edit files in `modules/` directory for specific features

## Notes

- The `hardware-configuration.nix` file is auto-generated. Do not manually edit it unless necessary.
- All modules in the `modules/` directory are automatically imported by `flake.nix`.
- Make sure to test configurations in a VM or have a backup before applying major changes.

