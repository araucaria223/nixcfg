{
  pkgs,
  settings,
  config,
}: let
  themeContent = with config.colorScheme.palette; ''
    [General]

    Background="${builtins.baseNameOf "${settings.wallpaper}"}"
    ScaleImageCropped=true

    ScreenWidth=${settings.screenWidth}
    ScreenHeight=${settings.screenHeight}

    MainColor="#${base05}"
    AccentColor="#${base0A}"
    RoundCorners=20
    ScreenPadding=30
    Font="monospace"
    FontSize=

    Locale=
    HourFormat="HH:mm"
    DateFormat="dddd, d of MMMM"

    ForceRightToLeft=false
    ForceLastUser=true
    ForcePasswordFocus=true
    ForceHideCompletePassword=true
    ForceHideVirtualKeyboardButton="false"

    HeaderText=Welcome!
    ## Header can be empty to not display any greeting at all. Keep it short.

    TranslateUsernamePlaceholder=""
    TranslatePasswordPlaceholder=""
    TranslateShowPassword=""
    TranslateLogin=""
    TranslateLoginFailedWarning=""
    TranslateCapslockWarning=""
    TranslateSession=""
    TranslateSuspend=""
    TranslateHibernate=""
    TranslateReboot=""
    TranslateShutdown=""
    TranslateVirtualKeyboardButton=""
  '';
in
  pkgs.stdenv.mkDerivation {
    name = "sddm-sugar-dark";
    src = pkgs.fetchFromGitHub {
      owner = "MarianArlt";
      repo = "sddm-sugar-dark";
      rev = "ceb2c455663429be03ba62d9f898c571650ef7fe";
      sha256 = "0153z1kylbhc9d12nxy9vpn0spxgrhgy36wy37pk6ysq7akaqlvy";
    };

    installPhase = ''
      mkdir -p $out
      cp -R ./* $out/
      cd $out/
      rm Background.jpg
      cp -r ${settings.wallpaper} $out/
      echo "${themeContent}" > $out/theme.conf
    '';
  }
