{
  pkgs,
  cfg,
  ...
}: let
  getExe = pkgs.lib.getExe;
in
        def --wrapped bs [...args] {
          bash -c ...$args
        }

        let direnv_installed = not (which direnv | is-empty)


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

            _ => $carapace_completer
          } | do $in $spans
        }

        $env.config = {
          show_banner: false,
          render_right_prompt_on_last_line: true
            completions: {
              quick: true
              partial: true
              case_sensitive: false
              algorithm: "fuzzy"
               external: {
                enable: true,
                completer: $multiple_completers
               }
          },
          rm: {
            always_trash: true
          }
          table: {
            mode: compact
            index_mode: auto
          }
          hooks: {
            pre_prompt: {
              if not $direnv_installed {
                return
              }

              direnv export json | from json | default {} | load-env
            }
            command_not_found: {
              |cmd_name| (
                if ($nu.os-info.name == "linux" and 'CNF' in $env) {try {
                  let raw_results = (nix-locate --minimal --no-group --type x --type s --top-level --whole-name --at-root $"/bin/($cmd_name)")
                  let parsed = ($raw_results | split row "\n" | each {|elem| ($elem | parse "{attr}.{output}" | first) })
                  let names = ($parsed | each {|row|
                    if ($row.output == "out") {
                      $row.attr
                    } else {
                      $"($row.attr).($row.output)"
                    }
                  })
                  let names_display = ($names | str join "\n")
                  (
                    "nix-index found the follwing matches:\n\n" + $names_display
                  )
                } catch {
                  null
                }}
              )
            }
          }
          keybindings: [
        {
          name: completion_menu
          modifier: none
          keycode: tab
          mode: [emacs vi_normal vi_insert]
          event: {
              until: [
              { send: menu name: completion_menu }
              { send: menunext }
              ]
          }
        }
      ]
        history: {
      file_format: "sqlite"
    }
    filesize: {
      metric: false
    }
    highlight_resolved_externals: true
        }


  ''
