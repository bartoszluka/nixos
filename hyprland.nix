{
  config,
  pkgs,
  ...
}: let
  startScript =
    pkgs.writeShellScriptBin "start" ''
    '';
in {
  programs.waybar.enable = true;

  gtk.enable = true;

  home.pointerCursor = {
    gtk.enable = true;
    # x11.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 16;
  };

  gtk = {
    enable = true;
    theme = {
      package = pkgs.adw-gtk3;
      name = "adw-gtk3";
    };

    iconTheme = {
      package = pkgs.gnome.adwaita-icon-theme;
      name = "Adwaita";
    };

    font = {
      name = "Rubik";
      size = 14;
    };
  };

  home.packages = with pkgs; [bibata-cursors];
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 2;
        layout = "master";
        monitor = ",preferred,auto,1";
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
        enable_swallow = true;
      };
      decoration = {
        rounding = 10;

        blur = {
          enabled = true;
          size = 8;
          passes = 1;
          xray = true; # if enabled, floating windows will ignore tiled windows in their blur. Only available if blur_new_optimizations is true. Will reduce overhead on floating blur significantly.
        };
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
      "$menu" = "wofi --show drun";

      # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
      dwindle = {
        pseudotile = true; # Master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
        preserve_split = true; # You probably want this
      };

      # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
      master = {
        new_is_master = true;
      };

      # https://wiki.hyprland.org/Configuring/Variables/#gestures
      gestures = {
        workspace_swipe = true;
      };
      exec-once = [
        "nm-applet"
        "waybar"
        "mako"
        # "${pkgs.bash}/bin/bash ${startScript}/bin/start"
      ];
      "$browser" = "firefox";
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
          "$mainMod, F, fullscreen"
          "$mainMod, return, exec, $terminal"
          "$mainMod, W, exec, $browser"

          "$mainMod, Q, killactive,"
          "$mainMod, M, exit,"
          "$mainMod, E, exec, $fileManager"
          "$mainMod, V, togglefloating,"
          "$mainMod, P, exec, $menu"
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

      env = [
        "XCURSOR_SIZE,24"
        "HYPRCURSOR_SIZE,24"
      ];

      windowrulev2 = [
        "suppressevent maximize, class:.*" # You'll probably like this.
      ];
    };
  };
}
