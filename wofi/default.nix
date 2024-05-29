{pkgs, ...}: {
  programs.wofi = {
    enable = true;
    settings = {
      term = "foot";
      insensitive = true;

      # width=900
      # height=600
      # location=center
      show = "drun";
      prompt = "Search...";
      filter_rate = 100;
      allow_markup = "true";
      no_actions = "true";
      halign = "fill";
      orientation = "vertical";
      content_halign = "fill";
      allow_images = true;
      image_size = 35;
      gtk_dark = true;
    };

    style = builtins.readFile ./style.css;
  };
}
