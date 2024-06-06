{
  pkgs,
  inputs,
  ...
}: {
  programs.firefox = {
    enable = true;
    package = pkgs.firefox-devedition;
    nativeMessagingHosts = [
      # Gnome shell native connector
      pkgs.gnome-browser-connector
      # Tridactyl native connector
      pkgs.tridactyl-native
    ];

    profiles.bartek = {
      extensions = with inputs.firefox-addons.packages."x86_64-linux"; [
        bitwarden
        ublock-origin
        darkreader
        vimium
      ];

      search.default = "searx";
      search.engines = {
        "searx" = {
          urls = [
            {
              template = "https://searx.jaimo.fun/search";
              params = [
                {
                  name = "q";
                  value = "{searchTerms}";
                }
              ];
            }
          ];

          # icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
          definedAliases = ["sx"];
        };
        "Nix Packages" = {
          urls = [
            {
              template = "https://search.nixos.org/packages";
              params = [
                {
                  name = "type";
                  value = "packages";
                }
                {
                  name = "channel";
                  value = "unstable";
                }
                {
                  name = "query";
                  value = "{searchTerms}";
                }
              ];
            }
          ];
          icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
          definedAliases = ["n"];
        };
      };

      search.force = true;

      extraConfig = ''
        // Enable customChrome.css
        user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);

        // Enable CSD
        // user_pref("browser.tabs.drawInTitlebar", true);
      '';

      userChrome = ''
        @import "firefox-nordic-theme/userChrome.css";
      '';

      settings = {
        "browser.aboutwelcome.enabled" = false;
        "browser.meta_refresh_when_inactive.disabled" = true;
        "browser.urlbar.suggest.quicksuggest.sponsored" = false;
        "browser.aboutConfig.showWarning" = false;
        "browser.ssb.enabled" = true;
        "browser.disableResetPrompt" = true;
        "browser.download.panel.shown" = true;

        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
        "browser.shell.checkDefaultBrowser" = false;
        "browser.shell.defaultBrowserCheckCount" = 1;
        "browser.startup.homepage" = "https://searx.jaimo.fun";

        # taken from Misterio77's config
        "browser.uiCustomization.state" = ''{"placements":{"widget-overflow-fixed-list":[],"nav-bar":["back-button","forward-button","stop-reload-button","home-button","urlbar-container","downloads-button","library-button","ublock0_raymondhill_net-browser-action","_testpilot-containers-browser-action"],"toolbar-menubar":["menubar-items"],"TabsToolbar":["tabbrowser-tabs","new-tab-button","alltabs-button"],"PersonalToolbar":["import-button","personal-bookmarks"]},"seen":["save-to-pocket-button","developer-button","ublock0_raymondhill_net-browser-action","_testpilot-containers-browser-action"],"dirtyAreaCache":["nav-bar","PersonalToolbar","toolbar-menubar","TabsToolbar","widget-overflow-fixed-list"],"currentVersion":18,"newElementCount":4}'';
        "dom.security.https_only_mode" = true;
        "identity.fxaccounts.enabled" = false;
        "privacy.trackingprotection.enabled" = true;
        "signon.rememberSignons" = false;
      };
    };
  };
}
