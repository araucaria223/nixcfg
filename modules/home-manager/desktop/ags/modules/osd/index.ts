import brightness from "services/brightness"
import ( OSDLabel ) from "./label";
import { OSDBar } from "./bar";
import { OSDIcon } from "./icon";
import { getPosition } from "lib/utils";
const hyprland = await Service.import("hyprland");
const audio = await Service.import("audio")


const DELAY = 2500;
let count = 0
const handleReveal = (self: any, property: string) => {
    self[property] = true
    count++
    Utils.timeout(DELAY, () => {
        count--

        if (count === 0)
            self[property] = false
    })
}

const renderOSD = () => {
    return Widget.Revealer({
        transition: "crossfade",
        reveal_child: false,
        setup: self => {
            self.hook(brightness, () => {
                handleReveal(self, "reveal_child");
            }, "notify::screen")
            self.hook(brightness, () => {
                handleReveal(self, "reveal_child");
            }, "notify::kbd")
            self.hook(audio.microphone, () => {
                handleReveal(self, "reveal_child");
            }, "notify::volume")
            self.hook(audio.microphone, () => {
                handleReveal(self, "reveal_child");
            }, "notify::is-muted")
            self.hook(audio.speaker, () => {
                handleReveal(self, "reveal_child");
            }, "notify::volume")
            self.hook(audio.speaker, () => {
                handleReveal(self, "reveal_child");
            }, "notify::is-muted")
        }
    })
}