{...}:

{
  vim = {
    theme = {
      enable = true;
      name = "catppuccin";
      style = "macchiato";
    };

    utility.motion.hop.enable = true;

    autopairs.nvim-autopairs.enable = true;
    statusline.lualine.enable = true;
    telescope.enable = true;
    autocomplete.nvim-cmp.enable = true;
    terminal.toggleterm = {
      enable = true;
      setupOpts = {
        direction = "float";
      };
    };

    dashboard.dashboard-nvim.enable = true;
    dashboard.dashboard-nvim.setupOpts = {
      config = {
        disable_move = true;
      
        header = import ./dashboardheader.nix ("seija");

        packages.enable = false;

        shortcut = [
          {
            icon = " ";
            desc = "New file";
            action = "enew";
            key = "n";
          }
          {
            icon = " ";
            desc = "Github Profile";
            action = "silent exec '!open https://github.com/lmacrini'";
            key = "g";
          }
          {
            icon = "󰈆 ";
            desc = "Quit";
            action = "q";
            key = "q";
          }
        ];

        footer = [
          ""
          "󱣳 The 25th Wam"
        ];
      };
    };
      
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

    keymaps = [
      {
        key = "<Esc>";
        mode = "t";
        action = "<C-\\><C-N>";
      }
    ];

    maps.normal = {
      "<Esc>" = {
        action = ":noh<CR>";
      };

      "<leader>e" = {
        action = ":Neotree position=right toggle=true<CR>";
      };

      "<Enter>" = {
        action = ":HopWord<CR>";
      };
    };
  };
}
