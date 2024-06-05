const WINDOW_NAME = "launcher";
const Applications = await Service.import("applications");
import PopupWindow from "../../utils/popup_window.js";

const truncateString = (str, maxLength) =>
  str.length > maxLength ? `${str.slice(0, maxLength)}...` : str;

const AppItem = (app) =>
  Widget.Button({
    className: "launcherApp",
    onClicked: () => {
      App.closeWindow(WINDOW_NAME);
    },
    setup: (self) => (self.app = app),
    child: Widget.Box({
      children: [
        Widget.Icon({
          className: "launcherItemIcon",
          icon: app.iconName || "",
          size: 24,
        }),
        Widget.Box({
          className: "launcherItem",
          vertical: true,
          vpack: "center",
          children: [
            Widget.Label({
              className: "launcherItemTitle",
              label: app.name,
              xalign: 0,
              vpack: "center",
              truncate: "end",
            }),
          ],
        }),
      ],
    }),
  });

const Launcher = () => {
  const list = Widget.Box({ vertical: true });

  const entry = Widget.Entry({
    className: "launcherEntry",
    hexpand: true,
    text: "-",
    onAccept: ({ text }) => {
      const isCommand = text.startsWith(">");
      const appList = Applications.query(text || "");
      if (isCommand === true) {
        App.toggleWindow(WINDOW_NAME);
        Utils.execAsync(text.slice(1));
      } else if (appList[0]) {
        App.toggleWindow(WINDOW_NAME);
        appList[0].launch();
      }
    },
    onChange: ({ text }) =>
      list.children.map((item) => {
        item.visible = item.app.match(text);
      }),
  });

  return Widget.Box({
    className: "launcherWindow",
    vertical: true,
    setup: (self) => {
      self.hook(App, (_, name, visible) => {
        if (name !== WINDOW_NAME) return;

        list.children = Applications.list.map(AppItem);

        entry.text = "";
        if (visible) entry.grab_focus();
      });
    },
    children: [
      entry,
      Widget.Scrollable({
        hscroll: "never",
        css: "min-width: 180px; min-height: 360px;",
        child: list,
      }),
    ],
  });
};

export default () =>
  Widget.Window({
    name: WINDOW_NAME,
    setup: (self) =>
      self.keybind("Escape", () => {
        App.closeWindow(WINDOW_NAME);
      }),
    visible: false,
    keymode: "exclusive",
    child: Launcher(),
  });
