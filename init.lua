vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.o.number = true
vim.o.mouse = "a"
vim.o.breakindent = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.signcolumn = "yes"
vim.o.updatetime = 250
vim.o.timeoutlen = 300
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.list = true
vim.o.colorcolumn = "80"
vim.o.wrap = false

vim.o.expandtab = true

-- Render special characters
vim.opt.listchars = {
  tab = "▸ ",
  trail = "·",
  extends = "›",
  precedes = "‹",
  nbsp = "␣",
}

vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "go",
    "rust",
    "python",
    "c",
    "cpp",
    "java",
    "kotlin",
    "php",
    "html",
    "xml",
  },
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.softtabstop = 4
    vim.opt_local.shiftwidth = 4
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "lua",
    "typescript",
    "javascript",
    "typescriptreact",
    "javascriptreact",
    "css",
    "scss",
  },
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.shiftwidth = 2
  end,
})

vim.o.backup = false
vim.o.writebackup = false
vim.o.swapfile = false
vim.o.undofile = true
vim.o.hidden = true

vim.schedule(function()
  vim.o.clipboard = "unnamedplus"
end)

vim.o.undolevels = 1000
vim.o.undoreload = 10000
vim.o.history = 1000

vim.o.more = false
vim.o.foldmethod = "manual"
vim.o.title = true
vim.o.titlestring = '%t%( %M%)%( (%{expand("%:~:h")})%)%a (nvim)'

vim.o.inccommand = "split"
vim.o.cursorline = true
vim.o.scrolloff = 10
vim.o.winborder = "single"

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("i", "jk", "<Esc>", {
  silent = true,
})
vim.keymap.set("i", "kj", "<Esc>", {
  silent = true,
})
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Function to get mode name
function _G.get_mode()
  local mode_map = {
    n = "NORMAL",
    i = "INSERT",
    v = "VISUAL",
    V = "V-LINE",
    c = "COMMAND",
    R = "REPLACE",
    s = "SELECT",
    S = "S-LINE",
    t = "TERMINAL",
  }
  return mode_map[vim.fn.mode()] or vim.fn.mode()
end

-- Function to setup the statusline
function _G.statusline()
  local statusline = ""
  statusline = statusline .. " %{v:lua.get_mode()} "
  statusline = statusline .. " %<%f%m "
  statusline = statusline .. "%="
  statusline = statusline .. " %l:%c/%L "
  statusline = statusline .. " [%{&fileencoding?&fileencoding:&encoding}] "
  statusline = statusline .. " " .. os.date "%Y-%m-%d %I:%M:%S %p" .. " "
  statusline = statusline .. " %p%% "
  return statusline
end

vim.o.showmode = false -- NOTE: Don't show showmode
vim.o.statusline = "%!v:lua.statusline()"

-- NOTE: Redraws status every second
local timer = vim.loop.new_timer()
if timer ~= nil then
  timer:start(
    1000,
    1000,
    vim.schedule_wrap(function()
      -- Force statusline update
      vim.cmd "redrawstatus"
    end)
  )
end

vim.o.laststatus = 2

-- Resize buffers when I am using more than 1
vim.api.nvim_create_autocmd("VimResized", {
  pattern = "*",
  callback = function()
    vim.cmd "wincmd ="
  end,
})

-- Add this to your init.lua or another config file that gets loaded
vim.keymap.set("n", "<leader>gg", function()
  -- Function to calculate dimensions
  local function get_dimensions()
    local width = math.floor(vim.o.columns * 0.9)
    local height = math.floor(vim.o.lines * 0.9)
    return {
      width = width,
      height = height,
      col = math.floor((vim.o.columns - width) / 2),
      row = math.floor((vim.o.lines - height) / 2),
    }
  end

  -- Create a floating terminal window
  local buf = vim.api.nvim_create_buf(false, true)
  local dim = get_dimensions()

  local opts = {
    relative = "editor",
    width = dim.width,
    height = dim.height,
    col = dim.col,
    row = dim.row,
    style = "minimal",
    border = "rounded",
  }

  local win = vim.api.nvim_open_win(buf, true, opts)

  -- Set window-local keymapping for 'q' to close the window
  vim.api.nvim_buf_set_keymap(buf, "t", "q", [[<C-\><C-n>:q<CR>]], { noremap = true, silent = true })

  -- Create an autocommand to handle resizing
  local group = vim.api.nvim_create_augroup("LazyGitResize", { clear = true })
  vim.api.nvim_create_autocmd("VimResized", {
    group = group,
    callback = function()
      -- If window still exists, resize it
      if vim.api.nvim_win_is_valid(win) then
        local new_dim = get_dimensions()
        vim.api.nvim_win_set_config(win, {
          relative = "editor",
          width = new_dim.width,
          height = new_dim.height,
          col = new_dim.col,
          row = new_dim.row,
        })
      else
        -- If window no longer exists, clean up autocmd
        vim.api.nvim_del_augroup_by_name "LazyGitResize"
      end
    end,
  })

  -- Set up autocmd to clean up group when buffer is closed
  vim.api.nvim_create_autocmd("BufWipeout", {
    buffer = buf,
    once = true,
    callback = function()
      vim.api.nvim_del_augroup_by_name "LazyGitResize"
    end,
  })

  -- Open lazygit using jobstart with term option
  vim.fn.jobstart("lazygit", {
    term = true,
    cwd = vim.fn.getcwd(),
    buffer = buf,
  })

  -- Switch to terminal mode automatically
  vim.cmd "startinsert"
end, { noremap = true, silent = true, desc = "Open lazygit in floating window" })

