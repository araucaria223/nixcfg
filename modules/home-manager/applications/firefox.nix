{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: let
  cfg = config.firefox;

  lock-false = {
    Value = false;
    Status = "locked";
  };

  lock-true = {
    Value = true;
    Status = "locked";
  };
in {
  options.firefox = {
    enable = lib.mkEnableOption "Enables firefox";
  };

  config = lib.mkIf cfg.enable {
    # persist firefox's data
    home.persistence."/persist/home/${config.home.username}".directories = [".mozilla"];

    programs.firefox = {
      enable = true;

      policies = {
        DisableAppUpdate = true;
        DefaultDownloadDirectory = "${config.home.homeDirectory}/loads";
        DisableFirefoxStudies = true;
        EnableTrackingProtection = {
          Value = true;
          Locked = true;
          Cryptomining = true;
          Fingerprinting = true;
        };
        DisableFirefoxAccounts = true;
        DisableAccounts = true;
        DisableFirefoxScreenshots = true;
        OverrideFirstRunPage = "";
        OverridePostUpdatePage = "";
        DisplayBookmarksToolbar = "never";
        DisableMasterPasswordCreation = true;
        DisablePocket = true;
        DisableProfileImport = true;
        DisableSetDesktopBackground = true;
        DisableTelemetry = true;
        DontCheckDefaultBrowser = true;
        DownloadDirectory = "${config.home.homeDirectory}/loads";
        PromptForDownloadLocation = false;
        SearchSuggestEnabled = false;

        ExtensionSettings = with builtins; let
          ext = shortId: uuid: {
            name = uuid;
            value = {
              install_url = "https://addons.mozilla.org/en-US/firefox/downloads/latest/${shortId}/latest.xpi";
              installation_mode = "force_installed";
            };
          };
        in
          listToAttrs [
            (ext "ublock-origin" "uBlock0@raymondhill.net")
            (ext "sponsorblock" "sponsorBlocker@ajay.app")
            (ext "search_by_image" "{2e5ff8c8-32fe-46d0-9fc8-6b8986621f3c}")
            (ext "clearurls" "{74145f27-f039-47ce-a470-a662b129930a}")
            (ext "violentmonkey" "{aecec67f-0d10-4fa7-b7c7-609a2db280cf}")
            (ext "buster-captcha-solver" "{e58d3966-3d76-4cd9-8552-1582fbc800c1}")
            (ext "terms-of-service-didnt-read" "jid0-3GUEt1r69sQNSrca5p8kx9Ezc3U@jetpack")
            (ext "youtube-shorts-block" "{34daeb50-c2d2-4f14-886a-7160b24d66a4}")
            (ext "old-reddit-redirect" "{9063c2e9-e07c-4c2c-9646-cfe7ca8d0498}")
            (ext "reddit-enhancement-suite" "jid1-xUfzOsOFlzSOXg@jetpack")
            (ext "keepassxc-browser" "keepassxc-browser@keepassxc.org")
          ];

        Preferences = {
          "browser.contentblocking.category" = {
            Value = "strict";
            Status = "locked";
          };
          "extensions.pocket.enabled" = lock-false;
          "extensions.screenshots.disabled" = lock-false;
          "browser.topsites.contile.enabled" = lock-false;
          "browser.formfill.enable" = lock-false;
          "browser.search.suggest.enabled" = lock-false;
          "browser.search.suggest.enabled.private" = lock-false;
          "browser.urlbar.suggest.searches" = lock-false;
          "browser.urlbar.showSearchSuggestionsFirst" = lock-false;
          "browser.newtabpage.activity-stream.feeds.section.topstories" = lock-false;
          "browser.newtabpage.activity-stream.feeds.snippets" = lock-false;
          "browser.newtabpage.activity-stream.section.highlights.includePocket" = lock-false;
          "browser.newtabpage.activity-stream.section.highlights.includeBookmarks" = lock-false;
          "browser.newtabpage.activity-stream.section.highlights.includeDownloads" = lock-false;
          "browser.newtabpage.activity-stream.section.highlights.includeVisited" = lock-false;
          "browser.newtabpage.activity-stream.showSponsored" = lock-false;
          "browser.newtabpage.activity-stream.system.showSponsored" = lock-false;
          "browser.newtabpage.activity-stream.showSponsoredTopSites" = lock-false;
        };
      };

      profiles."${config.home.username}" = {
        settings = {
          "browser.startup.homepage" = "https://searxng.site";
        };

        bookmarks = [
          {
            name = "NixOS Wiki";
            tags = ["wiki" "nix"];
            url = "https://wiki.nixos.org";
          }

          {
            name = "NixOS User Wiki";
            tags = ["wiki" "nix" "unofficial"];
            url = "https://nixos.wiki";
          }
        ];

        search.force = true;
        search.default = "SearXNG";
        search.engines = let
          prms = [
            {
              name = "type";
              value = "packages";
            }
            {
              name = "query";
              value = "{searchTerms}";
            }
            {
              name = "channel";
              value = "unstable";
            }
          ];

          snowflake = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";

          daily = 24 * 60 * 60 * 1000;
          prefix = ".";
        in {
          # bloat
          "Bing".metaData.hidden = true;
          "eBay".metaData.hidden = true;

          # alias shortening
          "Google".metaData.alias = "${prefix}g";
          "DuckDuckGo".metaData.alias = "${prefix}ddg";

          "SearXNG" = {
            urls = [
              {
                template = "https://search.inetol.net/search";
                params = [
                  {
                    name = "q";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
            iconUpdateURL = "https://searxng.site/favicon.ico";
            updateInterval = daily;
            definedAliases = ["${prefix}sx"];
          };

          "Nix packages" = {
            urls = [
              {
                template = "https://search.nixos.org/packages";
                params = prms;
              }
            ];
            icon = snowflake;
            definedAliases = ["${prefix}np"];
          };

          "NixOS Options" = {
            urls = [
              {
                template = "https://search.nixos.org/options";
                params = prms;
              }
            ];
            icon = snowflake;
            definedAliases = ["${prefix}no"];
          };

          "Home Manager Options" = {
            urls = [
              {
                template = "https://home-manager-options.extranix.com";
                params = [
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                  {
                    name = "release";
                    value = "master";
                  }
                ];
              }
            ];
            iconUpdateURL = "https://home-manager-options.extranix.com/images/favicon.png";
            updateInterval = daily;
            definedAliases = ["${prefix}hmo"];
          };

          "MyNixOS Search" = {
            urls = [
              {
                template = "https://mynixos.com/search";
                params = [
                  {
                    name = "q";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
            iconUpdateURL = "https://mynixos.com/favicon.ico";
            updateInterval = daily;
            definedAliases = ["${prefix}mn"];
          };

          "NixOS Wiki" = {
            urls = [
              {
                template = "https://wiki.nixos.org/w/index.php";
                params = [
                  {
                    name = "search";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
            icon = snowflake;
            definedAliases = ["${prefix}nw"];
          };

          "NyaaSi Search" = {
            urls = [
              {
                template = "https://nyaa.si";
                params = [
                  {
                    name = "q";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
            iconUpdateURL = "https://nyaa.si/static/favicon.png";
            updateInterval = daily;
            definedAliases = ["${prefix}ny"];
          };

          "NyaaSi SubsPlease Search" = {
            urls = [
              {
                template = "https://nyaa.si/user/subsplease";
                params = [
                  {
                    name = "q";
                    value = "{searchTerms} 1080p";
                  }
                ];
              }
            ];
            iconUpdateURL = "https://nyaa.si/static/favicon.png";
            updateInterval = daily;
            definedAliases = ["${prefix}sp"];
          };

          "Youtube search" = {
            urls = [
              {
                template = "https://www.youtube.com/results";
                params = [
                  {
                    name = "search_query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
            iconUpdateURL = "https://www.youtube.com/s/desktop/060ac52e/img/favicon.ico";
            updateInterval = daily;
            definedAliases = ["${prefix}yt"];
          };
        };
      };
    };
  };
}
