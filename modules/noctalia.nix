{ pkgs, inputs, ... }: {
  environment.systemPackages = with pkgs; [
    inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default 
    # ... 可能还有其他软件包
  ];
  systemd.user.services.notalia-shell = {
    description = "Noctalia Shell for Niri";
    wantedBy = [ "graphical-session.target" ];
    partOf = [ "graphical-session.target" ];
    serviceConfig = {
    ExecStart = "${inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default}/bin/noctalia-shell";
    Restart = "always";
    RestartSec = "2";
    };
  };
}

