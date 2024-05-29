{
  pkgs,
  config,
  ...
}: let
  workspaces = {
    format = "{icon}";
    format-icons = {
      "1" = "";
      "2" = "";
      "3" = "";
      "4" = "";
      "10" = "󰕮";
      # active = "";
      default = "";
    };
    on-click = "activate";
    # persistent_workspaces = { "*" = 10; };
    window-rewrite = {
      "title<.*youtube.*>" = ""; # Windows whose titles contain "youtube"
      "title<.*piped.*>" = ""; # Windows whose titles contain "youtube"
      "class<firefox>" = ""; # Windows whose classes are "firefox"
      "class<firefox> title<.*github.*>" = ""; # Windows whose class is "firefox" and title contains "github". Note that "class" always comes first.
      nvim = "";
      foot = ""; # Windows that contain "foot" in either class or title. For optimization reasons, it will only match against a title if at least one other window explicitly matches against a title.
    };
  };

  mainWaybarConfig = {
    mod = "dock";
    position = "top";
    layer = "top";
    gtk-layer-shell = true;
    height = 20;

    modules-left = ["custom/logo" "hyprland/workspaces" "hyprland/window"];
    modules-center = ["clock"];
    modules-right = [
      # "hyprland/language"
      "bluetooth"
      "pulseaudio"
      "pulseaudio#microphone"
      "backlight"
      "battery"
      "cpu"
      "memory"
      "network"
      "tray"
    ];

    "wlr/workspaces" = workspaces;
    "hyprland/workspaces" = workspaces;
    backlight = {
      format = "{icon} {percent}%";
      format-icons = ["󰃠"];
      on-scroll-up = "";
      on-scroll-down = "";
    };
    battery = {
      format = "{icon} {capacity}% ({time})";
      states = {
        warning = 20;
        critical = 10;
      };
      weighted-average = true;
      format-icons = ["󰁺" "󰁻" "󰁼" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
    };

    bluetooth = {
      format = "";
      format-connected = " {num_connections}";
      format-disabled = "";
      tooltip-format = " {device_alias}";
      tooltip-format-connected = "{device_enumerate}";
      tooltip-format-enumerate-connected = " {device_alias}";
    };

    clock = {
      actions = {
        on-click-backward = "tz_down";
        on-click-forward = "tz_up";
        on-click-right = "mode";
        on-scroll-down = "shift_down";
        on-scroll-up = "shift_up";
      };
      calendar = {
        format = {
          days = "<span color='#ecc6d9'><b>{}</b></span>";
          months = "<span color='#ffead3'><b>{}</b></span>";
          today = "<span color='#ff6699'><b><u>{}</u></b></span>";
          weekdays = "<span color='#ffcc66'><b>{}</b></span>";
          weeks = "<span color='#99ffdd'><b>W{}</b></span>";
        };
        mode = "year";
        mode-mon-col = 3;
        on-click-right = "mode";
        on-scroll = 1;
        weeks-pos = "right";
      };
      format = "󰥔 {:%H:%M}";
      format-alt = "󰥔 {:%A, %B %d, %Y (%R)} ";
    };

    cpu = {
      format = "󰍛 {usage}%";
      format-alt = "{icon0}{icon1}{icon2}{icon3}";
      format-icons = ["▁" "▂" "▃" "▄" "▅" "▆" "▇" "█"];
      interval = 10;
    };

    "custom/logo" = {
      exec = "echo ' '";
      format = "{}";
    };

    "hyprland/window" = {
      format = "{}";
      rewrite = {
        "(.*) — Mozilla Firefox" = "$1 󰈹";
        "(.*)Steam" = "Steam 󰓓";
        "nvim (.*)" = " $1";
      };
      icon = true;
      icon-size = 16;
      separate-outputs = true;
    };

    memory = {
      format = "󰾆 {percentage}%";
      format-alt = "󰾅 {used}GB";
      interval = 30;
      max-length = 10;
      tooltip = true;
      tooltip-format = " {used:0.1f}GB/{total:0.1f}GB";
    };

    network = {
      format-disconnected = " Disconnected";
      format-ethernet = "󱘖 Wired";
      format-linked = "󱘖 {ifname} (No IP)";
      format-wifi = "󰤨  {essid}";
      interval = 5;
      max-length = 30;
      tooltip-format = "󱘖 {ipaddr}  {bandwidthUpBytes}  {bandwidthDownBytes}";
    };

    pulseaudio = {
      format = "{icon}  {volume}%";
      format-icons = {
        car = " ";
        default = ["" "" ""];
        hands-free = " ";
        headphone = " ";
        headset = " ";
        phone = " ";
        portable = " ";
      };
      format-muted = " {volume}%";
      on-click = "pavucontrol -t 3";
      on-click-middle = "";
      on-scroll-down = "";
      on-scroll-up = "";
      scroll-step = 5;
      tooltip-format = "{icon} {desc} {volume}%";
    };

    "pulseaudio#microphone" = {
      format = "{format_source}";
      format-source = "  {volume}%";
      format-source-muted = "  {volume}%";
      on-click = "pavucontrol -t 4";
      on-click-middle = "";
      on-scroll-down = "";
      on-scroll-up = "";
    };

    tray = {
      icon-size = 15;
      spacing = 5;
    };
  };

  css = builtins.readFile ./style.css;
in {
  programs.waybar = {
    enable = true;
    package = pkgs.waybar.overrideAttrs (oldAttrs: {
      mesonFlags = oldAttrs.mesonFlags ++ ["-Dexperimental=true"];
    });
    style = css;
    settings = {mainBar = mainWaybarConfig;};
  };
}
