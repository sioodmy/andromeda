{pkgs, ...}: let
  nvfetcher = builtins.mapAttrs (name: value:
    pkgs.vimUtils.buildVimPlugin {
      inherit name;
      inherit (value) src;
    }) (pkgs.callPackages ./_sources/generated.nix {});

  neovimConfig = pkgs.neovimUtils.makeNeovimConfig {
    withPython3 = false;
    withRuby = false;
    withNodeJs = false;
    customRC = ''
      source ${./init.vim}
      :luafile ${./init.lua}
    '';

    plugins =
      (builtins.attrValues nvfetcher)
      ++ (with pkgs.vimPlugins; [
        catppuccin-nvim
        bufferline-nvim
        lualine-nvim
        nvim-web-devicons
        gitsigns-nvim
        indent-blankline-nvim-lua
        nvim-autopairs
        neoformat
        comment-nvim
        vim-speeddating
        luasnip
        vim-startuptime
        which-key-nvim
        telescope-nvim
        harpoon

        # Language support
        nvim-lspconfig
        nvim-cmp
        cmp-cmdline
        cmp-nvim-lsp
        cmp-buffer
        cmp-path

        nvim-treesitter.withAllGrammars

        orgmode

        nui-nvim
        plenary-nvim
      ]);
  };
in {
  basePackage = pkgs.wrapNeovimUnstable pkgs.neovim-unwrapped neovimConfig;
  # mostly LSP related packages
  pathAdd = with pkgs; [
    gopls
    go
    nil
    rust-analyzer
    alejandra
    nodePackages.bash-language-server
    nodePackages.vscode-css-languageserver-bin
    nodePackages.vscode-langservers-extracted
    nodePackages.typescript-language-server
    nodePackages.prettier
    shellcheck
    cargo
    nixd
    typst-lsp
    stylua
  ];
  renames = {
    "nvim" = "v";
  };
}
