{
  config,
  pkgs,
  ...
}:
{
  services.dae = {
    enable = true;
    configFile = "/home/zhaozhan/config/dae/config.dae";
  };
}
