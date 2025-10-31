[
  {
    host = "nixos";
    user = "zhaozhan";
    extraOSModules = [ ./nixos/os.nix ];
    extraHomeModules = [ ./nixos/home.nix ];
    extraHomeArgs = {
      nixosVersion = "unstable";
      homeManagerVersion = "master";
    };
    publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKqbqHz5O4f6nBoki57c6hekVqUiO4hvSb9k771i61YS";
  }
]
