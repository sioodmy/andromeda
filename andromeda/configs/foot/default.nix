{
  inputs,
  pkgs,
  ...
}: let
  config = pkgs.writeText "foot.ini" ''
    [bell]
    command=notify-send bell
    command-focused=no
    notify=yes
    urgent=yes

    [colors]
    alpha=1.0
    background=303446
    bright0=626880
    bright1=e78284
    bright2=a6d189
    bright3=e5c890
    bright4=8caaee
    bright5=f4b8e4
    bright6=81c8be
    bright7=a5adce
    foreground=c6d0f5
    regular0=51576d
    regular1=e78284
    regular2=a6d189
    regular3=e5c890
    regular4=8caaee
    regular5=f4b8e4
    regular6=81c8be
    regular7=b5bfe2

    [cursor]
    beam-thickness=2
    style=beam

    [key-bindings]
    show-urls-launch=Control+Shift+u
    unicode-input=Control+Shift+i

    [main]
    app-id=foot
    bold-text-in-bright=no
    dpi-aware=yes
    font=monospace:size=9
    locked-title=no
    notify=notify-send -a $/{app-id} -i $/{app-id} $/{title} $/{body}
    pad=12x21 center
    resize-delay-ms=100
    selection-target=primary
    shell=${inputs.self.packages.${pkgs.system}.nucleus}/bin/nucleus
    term=xterm-256color
    title=foot
    vertical-letter-offset=-0.75
    word-delimiters=,│`|:"'()[]{}<>

    [mouse]
    hide-when-typing=yes

    [mouse-bindings]
    primary-paste=BTN_MIDDLE
    select-begin=BTN_LEFT
    select-begin-block=Control+BTN_LEFT
    select-extend=BTN_RIGHT
    select-extend-character-wise=Control+BTN_RIGHT
    select-word=BTN_LEFT-2
    select-word-whitespace=Control+BTN_LEFT-2
    selection-override-modifiers=Shift

    [scrollback]
    lines=10000
    multiplier=3

    [url]
    label-letters=sadfjklewcmpgh
    launch=xdg-open $\{url}
    osc8-underline=url-mode
    protocols=http, https, ftp, ftps, file, gemini, gopher, irc, ircs
    uri-characters=abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-_.,~:;/?#@!$&%*+="'()[]

  '';
in {
  basePackage = pkgs.foot;
  flags = ["--config=${config}"];
}