-- Function to toggle line wrapping
function _G.toggle_wrap()
  local wrap_state = vim.wo.wrap
  vim.wo.wrap = not wrap_state
  print("Wrap " .. (vim.wo.wrap and "enabled" or "disabled"))
end

-- Key mapping to toggle wrap (using <Leader>w)
vim.api.nvim_set_keymap("n", "<leader>w", ":lua toggle_wrap()<CR>", { noremap = true, silent = true })

--- @type boolean
vim.g.format_on_save_enabled = false

-- Toggle autoformat with conform
function _G.toggle_conform()
  vim.g.format_on_save_enabled = not vim.g.format_on_save_enabled
  if vim.g.format_on_save_enabled then
    print "Format on save enabled"
  else
    print "Format on save disabled"
  end
end

vim.api.nvim_set_keymap("n", "<leader>tf", ":lua toggle_conform()<CR>", { noremap = true, silent = true })

-- Window navigation remaps
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to bottom window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to top window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { silent = true })

-- Create an autocommand group for filetype indentation
local indent_group = vim.api.nvim_create_augroup("FileTypeIndent", { clear = true })

-- My filetype settings
local filetype_settings = {
  -- Web development (2 spaces)
  javascript = { expandtab = true, shiftwidth = 2, tabstop = 2, softtabstop = 2 },
  typescript = { expandtab = true, shiftwidth = 2, tabstop = 2, softtabstop = 2 },
  typescriptreact = { expandtab = true, shiftwidth = 2, tabstop = 2, softtabstop = 2 },
  html = { expandtab = true, shiftwidth = 2, tabstop = 2, softtabstop = 2 },
  css = { expandtab = true, shiftwidth = 2, tabstop = 2, softtabstop = 2 },
  scss = { expandtab = true, shiftwidth = 2, tabstop = 2, softtabstop = 2 },
  json = { expandtab = true, shiftwidth = 2, tabstop = 2, softtabstop = 2 },
  yaml = { expandtab = true, shiftwidth = 2, tabstop = 2, softtabstop = 2 },
  vue = { expandtab = true, shiftwidth = 2, tabstop = 2, softtabstop = 2 },
  svelte = { expandtab = true, shiftwidth = 2, tabstop = 2, softtabstop = 2 },

  -- Python (4 spaces, PEP 8)
  python = { expandtab = true, shiftwidth = 4, tabstop = 4, softtabstop = 4 },

  -- Lua (2 spaces)
  lua = { expandtab = true, shiftwidth = 2, tabstop = 2, softtabstop = 2 },

  -- Go (tabs)
  go = { expandtab = false, shiftwidth = 4, tabstop = 4, softtabstop = 4 },

  -- C/C++ (4 spaces or tabs, depending on preference)
  c = { expandtab = true, shiftwidth = 4, tabstop = 4, softtabstop = 4 },
  cpp = { expandtab = true, shiftwidth = 4, tabstop = 4, softtabstop = 4 },

  -- Rust (4 spaces)
  rust = { expandtab = true, shiftwidth = 4, tabstop = 4, softtabstop = 4 },

  -- Java (4 spaces)
  java = { expandtab = true, shiftwidth = 4, tabstop = 4, softtabstop = 4 },

  -- Shell scripts (2 spaces)
  sh = { expandtab = true, shiftwidth = 2, tabstop = 2, softtabstop = 2 },
  bash = { expandtab = true, shiftwidth = 2, tabstop = 2, softtabstop = 2 },
  zsh = { expandtab = true, shiftwidth = 2, tabstop = 2, softtabstop = 2 },

  -- Ruby (2 spaces)
  ruby = { expandtab = true, shiftwidth = 2, tabstop = 2, softtabstop = 2 },

  -- PHP (4 spaces)
  php = { expandtab = true, shiftwidth = 4, tabstop = 4, softtabstop = 4 },

  -- Markdown (4 spaces)
  markdown = { expandtab = true, shiftwidth = 4, tabstop = 4, softtabstop = 4 },

  -- Make files (must use tabs)
  make = { expandtab = false, shiftwidth = 4, tabstop = 4, softtabstop = 0 },
}

-- Function to apply indentation settings
local function set_indent_settings(settings)
  for option, value in pairs(settings) do
    vim.opt_local[option] = value
  end
end

-- Create autocommands for each filetype
for filetype, settings in pairs(filetype_settings) do
  vim.api.nvim_create_autocmd("FileType", {
    group = indent_group,
    pattern = filetype,
    callback = function()
      set_indent_settings(settings)
    end,
    desc = string.format("Set indentation for %s files", filetype),
  })
end

-- Load lazy
require "config.lazy"
