return {
  {
    "R-nvim/R.nvim",
    opts = {
      debug = true,
      external_term = "tmux split-window -l 35%",
      setwd = "nvim",
      R_app = "radian",
      nvimpager = "split_v",
      open_example = true,
      objbr_place = "script,right",
      objbr_mappings = {
        s = "summary",
        p = "print",
        g = "plot",
      },
      rconsole_width = 57,
      rconsole_height = 18,
      synctex = true,
      setwidth = 4,
    },
  },
}
