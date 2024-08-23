import GLib from "gi://GLib?version=2.0"

declare global {
	const TMP: string
	const USER: string
}

Object.assign(globalThis, {
	TMP: `${GLib.get_tmp_dir()}/ags`,
	USER: GLib.get_user_name(),
})

Utils.ensureDirectory(TMP)
App.addIcons(`${App.configDir}/assets`)
