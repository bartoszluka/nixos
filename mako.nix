{...}: {
  services.mako = {
    enable = true;
    settings = {
      # backgroundColor = "#${colors.base00}";
      # textColor = "#${colors.base05}";
      # borderColor = "#${colors.base0D}";

      border-radius = 10;
      border-size = 2;
      default-timeout = 3000;
      layer = "overlay";
      # progressColor = "over #${colors.base02}";
      # font = "sans 16";

      # extraConfig = ''
      #   [urgency=high]
      #   border-color=#${colors.base09}
      # '';
    };
  };
}
