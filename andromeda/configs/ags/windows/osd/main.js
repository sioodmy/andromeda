import App from "resource:///com/github/Aylur/ags/app.js";
import { Audio, Widget } from "../../imports.js";

import Brightness from "../../services/brightness.js";
import Indicators from "../../services/osd.js";
import PopupWindow from "../../utils/popup_window.js";

// connections
Audio.connect("speaker-changed", () =>
  Audio.speaker.connect("changed", () => {
    if (!App.getWindow("system-menu")?.visible) {
      Indicators.speaker();
    }
  }),
);
Audio.connect("microphone-changed", () =>
  Audio.microphone.connect("changed", () => Indicators.mic()),
);

Brightness.connect("screen-changed", () => {
  if (!App.getWindow("system-menu")?.visible) {
    Indicators.display();
  }
});

let lastMonitor;

const child = () =>
  Widget.Box({
    hexpand: true,
    visible: false,
    className: "osd",

    children: [
      Widget.ProgressBar({
        hexpand: true,
        vertical: false,
      }).hook(Indicators, (self, props) => {
        self.value = props?.value ?? 0;
        self.visible = props?.showProgress ?? false;
      }),
    ],
  });

export default () =>
  PopupWindow({
    name: "osd",
    monitor: 0,
    layer: "overlay",
    child: child(),
    click_through: true,
    anchor: ["top"],
    revealerSetup: (self) =>
      self.hook(Indicators, (revealer, _, visible) => {
        revealer.reveal_child = visible;
      }),
  }).hook(Indicators, (win, _, visible) => {
    win.visible = visible;
  });
