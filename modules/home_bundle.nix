{ lib, pkgs, spicetify-nix, ... }:
let
    spicePkgs = spicetify-nix.packages.${pkgs.system}.default;
in
{
    # allow spotify to be installed if you don't have unfree enabled already
    nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
        "spotify"
    ];

    # import the flake's module for your system
    imports = [ spicetify-nix.homeManagerModule ];

    # zsh
    programs.zsh = {
        enable = true;
        enableCompletion = true;
        autosuggestion.enable = true;
        syntaxHighlighting.enable = true;

        initExtra = ''
            randomPokemon
            '';

        initExtraFirst = ''
            HISTFILE=~/.histfile
            HISTSIZE=1000
            SAVEHIST=1000
            eval "$(zoxide init zsh)"
            eval "$(direnv hook zsh)"
            eval "$(starship init zsh)"
            export PATH=$PATH:$HOME/go/bin
            '';

        envExtra = ''
            '';

        shellAliases = {
            c = "clear";
            v = "nvim";
            sv = "sudo nvim";
            ll = "ls -l";
            la = "ls -a";
            ".." = "cd ..";
            "2." = "cd ../..";
            "3." = "cd ../../..";
            "4." = "cd ../../../..";
            py = "python3";
        };
    };

    # starship
    programs.starship = {
        enable = true;
        package = pkgs.starship;
        enableZshIntegration = true;
    };


    # spicetify
    programs.spicetify =
    {
        enable = true;
        theme = spicePkgs.themes.Onepunch;

        enabledExtensions = with spicePkgs.extensions; [
            fullAppDisplay
                keyboardShortcut
                bookmark
                loopyLoop
                popupLyrics
                shuffle
                powerBar
                playlistIcons
                playlistIntersection
                skipStats
                songStats
                history
                fullScreen
                historyShortcut
        ];
    };
    # lfrc
    home.file = {
        ".config/lf/lfrc" = {
            source = ../../config/lf/lfrc;
        };
    };
    home.file = {
        ".config/lf/icons" = {
            source = ../../config/lf/icons;
        };
    };

    programs.kitty = {
         enable = true;
         package = pkgs.kitty;
         shellIntegration.enableZshIntegration = true;
         settings = {
             scrollback_lines = 2000;
             wheel_scroll_min_lines = 1;
             window_padding_width = 4;
             confirm_os_window_close = 0;
             enable_audio_bell = false;
         };
         extraConfig = ''
            tab_bar_style fade
            tab_fade 1
            active_tab_font_style bold
            inactive_tab_font_style bold
         '';
      };

    # hyprlock
    home.file.".config/hypr/hyprlock.conf".text = ''
        background {
            monitor =
            path = ~/CodyOS/config/wallpapers/latios_latias.jpg
                # color = rgba(40, 40, 40, 0.6)

                blur_passes = 3
                blur_size = 1
        }

        input-field {
            size = 200 30
                outline_thickness = 2
                dots_size = 0.3
                dots_center = true
                font_family = JetBrains Mono Nerd Font Mono Semibold
                outer_color = rgba(102, 92, 84, 1)
                inner_color = rgba(60, 56, 54, 1)
                font_color = rgba(189, 174, 147, 1)
                fade_on_empty = false
                placeholder_text = 
                check_color = rgb(215, 153, 33)
                fail_color = rgb(204, 36, 29)
                fail_text = <i><b>Wrong password</b></i>
        }

        label {
            text = $TIME
                text_align = center
                color = rgba(189, 174, 147, 1)
                font_size = 45
                font_family = JetBrains Mono Nerd Font Mono Semibold

                position = 0, 80
                halign = center
                valign = center
        }
        '';

    # hypridle
    home.file."~/.config/hypr/hypridle.conf".text = ''
        general {
            lock_cmd = notify-send "lock!"
            unlock_cmd = notify-send "unlock!"
            before_sleep_cmd = notify-send "Zzz"
            after_sleep_cmd = notify-send "Awake!"
            ignore_dbus_inhibit = false
            ignore_systemd_inhibit = false
        }

        listener {
            timeout = 500
            on-timeout = notify-send "You are idle!"
            on-resume = notify-send "Welcom back!"
        }
    '';

    # git
    programs.git = {
        enable = true;
        package = pkgs.git;
        userName = "CodyBense";
        userEmail = "codybense@gmail.com";
        aliases = {
            a = "add";
            pu = "push";
            co = "checkout";
            cm = "commit";
        };
        extraConfig = {
            init.defaultBranch = "main";
        };
    };

    # gh
     porgrams.gh = {
        enable = true;
        package = pkgs.gh;
        settings = {
            git_protocol = "ssh";
        };
    };

    # fzf
    programs.fzf = {
        enable = true;
        package = pkgs.fzf;
        enableZshIntegration = true;
    };
    
    # direnv
    programs.direnv = {
        enable = true;
        package = pkgs.direnv;
        enableZshIntegration = true;
    };
}
