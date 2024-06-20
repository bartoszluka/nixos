{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: let
  projector = "Optoma Corporation Optoma 1080P Q72J6470784";
in {
  programs.waybar.enable = true;

  home.pointerCursor = {
    gtk.enable = true;
    # x11.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 24;
  };

  gtk = let
    extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
  in {
    enable = true;
    theme = {
      package = pkgs.nordic;
      name = "Nordic";
    };

    iconTheme = {
      package = pkgs.nordzy-icon-theme;
      name = "Nordzy";
    };

    font = {
      name = "Lato";
      package = pkgs.lato;
      size = 15;
    };
    gtk2.extraConfig = ''
      gtk-application-prefer-dark-theme = 1;
    '';
    gtk3.extraConfig = extraConfig;
    gtk4.extraConfig = extraConfig;
  };

  home.packages = with pkgs; [swaybg pulseaudio];
  wayland.windowManager.hyprland = {
    package = inputs.hyprland.packages."${pkgs.system}".hyprland;
    enable = true;
    settings = {
      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 4;
        layout = "master";
        monitor = [
          "eDP-1, 1920x1080, 0x0, 1"
          "desc:${projector}, preferred, auto-up, 1"
          ",preferred, auto, 1"
        ];

        # "col.active_border" = "rgba(${config.colorScheme.palette.base0E}ff) rgba(${config.colorScheme.colors.base09}ff) 60deg";
        "col.active_border" = "rgb(${config.colorScheme.palette.base0E})";
        "col.inactive_border" = "rgb(${config.colorScheme.palette.base00})";
      };
      input = {
        kb_layout = "pl";
        touchpad = {
          natural_scroll = true;
          disable_while_typing = true;
        };
        touchdevice.enabled = false;
        repeat_rate = 40;
        repeat_delay = 250;
        force_no_accel = true;
        follow_mouse = 1;
        sensitivity = 0.0; # from -1.0 to 1.0, 0 means no modifications
      };
      cursor = {
        inactive_timeout = 5;
        hide_on_key_press = true;
        hide_on_touch = true;
      };
      misc = {
        disable_hyprland_logo = true;
        enable_swallow = true;
        vfr = true; # it’ll lower the amount of sent frames when nothing is happening on-screen.
      };
      decoration = {
        rounding = 10;

        blur = {
          enabled = true;
          size = 8;
          passes = 1;
          xray = true; # if enabled, floating windows will ignore tiled windows in their blur. Only available if blur_new_optimizations is true. Will reduce overhead on floating blur significantly.
        };
        drop_shadow = false;
      };
      animations = {
        enabled = true;

        bezier = "myBezier, 0.05, 0.9, 0.1, 1.02";

        animation = let
          speed_ms = 300;
          speed = toString (speed_ms * 0.01);
        in [
          "windows, 1, ${speed}, myBezier"
          "windowsOut, 1, ${speed}, default, popin 80%"
          "border, 1, ${speed}, default"
          "borderangle, 1, ${speed}, default"
          "fade, 1, ${speed}, default"
          "workspaces, 1, ${speed}, default"
        ];
      };

      "$mainMod" = "SUPER";
      "$terminal" = "foot";
      "$menu" = "${pkgs.wofi}/bin/wofi --show drun";

      # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
      dwindle = {
        pseudotile = true; # Master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
        preserve_split = true; # You probably want this
      };

      # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
      master = {
        new_is_master = true;
        new_on_top = true;
      };

      # https://wiki.hyprland.org/Configuring/Variables/#gestures
      gestures = {
        workspace_swipe = true;
      };
      exec-once = [
        "nm-applet"
        "blueman-applet"
        "waybar"
        "mako"
        "foot --server"
        "${pkgs.hyprdim}/bin/hyprdim"
        (let
          connected = pkgs.writeShellScriptBin "connected.sh" ''
            hyprctl dispatch moveworkspacetomonitor name:external monitor:desc:${projector}
            pactl set-card-profile alsa_card.pci-0000_00_1f.3 output:hdmi-stereo
          '';
          disconnected = pkgs.writeShellScriptBin "disconnected.sh" ''
            pactl set-card-profile alsa_card.pci-0000_00_1f.3 output:analog-stereo
          '';
        in "${lib.getExe pkgs.hyprland-monitor-attached} ${lib.getExe connected} ${lib.getExe disconnected}")
        "sleep 2; ${lib.getExe pkgs.swaybg} --mode fill --image ${./wallpapers/polar-bear.jpg}"
        "[workspace 10 silent] foot -e btm"
        "[workspace 2 silent] $browser"
      ];
      "$browser" = "firefox";
      workspace = [
        "name:external, monitor:desc:${projector}, default:true"
        "r[1-10], monitor:eDP-1"
      ];
      bind = let
        brightness = x: let
          direction =
            if x == "up"
            then "A"
            else if x == "down"
            then "U"
            else throw "up or down";
        in "${pkgs.brillo}/bin/brillo -u 150000 -${direction} 2 -q";
      in
        [
          "$mainMod, F, fullscreen, 2"
          "$mainMod, return, exec, footclient"
          "$mainMod, W, exec, $browser"

          "$mainMod, Q, killactive,"
          "$mainMod, M, exit,"
          "$mainMod, E, exec, $fileManager"
          "$mainMod, V, togglefloating,"
          "$mainMod, P, exec, $menu"

          "$mainMod, X, exec, ${lib.getExe config.programs.wlogout.package} --show-binds"
          # "$mainMod, P, pseudo, # dwindle"
          # "$mainMod, J, togglesplit, # dwindle"

          # focus with mainMod + vim keys
          "$mainMod, h, movefocus, l"
          "$mainMod, l, movefocus, r"
          "$mainMod, k, movefocus, u"
          "$mainMod, j, movefocus, d"

          # move windows
          "$mainMod SHIFT, h, movewindow, l"
          "$mainMod SHIFT, l, movewindow, r"
          "$mainMod SHIFT, k, movewindow, u"
          "$mainMod SHIFT, j, movewindow, d"

          # media keys (on F keys)
          ",XF86MonBrightnessUp, exec, ${brightness "up"}"
          ",XF86MonBrightnessDown, exec, ${brightness "down"}"
          ",XF86AudioRaiseVolume, exec, ${pkgs.pw-volume}/bin/pw-volume change '+5%'"
          ",XF86AudioLowerVolume, exec, ${pkgs.pw-volume}/bin/pw-volume change '-5%'"
          ",XF86AudioMute, exec, ${pkgs.pw-volume}/bin/pw-volume mute toggle"
          ",XF86AudioMicMute, exec, ${pkgs.pamixer}/bin/pamixer --default-source --toggle-mute"
          # other keys: XF86Display XF86WLAN XF86Tools XF86Bluetooth XF86Keyboard XF86Favorites
          ", Print, exec, ${pkgs.grimblast}/bin/grimblast copy area"

          "$mainMod, e, workspace, external"
          "$mainMod SHIFT, e, movetoworkspace, external"
        ]
        ++ map (n: "$mainMod SHIFT, ${toString n}, movetoworkspace, ${toString (
          if n == 0
          then 10
          else n
        )}") [1 2 3 4 5 6 7 8 9 0]
        ++ map (n: "$mainMod, ${toString n}, workspace, ${toString (
          if n == 0
          then 10
          else n
        )}") [1 2 3 4 5 6 7 8 9 0];

      bindm = [
        "bindm=$mainMod,mouse:272,movewindow"
        "bindm=$mainMod,mouse:273,resizewindow 2"
      ];
      env = let
        size = toString config.home.pointerCursor.size;
      in [
        "XCURSOR_SIZE,${size}"
        "HYPRCURSOR_SIZE,${size}"
      ];

      windowrulev2 = let
        opacity = "0.88";
      in [
        "suppressevent maximize, class:.*" # You'll probably like this.
        "opacity ${opacity} override ${opacity} override 1.0 override, class:.*" # set opacity to ${opacity} active, ${opacity} inactive and ${opacity} fullscreen for all programs
        "opacity ${opacity} override ${opacity} override ${opacity} override, class:^(foot)$" # set opacity to ${opacity} active, ${opacity} inactive and ${opacity} fullscreen for foot
        "opacity ${opacity} override ${opacity} override ${opacity} override, class:^(kitty)$" # set opacity to ${opacity} active, ${opacity} inactive and ${opacity} fullscreen for kitty
      ];
    };
  };
}
