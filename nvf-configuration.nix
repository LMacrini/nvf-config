{...}:

{
  vim = {
    theme = {
      enable = true;
      name = "catppuccin";
      style = "macchiato";
    };

    autopairs.nvim-autopairs.enable = true;
    statusline.lualine.enable = true;
    telescope.enable = true;
    autocomplete.nvim-cmp.enable = true;

    languages = {
      enableLSP = true;
      enableTreesitter = true;

      nix.enable = true;
      zig.enable = true;
      python.enable = true;
      ts.enable = true;
    };

    filetree.neo-tree = {
      enable = true;
    };

    binds = {
      cheatsheet.enable = true;
    };
    maps.normal = {
      "<Esc>" = {
        action = ":noh<CR>";
      };

      "<leader>e" = {
        action = ":Neotree position=right toggle=true<CR>";
      };
    };
  };
}
