{...}: {
  programs.hyprpanel = {
    # Enable the module.
    # Default: false
    enable = true;

    # Automatically restart HyprPanel with systemd.
    # Useful when updating your config so that you
    # don't need to manually restart it.
    # Default: false
    systemd.enable = true;

    # Add '/nix/store/.../hyprpanel' to your
    # Hyprland config 'exec-once'.
    # Default: false
    hyprland.enable = true;

    # Fix the overwrite issue with HyprPanel.
    # See below for more information.
    # Default: false
    overwrite.enable = true;

    # Import a theme from './themes/*.json'.
    # Default: ""
    theme = "nord";

    # Override the final config with an arbitrary set.
    # Useful for overriding colors in your selected theme.
    # Default: {}
    # override = {
    #   theme.bar.menus.text = "#123ABC";
    # };

    # Configure bar layouts for monitors.
    # See 'https://hyprpanel.com/configuration/panel.html'.
    # Default: null
    layout = {
      "bar.layouts" = {
        "0" = {
          left = ["workspaces" "windowtitle"];
          middle = ["clock"];
          right = ["battery" "volume" "bluetooth" "hyprsunset" "systray"];
        };
      };
    };

    # Configure and theme almost all options from the GUI.
    # Options that require '{}' or '[]' are not yet implemented,
    # except for the layout above.
    # See 'https://hyprpanel.com/configuration/settings.html'.
    # Default: <same as gui>
    settings = {
      bar.launcher.autoDetectIcon = true;
      bar.workspaces = {
        show_icons = true;
        showApplicationIcons = true;
        showWsIcons = true;
        show_numbered = true;
      };
      bar.clock.format = "%a %d %b %H:%M";

      menus.transitionTime = 100;
      menus.clock = {
        time = {
          military = true;
          hideSeconds = false;
        };
        weather.enabled = false;
      };
      menus.power.lowBatteryNotification = true;
      menus.power.lowBatteryThreshold = 10;

      menus.dashboard.directories.enabled = false;
      menus.dashboard.stats.enable_gpu = false;
      theme.bar = {
        transparent = false;
      };
      theme.font = {
        name = "Lato";
        # size = "14px";
        size = "1rem";
      };
    };
  };
}
