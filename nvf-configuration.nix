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
      
        header = [
          " __  __   ______   _____  ______   __  __      ____    ____    ______   _____  ______     "
          "/\\ \\/\\ \\ /\\__  _\\ /\\___ \\/\\__  _\\ /\\ \\/\\ \\    /\\  _`\\ /\\  _`\\ /\\__  _\\ /\\___ \\/\\  _  \\    "
          "\\ \\ \\/'/'\\/_/\\ \\/ \\/__/\\ \\/_/\\ \\/ \\ \\ `\\\\ \\   \\ \\,\\L\\_\\ \\ \\L\\_\\/_/\\ \\/ \\/__/\\ \\ \\ \\L\\ \\   "
          " \\ \\ , <    \\ \\ \\    _\\ \\ \\ \\ \\ \\  \\ \\ , ` \\   \\/_\\__ \\\\ \\  _\\L  \\ \\ \\    _\\ \\ \\ \\  __ \\  "
          "  \\ \\ \\\\`\\   \\_\\ \\__/\\ \\_\\ \\ \\_\\ \\__\\ \\ \\`\\ \\    /\\ \\L\\ \\ \\ \\L\\ \\ \\_\\ \\__/\\ \\_\\ \\ \\ \\/\\ \\ "
          "   \\ \\_\\ \\_\\ /\\_____\\ \\____/ /\\_____\\\\ \\_\\ \\_\\   \\ `\\____\\ \\____/ /\\_____\\ \\____/\\ \\_\\ \\_\\"
          "    \\/_/\\/_/ \\/_____/\\/___/  \\/_____/ \\/_/\\/_/    \\/_____/\\/___/  \\/_____/\\/___/  \\/_/\\/_/"
          "                                                                                          "
          "                                                                                          "
        ];

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
    };
  };
}
