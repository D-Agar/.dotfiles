return {
  "Vigemus/iron.nvim",
  -- We use the ft event or keys to lazy-load the plugin when needed
  event = "BufReadPost",
  config = function()
    local iron = require("iron.core")
    local view = require("iron.view")
    local common = require("iron.fts.common")

    iron.setup({
      config = {
        -- Whether a repl should be discarded or not
        scratch_repl = true,
        -- Your repl definitions come here
        repl_definition = {
          sh = {
            -- Can be a table or a function that
            -- returns a table (see below)
            command = { "bash" },
          },
          python = {
            command = { "ipython", "--no-autoindent" }, -- or { "python3" }
            format = common.bracketed_paste_python,
            block_dividers = { "# %%", "#%%" },
            env = { PYTHON_BASIC_REPL = "1" }, -- needed for python3.13 and up.
          },
        },
        -- set the file type of the newly created repl to ft
        -- bufnr is the buffer id of the REPL and ft is the filetype of the
        -- language being used for the REPL.
        repl_filetype = function(bufnr, ft)
          return ft
        end,
        -- Send selections to the DAP repl if an nvim-dap session is running.
        dap_integration = true,
        -- How the repl window will be displayed
        repl_open_cmd = view.split.vertical.botright(50),
      },
      -- Iron doesn't set keymaps by default anymore.
      -- You can set them here or manually add keymaps to the functions in iron.core
      keymaps = {
        toggle_repl = "<localleader>rr", -- toggles the repl open and closed.
        restart_repl = "<localleader>rR", -- calls `IronRestart` to restart the repl
        send_motion = "<localleader>sc",
        visual_send = "<localleader>sc",
        send_file = "<localleader>sf",
        send_line = "<localleader><localleader>",
        send_paragraph = "<localleader>sp",
        send_until_cursor = "<localleader>su",
        send_mark = "<localleader>sm",
        send_code_block = "<localleader>sb",
        send_code_block_and_move = "<localleader>sn",
        mark_motion = "<localleader>mc",
        mark_visual = "<localleader>mc",
        remove_mark = "<localleader>md",
        cr = "<localleader>s<cr>",
        interrupt = "<localleader>s<localleader>",
        exit = "<localleader>sq",
        clear = "<localleader>cl",
      },
      -- If the highlight is on, you can change how it looks
      highlight = {
        italic = true,
      },
      ignore_blank_lines = true, -- ignore blank lines when sending visual select lines
    })

    -- Extra manual keymaps for iron commands
    vim.keymap.set("n", "<localleader>rf", "<cmd>IronFocus<cr>", { desc = "Iron: Focus REPL" })
    vim.keymap.set("n", "<localleader>rh", "<cmd>IronHide<cr>", { desc = "Iron: Hide REPL" })
  end,
}
