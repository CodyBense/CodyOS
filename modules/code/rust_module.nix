{  lib, config, pkgs, ... }:

{
    options = {
        rust_module.enable = lib.mkEnableOption "enables rust_module";
    };

    config = lib.mkIf config.rust_module.enable {
        environment.systemPackages = with pkgs; [
            cargo
        ];
    };
}
