import { Utils, Widget } from "../../../imports.js";
import GLib from "gi://GLib";

let date = Variable(GLib.DateTime.new_now_local(), {
  poll: [1000, () => GLib.DateTime.new_now_local()],
});

export default () =>
  Widget.Label({
    label: date.bind().as((d) => d.format("%H:%M ")?.toString() ?? ""),
    tooltip_text: date.bind().as((d) => d.format("%a %d.%m ")?.toString() ?? ""),

    class_name: "date",
    vexpand: true,
  });
