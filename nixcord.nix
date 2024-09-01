{...}: {
  programs.nixcord = {
    enable = true; # enable Nixcord. Also installs discord package
    discord.enable = true;
    # quickCss = "some CSS"; # quickCSS file
    config = {
      useQuickCss = true; # use out quickCSS
      themeLinks = [
        # or use an online theme
        # "https://raw.githubusercontent.com/link/to/some/theme.css"
        "https://raw.githubusercontent.com/orblazer/discord-nordic/master/nordic.vencord.css"
      ];
      frameless = true; # set some Vencord options
      plugins = {
        hideAttachments.enable = true; # Enable a Vencord plugin
        alwaysTrust.enable = true;
        betterSettings.enable = true;
        biggerStreamPreview.enable = true;
        callTimer = {
          enable = true;
          format = "human";
        };
        clearURLs.enable = true;
        friendsSince.enable = true;
        moyai.enable = true;
        onePingPerDM.enable = true;
        oneko.enable = true;

        readAllNotificationsButton.enable = true;
        # Read all server notifications with a single button click!

        ignoreActivities = {
          # Enable a plugin and set some options
          # enable = true;
          # ignorePlaying = true;
          # ignoreWatching = true;
          # ignoredActivities = ["someActivity"];
        };
      };
    };
    extraConfig = {
      # Some extra JSON config here
      # ...
    };
  };
  # ...
}
