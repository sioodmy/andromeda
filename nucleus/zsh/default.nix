{
  pkgs,
  aliasesStr,
}:
pkgs.writeShellScriptBin ".zshrc" ''

  source ${./starship.zsh}
  source ${./zoxide.zsh}

  source ${./config.zsh}

  source ${pkgs.zsh-fast-syntax-highlighting}/share/zsh/site-functions/fast-syntax-highlighting.plugin.zsh
  source ${pkgs.zsh-nix-shell}/share/zsh-nix-shell/nix-shell.plugin.zsh
  source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh

  ${aliasesStr}
''
