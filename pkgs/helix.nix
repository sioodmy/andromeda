{
  pkgs,
  inputs,
  ...
}: let
  toml = pkgs.formats.toml {};

  settings = {
    theme = "catppuccin_frappe";
    keys.normal = {
      "{" = "goto_prev_paragraph";
      "}" = "goto_next_paragraph";
      "X" = "extend_line_above";
      "esc" = ["collapse_selection" "keep_primary_selection"];
      space.space = "file_picker";
      space.w = ":w";
      space.q = ":bc";
      "C-q" = ":xa";
      space.u = {
        f = ":format"; # format using LSP formatter
        w = ":set whitespace.render all";
        W = ":set whitespace.render none";
      };
    };
    keys.select = {
      "%" = "match_brackets";
    };
    editor = {
      color-modes = true;
      cursorline = true;
      mouse = false;
      idle-timeout = 1;
      line-number = "relative";
      scrolloff = 5;
      rainbow-brackets = true;
      completion-replace = true;
      bufferline = "always";
      true-color = true;
      rulers = [80];
      soft-wrap.enable = true;
      indent-guides = {
        render = true;
      };
      lsp = {
        display-messages = true;
        display-inlay-hints = true;
      };
      sticky-context = {
        enable = true;
        indicator = false;
      };

      gutters = ["diagnostics" "line-numbers" "spacer" "diff"];
      statusline = {
        left = ["mode" "selections" "spinner" "file-name" "total-line-numbers"];
        center = ["position-percentage"];
        right = ["diagnostics" "file-encoding" "file-line-ending" "file-type" "position"];
        mode = {
          normal = "NORMAL";
          insert = "INSERT";
          select = "SELECT";
        };
      };

      whitespace.characters = {
        space = "·";
        nbsp = "⍽";
        tab = "→";
        newline = "⤶";
      };

      cursor-shape = {
        insert = "bar";
        normal = "block";
        select = "underline";
      };
    };
  };
in
  inputs.wrapper-manager.lib.build {
    inherit pkgs;
    modules = [
      {
        wrappers.helix = {
          basePackage = inputs.helix.packages.${pkgs.system}.default;
          flags = [
            "--config"
            (toml.generate "config.toml" settings)
          ];
          pathAdd = with pkgs; [
            clang-tools
            marksman
            nil
            nodePackages.bash-language-server
            nodePackages.vscode-css-languageserver-bin
            nodePackages.vscode-langservers-extracted
            shellcheck
            typst-lsp
          ];
        };
      }
    ];
  }
