{ lib, username, host, config, ... }:

let
    inherit (import ../hosts/${host}/variables.nix)
    browser
    terminal
    extraMonitorSettings
    keyboardLayout
    ;
in
with lib;

{
    wayland.windowManager.hyprland = {
        enable = true;
        xwayland.enable = true;
        systemd.enable = true;
        settings =  {
            monitor = ",preferred,auto,auto";
            "$scrPath" = "$HOME/mysystem/scripts"; 
            exec-once = "start-hyprland";
            "$terminal" = "kitty";
            "$fileManager" = "thunar";
            "$browser" = "brave";
            "$wallpaperSwitcher" = "wallsetter";

            env = [
                "QT_QPA_PLATFORTHEME,qt5ct"
                "PATH,$PATH:$scrPath"
                "XDG_CURRENT_DESKTOP,Hyprland"
                "XDG_SESSION_TYPE,wayland"
                "XDG_SESSION_DESKTOP,Hyprland"
                "QT_QPA_PLATFORM,wayland"
                "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
                "QT_AUTO_SCREEN_SCALE_FACTOR,1"
                "MOZ_ENABLE_WAYLAND,1"
                "GDK_SCALE,1"
                "GDK_BACKEND,wayland"
                "GTK_USE_PORTAL,1"
            ];

            input = {
                kb_layout = ${keyboardLayout};
                kb_model = "";
                kb_options = "";
                kb_rules = "";

                follow_mouse = "2";
                touchpad = {
                    natural_scroll = "no";
                };

                sensitivity = "0";
            };

            device = {
                name = "epic-mouse-v1";
                sensitivity = "-0.5";
            };

            gestures = {
                workspace_swipe = "true";
                workspace_swipe_fingers = "3";
            };
            
            general = {
                # gaps_in = "3";
                gaps_in = "6";
                gaps_out = "8";
                border_size = "2";
                "col.active_border" = "rgb(${config.stylix.base16Scheme.base0B}) rgb(${config.stylix.base16Scheme.base06}) 45deg";
                "col.inactive_border" = "rgb(${config.stylix.base16Scheme.base00}) rgb(${config.stylix.base16Scheme.base06}) 45deg";
                layout = "dwindle";
                allow_tearing = "true";
                resize_on_border = "true";
            };

            group = {
                "col.border_active" = "rgb(${config.stylix.base16Scheme.base0B}) rgb(${config.stylix.base16Scheme.base06}) 45deg";
                "col.border_inactive" = "rgb(${config.stylix.base16Scheme.base00}) rgb(${config.stylix.base16Scheme.base06}) 45deg";
                "col.border_locked_active" = "rgb(${config.stylix.base16Scheme.base0B}) rgb(${config.stylix.base16Scheme.base06}) 45deg";
                "col.border_locked_inactive" = "rgba(b4befecc) rgba(6c7086cc) 45deg";
            };

            decoration = {
                rounding = "10";
                drop_shadow = "false";
                dim_special = "0.3";
                blur = {
                    enabled = "yes";
                    size = "6";
                    passes = "3";
                    new_optimizations = "on";
                    ignore_opacity = "on";
                    xray = "false";
                    special = "true";
                };
            };
            
            animations = {
                enabled = "yes";
                bezier = [
                    "wind, 0.05, 0.9, 0.1, 1.05"
                    "winIn, 0.1, 1.1, 0.1, 1.1"
                    "winOut, 0.3, -0.3, 0, 1"
                    "liner, 1, 1, 1, 1"
                ];

                animation = [
                    "windows, 1, 6, wind, slide"
                    "windowsIn, 1, 6, winIn, slide"
                    "windowsOut, 1, 5, winOut, slide"
                    "windowsMove, 1, 5, wind, slide"
                    "border, 1, 1, liner"
                    "borderangle, 1, 30, liner, loop"
                    "fade, 1, 10, default"
                    "workspaces, 1, 5, wind"
                ];
            };

            dwindle = {
                pseudotile = "yes";
                preserve_split = "yes";
                no_gaps_when_only = "1";
            };
            
            master = {
                # new_is_master = "yes";
            };

            misc = {
                vrr = "0";
                disable_hyprland_logo = "true";
                disable_splash_rendering = "true";
                force_default_wallpaper = "0";
            };

            xwayland = {
                force_zero_scaling = "true";
            };

            windowrule = [
                "noborder,^(wofi)$"
                "center,^(wofi)$"
                "center,^(yad)$"
            ];

            windowrulev2 = [
                "suppressevent maximize, class:.*"
                "opacity 0.90 0.90,class:^(firefox)$"
                "opacity 0.90 0.90,class:^(Brave-browser)$"
                "opacity 0.80 0.80,class:^(Steam)$"
                "opacity 0.80 0.80,class:^(Steam)$"
                "opacity 0.80 0.80,class:^(steamwebhelper)$"
                "opacity 0.80 0.80,class:^(Spotify)$"
                "opacity 0.80 0.80,class:^(Spotify Free)$"
                "opacity 0.80 0.80,class:^(code-oss)$"
                "opacity 0.80 0.80,class:^(Code)$"
                "opacity 0.80 0.80,class:^(code-url-handler)$"
                "opacity 0.80 0.80,class:^(kitty)$"
                "opacity 0.80 0.80,class:^(org.kde.dolphin)$"
                "opacity 0.80 0.80,class:^(org.kde.ark)$"
                "opacity 0.80 0.80,class:^(nwg-look)$"
                "opacity 0.80 0.80,class:^(qt5ct)$"
                "opacity 0.80 0.80,class:^(qt6ct)$"
                "opacity 0.80 0.80,class:^(kvantummanager)$"

                "opacity 0.90 0.90,class:^(com.github.rafostar.Clapper)$" #Clapper-Gtk
                "opacity 0.80 0.80,class:^(com.github.tchx84.Flatseal)$" #Flatseal-Gtk
                "opacity 0.80 0.80,class:^(hu.kramo.Cartridges)$" #Cartridges-Gtk
                "opacity 0.80 0.80,class:^(com.obsproject.Studio)$" #Obs-Qt
                "opacity 0.80 0.80,class:^(gnome-boxes)$" #Boxes-Gtk
                "opacity 0.80 0.80,class:^(discord)$" #Discord-Electron
                "opacity 0.80 0.80,class:^(WebCord)$" #WebCord-Electron
                "opacity 0.80 0.80,class:^(ArmCord)$" #ArmCord-Electron
                "opacity 0.80 0.80,class:^(app.drey.Warp)$" #Warp-Gtk
                "opacity 0.80 0.80,class:^(net.davidotek.pupgui2)$" #ProtonUp-Qt
                "opacity 0.80 0.80,class:^(yad)$" #Protontricks-Gtk
                "opacity 0.80 0.80,class:^(Signal)$" #Signal-Gtk
                "opacity 0.80 0.80,class:^(io.github.alainm23.planify)$" #planify-Gtk
                "opacity 0.80 0.80,class:^(io.gitlab.theevilskeleton.Upscaler)$" #Upscaler-Gtk
                "opacity 0.80 0.80,class:^(com.github.unrud.VideoDownloader)$" #VideoDownloader-Gtk

                "opacity 0.80 0.70,class:^(pavucontrol)$"
                "opacity 0.80 0.70,class:^(blueman-manager)$"
                "opacity 0.80 0.70,class:^(nm-applet)$"
                "opacity 0.80 0.70,class:^(nm-connection-editor)$"
                "opacity 0.80 0.70,class:^(org.kde.polkit-kde-authentication-agent-1)$"

                "float,class:^(org.kde.dolphin)$,title:^(Progress Dialog — Dolphin)$"
                "float,class:^(org.kde.dolphin)$,title:^(Copying — Dolphin)$"
                "float,title:^(Picture-in-Picture)$"
                "float,class:^(firefox)$,title:^(Library)$"
                "float,class:^(vlc)$"
                "float,class:^(kvantummanager)$"
                "float,class:^(qt5ct)$"
                "float,class:^(qt6ct)$"
                "float,class:^(nwg-look)$"
                "float,class:^(org.kde.ark)$"
                "float,class:^(Signal)$" #Signal-Gtk
                "float,class:^(com.github.rafostar.Clapper)$" #Clapper-Gtk
                "float,class:^(app.drey.Warp)$" #Warp-Gtk
                "float,class:^(net.davidotek.pupgui2)$" #ProtonUp-Qt
                "float,class:^(yad)$" #Protontricks-Gtk
                "float,class:^(eog)$" #Imageviewer-Gtk
                "float,class:^(io.github.alainm23.planify)$" #planify-Gtk
                "float,class:^(io.gitlab.theevilskeleton.Upscaler)$" #Upscaler-Gtk
                "float,class:^(com.github.unrud.VideoDownloader)$" #VideoDownloader-Gkk
                "float,class:^(pavucontrol)$"
                "float,class:^(blueman-manager)$"
                "float,class:^(nm-applet)$"
                "float,class:^(nm-connection-editor)$"
                "float,class:^(org.kde.polkit-kde-authentication-agent-1)$"
                "opacity 0.80 0.80,class:^(org.freedesktop.impl.portal.desktop.gtk)$"
                "opacity 0.80 0.80,class:^(org.freedesktop.impl.portal.desktop.hyprland)$"
            ];

            layerrule = [
                "blur,rofi"
                "ignorezero,rofi"
                "blur,notifications"
                "ignorezero,notifications"
                "blur,swaync-notification-window"
                "ignorezero,swaync-notification-window"
                "blur,swaync-control-center"
                "ignorezero,swaync-control-center"
                "blur,logout_dialog"
                "blur,waybar"
            ];

            "$mainMod" = "SUPER";

            bind = [
                "$mainMod, T, exec, ${terminal}"
                "$mainMod, Q, killactive, "
                "$mainMod, DELETE, exit, "
                "$mainMod, E, exec, $fileManager"
                "$mainMod, V, togglefloating, "
                "$mainMod SHIFT, V, fullscreen"
                "$mainMode, SPACE, exec, rofi-launch"
                "$mainMod, P, pseudo, "
                "$mainMod, F, exec, ${browser}"
                "$mainMod, M, exec, spotify"
                "$mainMod, BACKSPACE, exec, wlogout"
                "$mainMod, PERIOD, exec, emojipicker"

                "$mainMod ALT, L, exec, hyprlock"

                "$mainMod, H, movefocus, l"
                "$mainMod, L, movefocus, r"
                "$mainMod, K, movefocus, u"
                "$mainMod, J, movefocus, d"

                "$mainMod SHIFT, H, movewindow, l"
                "$mainMod SHIFT, L, movewindow, r"
                "$mainMod SHIFT, K, movewindow, u"
                "$mainMod SHIFT, J, movewindow, d"

                "$mainMod CTRL, H, resizeactive, -30 0"
                "$mainMod CTRL, L, resizeactive, 30 0"
                "$mainMod CTRL, J, resizeactive, 0 -30"
                "$mainMod CTRL, K, resizeactive, 0 30"

                "$mainMod, 1, workspace, 1"
                "$mainMod, 2, workspace, 2"
                "$mainMod, 3, workspace, 3"
                "$mainMod, 4, workspace, 4"
                "$mainMod, 5, workspace, 5"
                "$mainMod, 6, workspace, 6"
                "$mainMod, 7, workspace, 7"
                "$mainMod, 8, workspace, 8"
                "$mainMod, 9, workspace, 9"
                "$mainMod, 0, workspace, 10"

                "$mainMod SHIFT, 1, movetoworkspace, 1"
                "$mainMod SHIFT, 2, movetoworkspace, 2"
                "$mainMod SHIFT, 3, movetoworkspace, 3"
                "$mainMod SHIFT, 4, movetoworkspace, 4"
                "$mainMod SHIFT, 5, movetoworkspace, 5"
                "$mainMod SHIFT, 6, movetoworkspace, 6"
                "$mainMod SHIFT, 7, movetoworkspace, 7"
                "$mainMod SHIFT, 8, movetoworkspace, 8"
                "$mainMod SHIFT, 9, movetoworkspace, 9"
                "$mainMod SHIFT, 0, movetoworkspace, 10"


                "$mainMod CTRL, 1, movetoworkspacesilent, 1"
                "$mainMod CTRL, 2, movetoworkspacesilent, 2"
                "$mainMod CTRL, 3, movetoworkspacesilent, 3"
                "$mainMod CTRL, 4, movetoworkspacesilent, 4"
                "$mainMod CTRL, 5, movetoworkspacesilent, 5"
                "$mainMod CTRL, 6, movetoworkspacesilent, 6"
                "$mainMod CTRL, 7, movetoworkspacesilent, 7"
                "$mainMod CTRL, 8, movetoworkspacesilent, 8"
                "$mainMod CTRL, 9, movetoworkspacesilent, 9"
                "$mainMod CTRL, 0, movetoworkspacesilent, 10"

                "$mainMod, S, togglespecialworkspace, magic"
                "$mainMod SHIFT, S, movetoworkspace, special:magic"

                "$mainMod SHIFT, I, togglesplit,"

                "$mainMod, mouse_down, workspace, e+1"
                "$mainMod, mouse_up, workspace, e-1"

                ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
                ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
                ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"

                ", XF86MonBrightnessDown, exec, brightnessctl set 5%-"
                ", XF86MonBrightnessUp, exec, brightnessctl set +5%"

                "$mainMod ALT, W, exec, $wallpaperSwitcher"
            ];

            bindm = [
                "$mainMod, mouse:272, movewindow"
                "$mainMod, mouse:273, resizewindow"
            ];

            exec = [
                "hyprctl setcursor Bibata-Modern-Ice 20"
                "gsettings set org.gnome.desktop.interface cursor-config.stylix.base16Scheme 'Bibata-Modern-Ice'"
                "gsettings set org.gnome.desktop.interface cursor-size 20"
            ];

        };
    };
}
