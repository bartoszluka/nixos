{config, ...}: let
  colors = config.colorScheme.colors;
in {
  services.mako = {
    enable = true;
    backgroundColor = "#${colors.base00}";
    textColor = "#${colors.base05}";
    borderColor = "#${colors.base0D}";
    borderRadius = 10;
    borderSize = 2;
    defaultTimeout = 3000;
    progressColor = "over #${colors.base02}";
    layer = "overlay";
    font = "sans 16";

    extraConfig = ''
      [urgency=high]
      border-color=#${colors.base09}
    '';
  };
}
