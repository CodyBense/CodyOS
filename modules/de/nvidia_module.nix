{ lib, config, pkgs, ...}:
{
        options = {
            nvidia_module.enable = lib.mkEnableOption "enables nvidia_module"; 
        };

        config = lib.mkIf config.nvidia_module.enable{
            hardware.opengl = {
                enable = true;
                driSupport32Bit = true;
        };

        # Load nvidia driver
        services.xserver.videoDrivers = ["nvidia"];

        hardware.nvidia = {
            modesetting.enable = true;
            powerManagement.enable = true;
            powerManagement.finegrained = false;
            open = false;
            nvidiaSettings = true;
            package = config.boot.kernelPackages.nvidiaPackages.stable;
        };
    };
}
