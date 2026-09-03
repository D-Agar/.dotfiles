return {
  {
    "jpalardy/vim-slime",
    lazy = false,
    -- init is always run at startup
    init = function()
      vim.g.slime_target = "tmux"
      -- preserves indentation when pasting to ipython/radian
      -- vim.g.slime_pracketed_paste = 1
      vim.g.slime_no_mappings = 1
      vim.g.slime_default_config = {
        socket_name = "default",
        target_pane = "{last}",
      }
      vim.g.slime_dont_ask_default = 1
    end,
    -- lazy-loaded key mappings
    -- keys = {}
    -- config is executed when the plugin loads
    config = function()
      local set = vim.keymap.set

      -- Normal & Visual Mode: Send paragraphs, lines, or visual selections
      set("n", "<localleader>rl", "<Plug>SlimeLineSend", { remap = true, desc = "Slime: Send current line" })
      set("n", "<localleader>rp", "<Plug>SlimeParagraphSend", { remap = true, desc = "Slime: Send paragraph" })
      set("x", "<localleader>rl", "<Plug>SlimeRegionSend", { remap = true, desc = "Slime: Send selection" })

      -- Send entire buffer
      set(
        "n",
        "<localleader>rb",
        ":%SlimeSend<CR>",
        { remap = true, silent = true, desc = "Slime: Send entire buffer" }
      )

      -- Manually reconfigure target pane if you switch tmux layouts
      set("n", "<localleader>rc", "<Plug>SlimeConfig", { remap = true, desc = "Slime: Reconfigure target pane" })

      -- Cell Execution (# %%)
      -- Custom helper to detect `# %%` or `/* %% */` blocks and send the whole cell
      local function send_cell()
        local cursor = vim.api.nvim_win_get_cursor(0)
        local last_line = vim.api.nvim_buf_line_count(0)
        local pattern = "^%s*#%s*%%%%" -- Matches `# %%` or `# %% [markdown]`

        -- Search backward for the start of the cell
        local start_line = 1
        for l = cursor[1], 1, -1 do
          local line_text = vim.api.nvim_buf_get_lines(0, l - 1, l, false)[1]
          if line_text:match(pattern) then
            start_line = l + 1 -- start executing immediately below the header
            break
          end
        end

        -- Search forward for the end of the cell
        local end_line = last_line
        for l = cursor[1] + 1, last_line do
          local line_text = vim.api.nvim_buf_get_lines(0, l - 1, l, false)[1]
          if line_text:match(pattern) then
            end_line = l - 1
            break
          end
        end

        -- If valid range, send the text to tmux
        if start_line <= end_line then
          local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)
          local text = table.concat(lines, "\n") .. "\n"
          vim.fn["slime#send"](text)
        end
      end

      -- Run current cell
      set("n", "<localleader>re", send_cell, { remap = true, desc = "Slime: Execute current cell" })

      -- Run current cell and jump to next cell
      set("n", "<localleader>rn", function()
        send_cell()
        vim.fn.search("^\\s*#\\s*%%%%", "W")
      end, { remap = true, desc = "Slime: Execute cell and jump to next" })
    end,
  },
}
