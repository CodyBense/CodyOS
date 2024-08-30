{  lib, config, pkgs, ... }:

{
    options = {
        python_module.enable = lib.mkEnableOption "enables python_module";
    };

    config = lib.mkIf config.python_module.enable {
        environment.systemPackages = with pkgs; [
            python3
            ## List of python packages to pull from
            # python311Packages.pymysql
            # python311Packages.mysql-connector
            # python311Packages.typer
            # python311Packages.inquirer
            # python311Packages.dbus-python
            # python311Packages.pygobject3
        ];
    };
}
