{
  pkgs,
  inputs,
  ...
}: {
  stylix.enable = true;
  stylix.image = ./wallpapers/polar-bear.jpg;
  stylix.polarity = "dark";
  # stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/nord.yaml";
  stylix.base16Scheme = inputs.nix-colors.colorSchemes.nord;
  stylix.cursor.package = pkgs.bibata-cursors;
  stylix.cursor.name = "Bibata-Modern-Ice";
  stylix.cursor.size = 24;

  stylix.fonts = {
    monospace = {
      package = pkgs.nerdfonts.override {fonts = ["JetBrainsMono"];};
      name = "JetBrainsMono Nerd Font Mono";
    };
    sansSerif = {
      package = pkgs.lato;
      name = "Lato";
    };
    serif = {
      package = pkgs.lato;
      name = "Lato";
    };
    sizes = {
      applications = 14;
      terminal = 12;
      desktop = 14;
      popups = 12;
    };
  };
  stylix.opacity = {
    applications = 0.9;
    terminal = 0.9;
    desktop = 1.0;
    popups = 0.9;
  };
}
