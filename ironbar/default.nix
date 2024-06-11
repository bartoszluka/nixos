{
  inputs,
  config,
  ...
}: {
  programs.ironbar = let
    workspaces = {
      type = "workspaces";
      all_monitors = true;
      name_map = {
        "1" = "";
        "2" = "";
        "3" = "";
        "4" = "";
        "10" = "󰕮";
      };
    };
    tray = {type = "tray";};

    clock = {type = "clock";};

    volume = {
      type = "volume";
      format = "{icon} {percentage}%";
      max_volume = 100;
      icons.volume_high = "󰕾";
      icons.volume_medium = "󰖀";
      icons.volume_low = "󰕿";
      icons.muted = "󰝟";
    };
    focused = {type = "focused";};

    sys_info = {
      type = "sys_info";
      interval.memory = 30;
      interval.cpu = 1;
      interval.temps = 5;
      interval.disks = 300;
      interval.networks = 3;

      format = [
        " {cpu_percent}% | {temp_c:k10temp-Tccd1}°C"
        " {memory_used} / {memory_total} GB ({memory_percent}%)"
        "| {swap_used} / {swap_total} GB ({swap_percent}%)"
        "󰋊 {disk_used:/} / {disk_total:/} GB ({disk_percent:/}%)"
        "󰓢 {net_down:enp39s0} / {net_up:enp39s0} Mbps"
        "󰖡 {load_average:1} | {load_average:5} | {load_average:15}"
        "󰥔 {uptime}"
      ];
    };
  in {
    enable = true;
    config = {
      position = "bottom";
      anchor_to_edges = true;
      height = 30;
      start = [workspaces focused];
      center = [clock];
      end = [sys_info volume tray];
    };
    style = with config.colorScheme.palette; ''
      @define-color color_bg #${base01};
      @define-color color_bg_dark #${base00};
      @define-color color_border #${base03};
      @define-color color_border_active #${base0C};
      @define-color color_text #${base06};
      @define-color color_urgent #${base08};

      /* -- base styles -- */

      * {
          font-family: Noto Sans Nerd Font, sans-serif;
          font-size: 16px;
          border: none;
          border-radius: 0;
      }

      box, menubar, button {
          background-color: @color_bg;
          background-image: none;
          box-shadow: none;
      }

      button, label {
          color: @color_text;
      }

      button:hover {
          background-color: @color_bg_dark;
      }

      scale trough {
          min-width: 1px;
          min-height: 2px;
      }

      #bar {
          border-top: 1px solid @color_border;
      }

      .popup {
          border: 1px solid @color_border;
          padding: 1em;
      }


      /* -- clipboard -- */

      .clipboard {
          margin-left: 5px;
          font-size: 1.1em;
      }

      .popup-clipboard .item {
          padding-bottom: 0.3em;
          border-bottom: 1px solid @color_border;
      }


      /* -- clock -- */

      .clock {
          font-weight: bold;
          margin-left: 5px;
      }

      .popup-clock .calendar-clock {
          color: @color_text;
          font-size: 2.5em;
          padding-bottom: 0.1em;
      }

      .popup-clock .calendar {
          background-color: @color_bg;
          color: @color_text;
      }

      .popup-clock .calendar .header {
          padding-top: 1em;
          border-top: 1px solid @color_border;
          font-size: 1.5em;
      }

      .popup-clock .calendar:selected {
          background-color: @color_border_active;
      }


      /* -- launcher -- */

      .launcher .item {
          margin-right: 4px;
      }

      .launcher .ifix examtem:not(.focused):hover {
          background-color: @color_bg_dark;
      }

      .launcher .open {
          border-bottom: 1px solid @color_text;
      }

      .launcher .focused {
          border-bottom: 1px solid @color_border_active;
      }

      .launcher .urgent {
          border-bottom-color: @color_urgent;
      }

      .popup-launcher {
          padding: 0;
      }

      .popup-launcher .popup-item:not(:first-child) {
          border-top: 1px solid @color_border;
      }


      /* -- music -- */

      .music:hover * {
          background-color: @color_bg_dark;
      }

      .popup-music .album-art {
          margin-right: 1em;
      }

      .popup-music .icon-box {
          margin-right: 0.4em;
      }

      .popup-music .title .icon, .popup-music .title .label {
          font-size: 1.7em;
      }

      .popup-music .controls *:disabled {
          color: @color_border;
      }

      .popup-music .volume .slider slider {
          border-radius: 100%;
      }

      .popup-music .volume .icon {
          margin-left: 4px;
      }

      .popup-music .progress .slider slider {
          border-radius: 100%;
      }

      /* notifications */

      .notifications .count {
          font-size: 0.6rem;
          background-color: @color_text;
          color: @color_bg;
          border-radius: 100%;
          margin-right: 3px;
          margin-top: 3px;
          padding-left: 4px;
          padding-right: 4px;
          opacity: 0.7;
      }

      /* -- script -- */

      .script {
          padding-left: 10px;
      }


      /* -- sys_info -- */

      .sysinfo {
          margin-left: 10px;
      }

      .sysinfo .item {
          margin-left: 5px;
      }


      /* -- tray -- */

      .tray {
          margin-left: 10px;
      }

      /* -- volume -- */

      .popup-volume .device-box {
          border-right: 1px solid @color_border;
      }

      /* -- workspaces -- */

      .workspaces .item.focused {
          box-shadow: inset 0 -3px;
          background-color: @color_bg_dark;
      }

      .workspaces .item:hover {
          box-shadow: inset 0 -3px;
      }


      /* -- custom: power menu -- */

      .popup-power-menu #header {
          font-size: 1.4em;
          padding-bottom: 0.4em;
          margin-bottom: 0.6em;
          border-bottom: 1px solid @color_border;
      }

      .popup-power-menu .power-btn {
          border: 1px solid @color_border;
          padding: 0.6em 1em;
      }

      .popup-power-menu #buttons > *:nth-child(1) .power-btn {
          margin-right: 1em;
      }
    '';

    package = inputs.ironbar;
    features = [];
  };
}
