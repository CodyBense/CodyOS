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

        ../../modules/home/git.nix
        ../../modules/home/kitty.nix
        ../../modules/home/starship.nix
        ../../modules/home/zshrc.nix
        ../../modules/home/firefox.nix
        ../../modules/home/fzf.nix
        ../../modules/home/direnv.nix
        ../../modules/home/lf.nix
        ../../modules/home/tmux.nix
        ../../modules/home/hyprlock.nix
        ../../modules/home/gtk-qt/default.nix
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
        (import ../../scripts/randomPokemon.nix {inherit pkgs;})
        (import ../../scripts/start-hyprland.nix {inherit pkgs;})
        (import ../../scripts/change-wallpaper.nix {inherit pkgs;})
        (import ../../scripts/list-hypr-bindings.nix {inherit pkgs;})
        (import ../../scripts/rofi-launch.nix {inherit pkgs;})
        (import ../../scripts/rofi-wifi.nix {inherit pkgs;})
        (import ../../scripts/wallsetter.nix {
            inherit pkgs;
            inherit username;
        })
        (import ../../scripts/themechange.nix {
            inherit pkgs;
            inherit host;
            inherit username;
        })
        (import ../../scripts/theme-selector.nix {inherit pkgs;})
        (import ../../scripts/task-waybar.nix {inherit pkgs;})
        (import ../../scripts/web-search.nix {inherit pkgs;})
        (import ../../scripts/emojipicker.nix {inherit pkgs;})
    ];

# Let Home Manager install and manage itself.
    programs.home-manager.enable = true;
}
