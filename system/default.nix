{ ... }: {
  imports = [
    ./networking.nix
    ./monero.nix
  ];

  system.stateVersion = "23.11";
}
