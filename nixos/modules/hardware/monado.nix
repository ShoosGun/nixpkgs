{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.hardware.monado;
in
{
  meta.maintainers = with lib.maintainers; [ Scrumplex expipiplus1 prusnak ];

  options = {
    hardware.monado = {
      enable = mkOption {
        default = false;
        type = types.bool;
        description = lib.mdDoc ''
          Enable Monado udev rules
        '';
      };

      package = mkPackageOption pkgs "monado" { };

    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];
    services.udev.packages = [ cfg.package ];
  };
}
