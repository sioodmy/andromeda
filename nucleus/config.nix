{
  pkgs,
  cfg,
  ...
}: let
  getExe = pkgs.lib.getExe;
in
  with cfg.theme.colors; ''
      $env.config.color_config = {
        seperator: "${base03}"
        leading_trailing_space_bg: "${base04}"
        header: "${base0B}"
        date: "${base0E}"
        filesize: "${base0D}"
        row_index: "${base0C}"
        bool: "${base08}"
        int: "${base0B}"
        duration: "${base08}"
        range: "${base08}"
        float: "${base08}"
        string: "${base04}"
        nothing: "${base08}"
        binary: "${base08}"
        cellpath: "${base08}"
        hints: dark_gray

        shape_garbage: { fg: "${base07}" bg: "${base08}" }
        shape_bool: "${base0D}"
        shape_int: { fg: "${base0E}" attr: b }
        shape_float: { fg: "${base0E}" attr: b }
        shape_range: { fg: "${base0A}" attr: b }
        shape_internalcall: { fg: "${base0C}" attr: b }
        shape_external: "${base0C}"
        shape_externalarg: { fg: "${base0B}" attr: b }
        shape_literal: "${base0D}"
        shape_operator: "${base0A}"
        shape_signature: { fg: "${base0B}" attr: b }
        shape_string: "${base0B}"
        shape_filepath: "${base0D}"
        shape_globpattern: { fg: "${base0D}" attr: b }
        shape_variable: "${base0E}"
        shape_flag: { fg: "${base0D}" attr: b }
        shape_custom: { attr: b }
      }
    def --wrapped bs [...args] {
      bash -c ...$args
    }

    def --wrapped hd [...args] {
      mut params = $args | split list '--';

      if ($args | length) == 0 or $args.0 == '--' { $params = ($params | prepend [[]]) };

      if ($params | length) == 1 { $params = [$params.0, []]; };

      nh os switch ...$params.0 -- --impure ...$params.1
    }

    export-env { load-env {
        STARSHIP_SHELL: "nu"
        STARSHIP_SESSION_KEY: (random chars -l 16)
        PROMPT_MULTILINE_INDICATOR: (
            ^${getExe pkgs.starship} prompt --continuation
        )

        # Does not play well with default character module.
        # TODO: Also Use starship vi mode indicators?
        PROMPT_INDICATOR: ""

        PROMPT_COMMAND: {||
            # jobs are not supported
            (
                ^${getExe pkgs.starship} prompt
                    --cmd-duration $env.CMD_DURATION_MS
                    $"--status=($env.LAST_EXIT_CODE)"
                    --terminal-width (term size).columns
            )
        }

        config: ($env.config? | default {} | merge {
            render_right_prompt_on_last_line: true
        })

        PROMPT_COMMAND_RIGHT: {||
            (
                ^${getExe pkgs.starship} prompt
                    --right
                    --cmd-duration $env.CMD_DURATION_MS
                    $"--status=($env.LAST_EXIT_CODE)"
                    --terminal-width (term size).columns
            )
        }
    }}

    let carapace_completer = {|spans|
      ${getExe pkgs.carapace} $spans.0 nushell ...$spans | from json
    }

    let fish_completer = {|spans|
      ${getExe pkgs.fish} --command $'complete "--do-complete=($spans | str join " ")"'
      | $"value(char tab)description(char newline)" + $in
      | from tsv --flexible --no-infer
    }

    let zoxide_completer = {|spans|
        $spans | skip 1 | ${getExe pkgs.zoxide} query -l ...$in | lines | where {|x| $x != $env.PWD}
    }

    let multiple_completers = {|spans|
      let expanded_alias = scope aliases | where name == $spans.0 | get -i 0.expansions

      let spans = if $expanded_alias != null {
        $spans | skip 1 | prepend ($expanded_alias | split row ' ' | take 1)
      } else {
        $spans
      }

      match $spans.0 {
        nu => $fish_completer,${
      /*
      carapace incorrectly completes nu
      */
      ""
    }
        git => $fish_completer,${
      /*
      fish completes commits and branch names nicely
      */
      ""
    }
        ssh => $fish_completer,${
      /*
      fish completes hosts from ssh config
      */
      ""
    }

        z => $zoxide_completer,

        _ => $carapace_completer
      } | do $in $spans
    }

    $env.config = {
      show_banner: false,
      completions: {
        external: {
          enable: true,
          completer: $multiple_completers
        }
      },
    }


  ''
