{
  pkgs,
  inputs,
  ...
}: {
  programs.firefox = {
    enable = true;
    # package = pkgs.firefox-devedition;
    nativeMessagingHosts = [
      # Gnome shell native connector
      pkgs.gnome-browser-connector
    ];

    policies = {
      DisableAppUpdate = true;
      DisableFirefoxAccounts = true;
      DisableFirefoxStudies = true;
      DisableFormHistory = true;
      DisablePocket = true;
      DisableTelemetry = true;
      DisplayBookmarksToolbar = "newtab";
      DontCheckDefaultBrowser = true;
      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        EmailTracking = true;
        Fingerprinting = true;
      };
      FirefoxHome = {
        Search = true;
        TopSites = false;
        SponsoredTopSites = false;
        Highlights = false;
        Pocket = false;
        SponsoredPocket = false;
        Snippets = false;
        Locked = true;
      };
      FirefoxSuggest = {
        WebSuggestions = false;
        SponsoredSuggestions = false;
        ImproveSuggest = false;
        Locked = true;
      };
      Homepage = {
        StartPage = "previous-session";
        Locked = true;
      };
      NetworkPrediction = false;
      NoDefaultBookmarks = true;
      OfferToSaveLogins = false;
      OverrideFirstRunPage = "";
      OverridePostUpdatePage = "";
      PasswordManagerEnabled = false;
      PrimaryPassword = false;
      SearchSuggestEnabled = true;
      UserMessaging = {
        WhatsNew = false;
        ExtensionRecommendations = false;
        FeatureRecommendations = false;
        UrlbarInterventions = false;
        SkipOnboarding = true;
        MoreFromMozilla = false;
        Locked = true;
      };
      Preferences = {
        "accessibility.force_disabled" = {
          Value = 1;
          Status = "locked";
        };
        "browser.aboutConfig.showWarning" = {
          Value = false;
          Status = "locked";
        };
        "browser.aboutHomeSnippets.updateUrl" = {
          Value = "";
          Status = "locked";
        };
        "browser.crashReports.unsubmittedCheck.autoSubmit2" = {
          Value = false;
          Status = "locked";
        };
        "browser.selfsupport.url" = {
          Value = "";
          Status = "locked";
        };
        "browser.startup.homepage_override.mstone" = {
          Value = "ignore";
          Status = "locked";
        };
        "browser.startup.homepage_override.buildID" = {
          Value = "";
          Status = "locked";
        };
        "browser.tabs.firefox-view" = {
          Value = false;
          Status = "locked";
        };
        "browser.tabs.firefox-view-next" = {
          Value = false;
          Status = "locked";
        };
        "browser.urlbar.suggest.history" = {
          Value = true;
          Status = "locked";
        };
        "browser.urlbar.suggest.topsites" = {
          Value = true;
          Status = "locked";
        };
        "dom.security.https_only_mode" = {
          Value = true;
          Status = "locked";
        };
        "extensions.htmlaboutaddons.recommendations.enabled" = {
          Value = false;
          Status = "locked";
        };
        "extensions.recommendations.themeRecommendationUrl" = {
          Value = "";
          Status = "locked";
        };
        "gfx.canvas.accelerated.cache-items" = {
          Value = 4096;
          Status = "locked";
        };
        "gfx.canvas.accelerated.cache-size" = {
          Value = 512;
          Status = "locked";
        };
        "gfx.content.skia-font-cache-size" = {
          Value = 20;
          Status = "locked";
        };
        "network.dns.disablePrefetch" = {
          Value = false;
          Status = "locked";
        };
        "network.dns.disablePrefetchFromHTTPS" = {
          Value = false;
          Status = "locked";
        };
        "network.http.max-connections" = {
          Value = 1800;
          Status = "locked";
        };
        "network.http.max-persistent-connections-per-server" = {
          Value = 10;
          Status = "locked";
        };
        "network.http.max-urgent-start-excessive-connections-per-host" = {
          Value = 5;
          Status = "locked";
        };
        "network.http.pacing.requests.enabled" = {
          Value = false;
          Status = "locked";
        };
        "network.IDN_show_punycode" = {
          Value = true;
          Status = "locked";
        };
        "network.predictor.enabled" = {
          Value = false;
          Status = "locked";
        };
        "network.prefetch-next" = {
          Value = false;
          Status = "locked";
        };
        "network.trr.mode" = {
          Value = 5;
          Status = "locked";
        };
        "signon.management.page.breach-alerts.enabled" = {
          Value = false;
          Status = "locked";
        };
      };
    };
    profiles.bartek = {
      isDefault = true;
      containersForce = true;

      extensions = with inputs.firefox-addons.packages."x86_64-linux"; [
        bitwarden
        ublock-origin
        darkreader
        vimium
        # vimium-c
        consent-o-matic # Automatic handling of GDPR consent forms
        # container-tabs-sidebar
        # enhanced-github
        # facebook-container
        # firefox-translations
        # floccus # Sync your bookmarks and tabs across browsers via Nextcloud, any WebDAV service, any Git service, via a local file, via Google Drive.
        sidebartabs
        libredirect
        lovely-forks
        refined-github
        unwanted-twitch
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

          iconUpdateURL = "https://docs.searxng.org/_static/searxng-wordmark.svg";
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
        user_pref("extensions.autoDisableScopes", 0);
        user_pref("extensions.enabledScopes", 15);
      '';

      userChrome = ''
        @import "firefox-nordic-theme/userChrome.css";
      '';

      settings = {
        "apz.doubletapzoom.defaultzoomin" = 1.2; # default zoom value
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

        "app.shield.optoutstudies.enabled" = false;
        "content.notify.interval" = 100000;
        "privacy.donottrackheader.enabled" = true;
        "privacy.firstparty.isolate" = true;
        "privacy.globalprivacycontrol.enabled" = true;
        "startup.homepage_override_url" = "";
        "startup.homepage_welcome_url" = "";
        "startup.homepage_welcome_url.additional" = "";
        "dom.security.https_only_mode" = true;
        "identity.fxaccounts.enabled" = false;
        "privacy.trackingprotection.enabled" = true;
        "signon.rememberSignons" = true;
      };
    };
  };
}
