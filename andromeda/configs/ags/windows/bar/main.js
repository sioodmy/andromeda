import Battery from "./modules/battery.js";
import Bluetooth from "./modules/bluetooth.js";
import Date from "./modules/date.js";
import Net from "./modules/net.js";
import CpuRam from "./modules/cpu_ram.js";

const SystemInfo = () =>
  Widget.EventBox({
    className: "system-menu-toggler",
    onPrimaryClick: () => App.toggleWindow("system-menu"),

    child: Widget.Box({
      children: [Net(), Bluetooth(), Battery()],
    }),
  }).hook(App, (self, window, visible) => {
    if (window === "system-menu") {
      self.toggleClassName("active", visible);
    }
  });

const Start = () =>
  Widget.Box({
    hexpand: true,
    hpack: "start",
    children: [
      // Indicators
    ],
  });

const Center = () =>
  Widget.Box({
    children: [Date()],
  });

const End = () =>
  Widget.Box({
    hexpand: true,
    hpack: "end",

    children: [CpuRam(), SystemInfo()],
  });

export default () =>
  Widget.Window({
    monitor: 0,
    name: `bar`,
    anchor: ["top", "left", "right"],
    exclusivity: "exclusive",

    child: Widget.CenterBox({
      className: "bar",

      startWidget: Start(),
      centerWidget: Center(),
      endWidget: End(),
    }),
  });
