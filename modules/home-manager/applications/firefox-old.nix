{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: let
  cfg = config.firefox;
in {
  options.firefox = {
    enable = lib.mkEnableOption "Enables firefox per-user configuration";
  };

  config = lib.mkIf cfg.enable {
    # persist firefox's data
    home.persistence."/persist/home/${config.home.username}".directories = [".mozilla"];

    programs.firefox = {
      enable = true;

      profiles = {
        "tester" = {
	  id = 1;
          bookmarks = [
            {
              name = "NixOS Wiki";
              tags = ["wiki" "nix"];
              url = "https://wiki.nixos.org";
            }
          ];

	  settings = {
            "browser.download.dir" = "${config.home.homeDirectory}/loads";
	  };
        };

        "${config.home.username}" = {
          bookmarks = [
            {
              name = "NixOS Wiki";
              tags = ["wiki" "nix"];
              url = "https://wiki.nixos.org";
            }
          ];

          extensions = with inputs.firefox-addons.packages."x86_64-linux"; [
            ublock-origin
            clearurls
            privacy-badger
            disable-javascript
            sponsorblock
            youtube-shorts-block
            old-reddit-redirect
            reddit-enhancement-suite
          ];

          search.engines = {
            "Nix packages" = {
              urls = [
                {
                  template = "https://search.nixos.org/packages";
                  params = [
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
                }
              ];

              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = ["@np"];
            };

            "NixOS Options" = {
              urls = [
                {
                  template = "https://search.nixos.org/options";
                  params = [
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
                }
              ];

              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = ["@no"];
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

              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = ["@hmo"];
            };
          };
          search.force = true;

          settings = {
            "browser.topsites.contile.enabled" = false;
            "browser.newtabpage.activity-stream.system.showSponsored" = false;
            "app.normandy.first_run" = false;
            "app.shield.optoutstudies.enabled" = false;

            "extensions.pocket.enabled" = false;
            "extensions.pocket.showHome" = false;
            "browser.newtabpage.activity-stream.feeds.recommendationProvider" = false;
            "extensions.pocket.site" = "";

            #"extensions.autoDisableScopes" = 0; # dodgy business

            "app.update.channel" = "default";
            "browser.contentblocking.category" = "standard";
            "browser.ctrlTab.recentlyUsedOrder" = false;

            "browser.download.dir" = "${config.home.homeDirectory}/loads";
            #"browser.download.lastDir" = "${config.home.homeDirectory}/loads";
            #"browser.download.folderList" = 2;

            "browser.download.viewableInternally.typeWasRegistered.svg" = true;
            "browser.download.viewableInternally.typeWasRegistered.webp" = true;
            "browser.download.viewableInternally.typeWasRegistered.xml" = true;

            "browser.tabs.closeWindowWithLastTab" = false;
            "middlemouse.paste" = false;

            "browser.link.open_newwindow" = true;
            "browser.shell.checkDefaultBrowser" = false;
            "browser.startup.homepage" = "https://nixos.org";
            "browser.urlbar.showSearchSuggestionsFirst" = false;

            "browser.urlbar.quickactions.enabled" = false;
            "browser.urlbar.quickactions.showPrefs" = false;
            "browser.urlbar.shortcuts.quickactions" = false;
            "browser.urlbar.suggest.quickactions" = false;

            "doh-rollout.balrog-migration-done" = true;
            "doh-rollout.doneFirstRun" = true;

            "dom.forms.autocomplete.formautofill" = false;

            "general.autoScroll" = true;
            "general.useragent.locale" = "en-GB";

            "extensions.update.enabled" = false;
            "extensions.webcompat.enable_picture_in_picture_overrides" = true;
            "extensions.webcompat.enable_shims" = true;
            "extensions.webcompat.perform_injections" = true;
            "extensions.webcompat.perform_ua_overrides" = true;

            "print.print_footerleft" = "";
            "print.print_footerright" = "";
            "print.print_headerleft" = "";
            "print.print_headerright" = "";

            "privacy.donottrackheader.enabled" = true;

            "dom.security.https_only_mode" = true;
            "signon.rememberSignons" = false;
            "widget.use-xdg-desktop-portal.file-picker" = 1;
            "browser.aboutConfig.showWarning" = false;
            "widget.disable-workspace-management" = true;
            "browser.toolbars.bookmarks.visibility" = "never";

            "accessibility.force_disabled" = 1;
            "app.normandy.api_url" = "";
            "app.normandy.enabled" = false;

            "browser.discovery.enabled" = false;
            "browser.helperApps.deleteTempFileOnExit" = true;

            "browser.newtabpage.activity-stream.default.sites" = "";
            "browser.newtabpage.activity-stream.feeds.topsites" = false;
            "browser.newtabpage.activity-stream.showSponsored" = false;
            "browser.newtabpage.activity-stream.feeds.system.topstories" = false;
            "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
            "browser.uitour.enabled" = false;

            "geo.provider.use_gpsd" = false;
            "geo.provider.use_geoclue" = false;

            "extensions.getAddons.showPane" = false;
            "extensions.htmlaboutaddons.recommendations.enabled" = false;

            "network.connectivity-service.enabled" = false;

            "browser.urlbar.suggest.calculator" = true;

            "datareporting.policy.dataSubmissionEnabled" = false;
            "datareporting.healthreport.uploadEnabled" = false;
            "toolkit.telemetry.unified" = false;
            "toolkit.telemetry.enabled" = false;
            "toolkit.telemetry.server" = "data:,";
            "toolkit.telemetry.archive.enabled" = false;
            "toolkit.telemetry.newProfilePing.enabled" = false;
            "toolkit.telemetry.coverage.opt-out" = true;
            "toolkit.coverage.opt-out" = true;
            "toolkit.coverage.endpoint.base" = "";
            "browser.ping-centre.telemetry" = false;
            "browser.newtabpage.activity-stream.feeds.telemetry" = false;
            "browser.newtabpage.activity-stream-telemetry" = false;
            "toolkit.telemetry.reportingpolicy.firstRun" = false;
            "toolkit.telemetry.shutdownPingSender.enabledFirstsession" = false;
            "browser.vpn_promo.enabled" = false;

            "trailhead.firstrun.branches" = "nofirstrun-empty";
            "browser.aboutwelcome.enabled" = false;
          };
        };
      };
    };
  };
}
