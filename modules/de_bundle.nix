{ pkgs, lib, ... }: {
    imports = [
        ./de/hyprland_module.nix
        ./de/nvidia_module.nix
    ];

    hyprland_module.enable = lib.mkDefault true;
    nvidia_module.enable = lib.mkDefault false;
} 
