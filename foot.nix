{pkgs, ...}: {
  programs.foot = {
    enable = true;
    settings = {
      main = {
        font = "JetBrainsMono NF:size=9";
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
        # color = "inverse";
      };

      colors = {
        # Nord
        foreground = "D8DEE9";
        background = "2E3440";

        regular0 = "2E3440";
        regular1 = "BF616A";
        regular2 = "A3BE8C";
        regular3 = "EBCB8B";
        regular4 = "81A1C1";
        regular5 = "B48EAD";
        regular6 = "88C0D0";
        regular7 = "E5E9F0";

        bright0 = "4C566A";
        bright1 = "BF616A";
        bright2 = "A3BE8C";
        bright3 = "EBCB8B";
        bright4 = "8FBCBB";
        bright5 = "B48EAD";
        bright6 = "8FBCBB";
        bright7 = "ECEFF4";
      };

      csd. size = 0;
    };
  };
}
