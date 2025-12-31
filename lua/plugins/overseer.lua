return {
  "stevearc/overseer.nvim",
  opts = {},
  config = function()
    require("overseer").setup {
      strategy = "toggleterm",
      templates = { "builtin", "user.cpp_build", "user.cpp_run", "user.java_run" },
    }

    -- Keybindings using localleader
    local keymap = vim.keymap.set

    -- Main keybindings
    keymap("n", "<localleader>r", "<cmd>OverseerRun<cr>", { desc = "Run task" })
    keymap("n", "<localleader>t", "<cmd>OverseerToggle<cr>", { desc = "Toggle task list" })
    keymap("n", "<localleader>a", "<cmd>OverseerTaskAction<cr>", { desc = "Task action" })
    keymap("n", "<localleader>b", "<cmd>OverseerBuild<cr>", { desc = "Build task" })
    keymap("n", "<localleader>q", "<cmd>OverseerQuickAction<cr>", { desc = "Quick action" })
    keymap("n", "<localleader>c", "<cmd>OverseerClearCache<cr>", { desc = "Clear cache" })

    -- Additional useful keybindings
    keymap("n", "<localleader>n", "<cmd>OverseerRunCmd<cr>", { desc = "Run shell command" })
    keymap("n", "<localleader>l", "<cmd>OverseerLoadBundle<cr>", { desc = "Load task bundle" })
    keymap("n", "<localleader>s", "<cmd>OverseerSaveBundle<cr>", { desc = "Save task bundle" })
  end,
  dependencies = {
    {
      "akinsho/toggleterm.nvim",
      name = "toggleterm",
    },
  },
}
