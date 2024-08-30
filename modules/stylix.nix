{ pkgs, ... }:
{
    stylix = {
        enable = true;
        base16Scheme = {
            base00 = "282828"; # ----
            base01 = "3c3836"; # ---
            base02 = "504945"; # --
            base03 = "665c54"; # -
            base04 = "bdae93"; # +
            base05 = "d5c4a1"; # ++
            base06 = "ebdbb2"; # +++
            base07 = "fbf1c7"; # ++++
            base08 = "fb4934"; # red
            base09 = "fe8019"; # orange
            base0A = "fabd2f"; # yellow
            base0B = "b8bb26"; # green
            base0C = "8ec07c"; # aqua/cyan
            base0D = "83a598"; # blue
            base0E = "d3869b"; # purple
            base0F = "d65d0e"; # brown
        };
        image = ../../config/wallpapers/gruvbox-rainbow-nix.png;
        polarity = "dark";
        cursor.package = pkgs.bibata-cursors;
        cursor.name = "Bibata-Modern-Ice";
        cursor.size = 24;
        fonts = {
            monospace = {
                package = pkgs.nerdfonts.override {fonts = ["JetBrainsMono"];};
                name = "JetBrainsMono Nerd Font Mono";
            };
            sansSerif = {
                package = pkgs.dejavu_fonts;
                name = "Dejavu Sans";
            };
            serif = {
                package = pkgs.dejavu_fonts;
                name = "Dejavu Serif";
            };
            sizes = {
                applications = 14;
                terminal = 14;
                desktop = 14;
                popups = 14;
            };
        };
        opacity = {
            applications = 1.0;
            terminal = 0.60;
            desktop = 1.0;
            popups = 1.0;
        };
    };
}
