{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: rec {
  cfg = config.greetd;

  greeter = pkgs.writeText "greeter.js" /*javascript*/ ''
    const greetd = await Service.import('greetd');

    const name = Widget.Entry({
      placeholder_text: 'Username',
      on_accept: () => password.grab_focus(),
    })

    const password = Widget.Entry({
      placeholder_text: 'Password',
      visibility: false,
      on_accept: () => {
	greetd.login(name.text || "", password.text || "", 'Hyprland')
	  .catch(err => response.label = JSON.stringify(err))
	},
    })

    const response = Widget.Label()

    const win = Widget.Window({
      css: 'backround-color: transparent;',
      anchor: ['top', 'left', 'right', 'bottom'],
      keymode: 'exclusive',
      child: Widget.Box({
	vertical: true,
	hpack: 'center',
	vpack: 'center',
	hexpand: true,
	vexpand: true,
	children: [
	  name,
	  password,
	  response,
	],
      }),
    })

    App.config({ windows: [win] })
  '';

  hyprlandConfig = pkgs.writeText "greetd-hyprland-config" ''
    exec-once = ${inputs.ags.packages."${pkgs.stdenv.hostPlatform.system}".ags}/bin/ags --config ${greeter}; ${inputs.hyprland.packages."${pkgs.stdenv.hostPlatform.system}".hyprland}/bin/hyprctl dispatch exit
  '';

  options.greetd = {
    enable = lib.mkEnableOption ''
      Enables greetd
    '';
  };

  config = lib.mkIf cfg.enable {
    services.greetd = {
      enable = true;
      settings = {
	default_session.command = "${inputs.hyprland.packages."${pkgs.stdenv.hostPlatform.system}".hyprland}/bin/Hyprland --config ${hyprlandConfig}"
      };
    };
  };
}
