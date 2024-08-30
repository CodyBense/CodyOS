{  lib, config, pkgs, ... }:

{
    options = {
        go_module.enable = lib.mkEnableOption "enables go_module";
    };

    config = lib.mkIf config.go_module.enable {
        environment.systemPackages = with pkgs; [
            go
        ];
    };
}
