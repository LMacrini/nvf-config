{
  pkgs,
  lib,
  ...
}: let
  mac = pkgs.stdenv.isDarwin;
  open =
    if mac
    then "open"
    else "xdg-open";
in {
  vim = {
    options = {
      signcolumn = "number";
      shiftwidth = 2;
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
        setup = ''
          vim.api.nvim_create_user_command("W", function(opts)
            vim.cmd("SudaWrite " .. opts.args)
          end, { nargs = "?" })
        '';
      };

      tabby-nvim = {
        package = tabby-nvim;
        setup = ''
          local theme = {
            fill = 'TabLineFill',
            -- Also you can do this: fill = { fg='#f2e9de', bg='#907aa9', style='italic' }
            head = 'TabLine',
            current_tab = 'TabLineSel',
            tab = 'TabLine',
            win = 'TabLine',
            tail = 'TabLine',
          }

          require('tabby').setup({
            line = function(line)
              return {
                {
                  { ' 󱣳 ', hl = theme.head },
                  line.sep('', theme.head, theme.fill),
                },
                line.tabs().foreach(function(tab)
                  local hl = tab.is_current() and theme.current_tab or theme.tab
                  return {
                    line.sep('', hl, theme.fill),
                    -- tab.is_current() and '' or '󰆣',
                    -- tab.is_current() and '' or tab.current_win().file_icon(),
                    tab.current_win().file_icon(),
                    tab.number(),
                    tab.name(),
                    tab.close_btn(''),
                    line.sep('', hl, theme.fill),
                    hl = hl,
                    margin = ' ',
                  }
                end),
                line.spacer(),
                line.wins_in_tab(line.api.get_current_tab()).foreach(function(win)
                  return {
                    line.sep('', theme.win, theme.fill),
                    -- win.is_current() and '' or '',
                    win.is_current() and '' or win.file_icon(),
                    win.buf_name(),
                    line.sep('', theme.win, theme.fill),
                    hl = theme.win,
                    margin = ' ',
                  }
                end),
                {
                  line.sep('', theme.tail, theme.fill),
                  { '  ', hl = theme.tail },
                },
                hl = theme.fill,
              }
            end,
          })
        '';
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
        setupOpts = {
          symbol = "▏";
        };
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

      "smart-splits.nvim" = {
        package = smart-splits-nvim;
        setupModule = "smart-splits";
        after = ''
          main = "ibl"
          vim.keymap.set(
            "n",
            "<leader>r",
            function()
              if not vim.g.smart_resize_mode then
                vim.cmd("SmartResizeMode")
              else
                print("Smart Resize Mode is already enabled!")
              end
            end,
            { noremap = true, silent = true, desc = "Enable Resizing", }
          )
        '';
        event = ["BufEnter"];

        setupOpts = {
          resize_mode = {
            silent = true;
            resize_keys = [
              "<Left>"
              "<Down>"
              "<Up>"
              "<Right>"
            ];
          };
        };

        keys = let
          osbind = key:
            if mac
            then "<C-S-" + key + ">"
            else "<C-" + key + ">";
        in [
          {
            action = ":SmartCursorMoveLeft<CR>";
            key = osbind "Left";
            mode = "n";
          }
          {
            action = ":SmartCursorMoveRight<CR>";
            key = osbind "Right";
            mode = "n";
          }
          {
            action = ":SmartCursorMoveUp<CR>";
            key = osbind "Up";
            mode = "n";
          }
          {
            action = ":SmartCursorMoveDown<CR>";
            key = osbind "Down";
            mode = "n";
          }

          {
            action = ":SmartSwapLeft<CR>";
            key = "<leader>m<Left>";
            mode = "n";
          }
          {
            action = ":SmartSwapRight<CR>";
            key = "<leader>m<Right>";
            mode = "n";
          }
          {
            action = ":SmartSwapUp<CR>";
            key = "<leader>m<Ups.";
            mode = "n";
          }
          {
            action = ":SmartSwapUp<CR>";
            key = "<leader>m<Down>";
            mode = "n";
          }
        ];
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
    statusline.lualine = {
      enable = true;
      extraActiveSection = {
        c = [
          ''
            function()
              return vim.g.smart_resize_mode and "RESIZING SPLITS" or ""
            end
          ''
        ];
      };
    };
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
      nvim-web-devicons.enable = true;
      cinnamon-nvim = {
        enable = true;
        setupOpts = {
          keymaps = {
            basic = true;
            extra = true;
          };

          options = {
            mode = "cursor";
            count_only = false;
            delay = 5;

            max_delta = {
              line = false;
              column = false;
              time = 1000;
            };

            step_size = {
              vertical = 1;
              horizontal = 2;
            };
          };
        };
      };
    };

    mini = {
      ai.enable = true;
    };

    dashboard.dashboard-nvim = {
      enable = true;
      setupOpts = {
        config = {
          disable_move = true;

          header = import ./dashboardheader.nix "seija";

          packages.enable = false;

          project.action = lib.generators.mkLuaInline ''
            function(path)
              vim.cmd("Telescope find_files cwd=" .. string.gsub(path, " ", "\\ "))
            end
          '';

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
    };

    git.enable = true;

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

      "<leader>nt" = {
        action = ":tabnew<CR>:Telescope find_files<CR>";
      };

      "<leader>nh" = {
        action = ":sp<CR>";
      };

      "<leader>nv" = {
        action = ":vsp<CR>";
      };
    };
  };
}
