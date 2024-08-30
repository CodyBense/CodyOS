{ lib, ... }:
{
    imports = [
        ./code/python_module.nix
        ./code/go_module.nix
        ./code/rust_module.nix
        ./code/node_module.nix
    ];

    python_module.enable = lib.mkDefault true;
    go_module.enable = lib.mkDefault true;
    rust_module.enable = lib.mkDefault true;
    node_module.enable = lib.mkDefault true;

    environement.systemPackages = with pkgs; [
        gcc
    ];
}
