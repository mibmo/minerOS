{ config, settings, ... }: {
  services = {
    p2pool = {
      enable = true;
      settings = {
        inherit (settings) wallet;
      };
    };

    xmrig = {
      enable = true;
      settings = {
        autosave = true;
        cpu = true;
        opencl = false;
        cuda = false;
        donate-level = 0;
        pools = map
          (pool:
            if pool == "p2pool" then {
              url = with config.services.p2pool.settings; "${address}:${toString port}";
              keepalive = true;
              tls = false;
            } else pool)
          settings.pools;
      };
    };
  };
}
