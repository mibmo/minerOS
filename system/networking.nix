{ ... }: {
  networking = {
    hostName = "xmrOS";
    wireless.enable = false;
    networkmanager = {
      enable = true;
      firewallBackend = "nftables";
      insertNameservers = [
        # Quad9
        "9.9.9.9"
        "149.112.112.112"
        "2620:fe::fe"
        "2620:fe::9"

        # Cloudflare
        "1.1.1.1"
        "1.0.0.1"
        "2606:4700:4700::1111"
        "2606:4700:4700::1001"

        # Google
        "8.8.8.8"
        "8.8.4.4"
        "2001:4860:4860::8888"
        "2001:4860:4860::8844"
      ];
    };
    nftables.enable = true;
    firewall = {
      enable = true;
    };
  };
}
