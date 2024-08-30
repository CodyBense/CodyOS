# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ pkgs, host, ... }:
let
    inherit (import ./variables.nix) keyboardLayout;
in
{
    imports =[ # Include the results of the hardware scan.
        ./hardware-configuration.nix
        ./users.nix
        ../../modules/intel-drivers.nix
        ../../modules/nix/code_bundle.nix
        ../../modules/nix/de_bundle.nix
        ../../modules/nix/packages.nix
        ../../modules/nix/docker.nix
        ../../modules/nix/stylix.nix
        ];

    drivers.intel.enable = true;

    # Bootloader.
    boot.loader = {
        systemd-boot.enable = true;
        efi.canTouchEfiVariables = true;
    };

    # Networking
    networking = {
        hostName = "${host}";
        networkmanager.enable = true;
    };

    # Timezone
    time.timeZone = "America/New_York";

    # Select internationalisation properties.
    i18n.defaultLocale = "en_US.UTF-8";

    i18n.extraLocaleSettings = {
        LC_ADDRESS = "en_US.UTF-8";
        LC_IDENTIFICATION = "en_US.UTF-8";
        LC_MEASUREMENT = "en_US.UTF-8";
        LC_MONETARY = "en_US.UTF-8";
        LC_NAME = "en_US.UTF-8";
        LC_NUMERIC = "en_US.UTF-8";
        LC_PAPER = "en_US.UTF-8";
        LC_TELEPHONE = "en_US.UTF-8";
        LC_TIME = "en_US.UTF-8";
    };

    programs = {
        firefox.enable = true;
        thunar = {
            enable = true;
            plugins = with pkgs.xfce; [ thunar-archive-plugin thunar-volman ];
        };
    };

    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    users = {
        mutableUsers = true;
    };

    environment.sessionVariables = {
        FLAKE = "/home/codybense/mysystem";
    };

    environment.variables.EDITOR = "nvim";

    services = {
        xserver = {
            enable = true;
            displayManager.sddm = {
                enable = true;
                autoNumlock = true;
                wayland.enable = true;
                theme = "tokyo-night-sddm";
            };
            xkb = {
                layout = "${keyboardLayout}";
                variant = "";
            };
        };
        pipewire = {
            enable = true;
            alsa.enable = true;
            alsa.support32Bit = true;
            pulse.enable = true;
            jack.enable = true;
        };
        tlp = {
            enable = true;
        };
        openssh = {
            enable = true;
        };
    };

    # sound.enable = true;
    hardware.pulseaudio.enable = false;

    security = {
        rtkit.enable = true;
        pam.services.swaylock = {};
    };

    nix = {
        settings = {
            auto-optimise-store = true;
            experimental-features = [
                "nix-command"
                "flakes"
            ];
            substituters = [ "https://hyprland.cachix.org" ];
        };
        gc = {
            automatic = true;
            dates = "weekly";
            options = "--delete-older-than 7d";
        };
    };

# Fonts
    fonts.packages = with pkgs; [
        font-awesome
        jetbrains-mono
        cascadia-code
        maple-mono-NF
        mononoki
        noto-fonts-cjk-sans
    ];
    # system.stateVersion = "23.11"; # Did you read the comment?
    system.stateVersion = "24.05";
}
