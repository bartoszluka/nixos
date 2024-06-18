{config, ...}: {
  programs.foot = {
    enable = true;
    settings = {
      main = {
        font = "JetBrainsMono NF:pixelsize=20";
        dpi-aware = "yes";
        selection-target = "both";
      };
      bell = {
        urgent = "no";
        notify = "no";
        visual = "no";
        command-focused = "no";
      };

      cursor = {
        style = "beam";
        blink = "no";
        unfocused-style = "hollow";
        # color = "inverse";
      };
      key-bindings = {
        spawn-terminal = "Mod4+n";
      };

      colors = with config.colorScheme.palette; {
        foreground = base04;
        background = base00;

        regular0 = base00;
        regular1 = base08;
        regular2 = base0B;
        regular3 = base0A;
        regular4 = base0D;
        regular5 = base0E;
        regular6 = base0C;
        regular7 = base05;

        bright0 = base03;
        bright1 = base08;
        bright2 = base0B;
        bright3 = base0A;
        bright4 = base07;
        bright5 = base0E;
        bright6 = base07;
        bright7 = base06;
      };

      csd.size = 0;
    };
  };
}
