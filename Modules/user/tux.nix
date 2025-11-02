{ config, pkgs, ... }:
{
  users.users.zhaozhan = {
    isNormalUser = true;
    description = "zhaozhan";
    extraGroups = [
      "wheel"
      "libvirtd"
    ]; # Sudo access
    shell = pkgs.fish;
    home = "/home/zhaozhan";
  };
}
