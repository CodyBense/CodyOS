{  lib, config, pkgs, ... }:

{

    options = {
        node_module.enable = lib.mkEnableOption "enables node_module";
    };

    config = lib.mkIf config.node_module.enable {
        environment.systemPackages = with pkgs; [
            # nodejs_21
            nodejs
        ];
    };
}
