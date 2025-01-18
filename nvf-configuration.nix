{pkgs, ...}:

let
  open = if pkgs.stdenv.isDarwin then "open" else "xdg-open";
in
{
  vim = {
    options = {
      signcolumn = "number";
      tabstop = 4;
      tm = 1000;
    };

    theme = {
      enable = true;
      name = "catppuccin";
      style = "macchiato";
    };

    extraPlugins = with pkgs.vimPlugins; {
      vim-suda = {
        package = vim-suda;
      };
    };

    lazy.plugins = with pkgs.vimPlugins; {
      "vim-matchup" = {
        package = vim-matchup;
        setupModule = "match-up";
        after = ''
          vim.g.matchup_matchparen_offscreen = { method = "popup" }
        '';

        event = ["BufEnter"];
      };

      "mini.indentscope" = {
        package = mini-indentscope;
        setupModule = "mini.indentscope";
        after = ''
          vim.api.nvim_create_autocmd({ "FileType" }, {
            desc = "Disable indentscope for certain filetypes",
            callback = function()
              local ignored_filetypes = {
                "aerial",
                "dashboard",
                "help",
                "notify",
                "toggleterm",
                "Trouble"
              }
              if vim.tbl_contains(ignored_filetypes, vim.bo.filetype) then
                vim.b.miniindentscope_disable = true
              end
            end,
          })
        '';

        event = ["BufEnter"];
      };
    };

    preventJunkFiles = true;
    useSystemClipboard = true;

    utility = {
      motion.hop.enable = true;
      outline.aerial-nvim.enable = true;
      preview.markdownPreview.enable = true;
    };

    autopairs.nvim-autopairs.enable = true;
    statusline.lualine.enable = true;
    telescope = {
      enable = true;
      mappings = {
        findFiles = null;
      };
    };
    autocomplete.nvim-cmp.enable = true;
    notes.todo-comments.enable = true;
    notify.nvim-notify = {
      enable = true;
      setupOpts = {
        render = "default";
      };
    };
    terminal.toggleterm = {
      enable = true;
      setupOpts = {
        direction = "float";
      };
    };
    visuals = {
      highlight-undo.enable = true;
      nvim-scrollbar = {
        enable = true;
        setupOpts.excluded_filetypes = [
          "dashboard"
          "notify"
        ];
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
            action = "silent exec '!${open} https://github.com/lmacrini'";
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
    
    lsp = {
      trouble.enable = true;
      lspSignature.enable = true;
      lspkind = {
        enable = true;
        setupOpts.mode = "symbol";
      };
    };
    languages = {
      enableLSP = true;
      enableTreesitter = true;

      nix.enable = true;
      zig.enable = true;
      python.enable = true;
      ts.enable = true;

      markdown = {
        enable = true;
        extensions = {
          render-markdown-nvim.enable = true;
        };
      };
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
        action = ":Telescope find_files<CR>";
        desc = "Find Files";
      };

      "<leader>E" = {
        action = ":Telescope find_files hidden=true<CR>";
        desc = "Find Files (hidden)";
      };

      "<Enter>" = {
        action = ":HopWord<CR>";
      };

      "<leader>F" = {
        action = ":AerialToggle!<CR>";
        desc = "Toggle Aerial";
      };

      "<leader>md" = {
        action = ":MarkdownPreviewToggle<CR>";
      };
    };
  };
}
