{ lib, pkgs, config, ... }:
let
  cfg = config.services.p2pool;
in
with lib;
{
  options.services.p2pool = {
    enable = mkEnableOption "p2pool";

    package = mkOption {
      type = types.package;
      default = pkgs.p2pool;
      description = ''
        Package to use for p2pool daemon
      '';
    };

    settings = {
      wallet = mkOption {
        type = types.str;
        description = ''
          Wallet to deposit rewards to
        '';
      };

      address = mkOption {
        type = types.str;
        default = "127.0.0.1";
        description = ''
          Address to bind startum server to
        '';
      };

      port = mkOption {
        type = types.port;
        default = 3333;
        description = ''
          Port to use for stratum server
        '';
      };
    };
  };

  config = mkIf (cfg.enable) {
    systemd.services.p2pool = {
      wantedBy = [ "multi-user.target" ];
      after = [ "network.target" ];
      description = "Monero P2P pool";
      serviceConfig = {
        ExecStart = with cfg.settings; ''${cfg.package}/bin/p2pool --host ${address} --port ${toString port} --wallet ${wallet}'';
      };
    };

    networking.firewall.allowedTCPPorts = [
      37888
      37889
    ] ++ (with cfg.settings; lib.lists.optional (address == "127.0.0.1") port);
  };
}
