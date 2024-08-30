# PROGRAMS to get to dotfile configuration control
{  pkgs,  username, host, inputs, ... }:
let
    inherit (import ./variables/nix) gitUsername gitEmail;
in
{
    # Home Manager settings
    home.username = "${username}";
    home.homeDirectory = "/home/${username}";
    home.stateVersion = "23.11"; # Please read the comment before changing.

    # Import Program Configurations
    imports = [
        inputs.hyprland.homeManagerModules.default
        ../../config/emoji.nix
        ../../config/fastfetch
        ../../config/hyprland.nix
        ../../config/rofi/rofi.nix
        ../../config/rofi/config-emoji.nix
        ../../config/rofi/config-long.nix
        ../../config/swaync.nix
        ../../config/waybar.nix
        ../../config/wlogout.nix

        ../../modules/home_bundle.nix
    ];

    # Place Files Inside Home Directory
    home.file."Pictures/Wallpapers" = {
        source = ../../config/wallpapers;
        recursive = true;
    };
    home.file.".config/wlogout/icons" = {
        source = ../../config/wlogout;
        recursive = true;
    };
    home.file.".config/starship.toml".source = ../../config/starship.toml;

    xdg = {
        userDirs = {
            enable = true;
            createDirectories = true;
        };
    };

    stylix.targets.waybar.enable = false;
    stylix.targets.rofi.enable = false;
    stylix.targets.hyprland.enable = false;
    stylix.targets.neovim.enable = false;
    # Scripts
    home.packages = [
        (import ../../scripts/emojipicker.nix {inherit pkgs;})
        (import ../../scripts/list-hypr-bindings.nix {inherit pkgs;})
        (import ../../scripts/randomPokemon.nix {inherit pkgs;})
        (import ../../scripts/rofi-launch.nix {inherit pkgs;})
        (import ../../scripts/start-hyprland.nix {inherit pkgs;})
        (import ../../scripts/task-waybar.nix {inherit pkgs;})
        (import ../../scirpts/w2pc.nix {inherit pkgs;})
        (import ../../scripts/wallsetter.nix {
            inherit pkgs;
            inherit username;
        })
        (import ../../scripts/web-search.nix {inherit pkgs;})
    ];

# Let Home Manager install and manage itself.
    programs.home-manager.enable = true;
}
