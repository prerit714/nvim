vim.o.number = true
vim.o.relativenumber = true
vim.o.mouse = "a"
vim.o.showmode = false
vim.o.breakindent = true
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.signcolumn = "yes"
vim.o.updatetime = 250
vim.o.timeoutlen = 300
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
vim.o.inccommand = "split"
vim.o.cursorline = true
vim.o.scrolloff = 10
vim.o.confirm = true
vim.schedule(function() vim.o.clipboard = "unnamedplus" end)

vim.o.winborder = "single"

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set(
  "n",
  "<leader>q",
  vim.diagnostic.setloclist,
  { desc = "Open diagnostic [Q]uickfix list" }
)
vim.keymap.set(
  "t",
  "<Esc><Esc>",
  "<C-\\><C-n>",
  { desc = "Exit terminal mode" }
)
vim.keymap.set(
  "n",
  "<C-h>",
  "<C-w><C-h>",
  { desc = "Move focus to the left window" }
)
vim.keymap.set(
  "n",
  "<C-l>",
  "<C-w><C-l>",
  { desc = "Move focus to the right window" }
)
vim.keymap.set(
  "n",
  "<C-j>",
  "<C-w><C-j>",
  { desc = "Move focus to the lower window" }
)
vim.keymap.set(
  "n",
  "<C-k>",
  "<C-w><C-k>",
  { desc = "Move focus to the upper window" }
)

vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup(
    "kickstart-highlight-yank",
    { clear = true }
  ),
  callback = function() vim.hl.on_yank() end,
})

vim.keymap.set("i", "jk", "<Esc>", {
  silent = true,
})

vim.keymap.set("i", "kj", "<Esc>", {
  silent = true,
})

local toggle_wrap = function()
  vim.wo.wrap = not vim.wo.wrap
  if vim.wo.wrap then
    vim.notify("[toggle_wrap] word wrap enabled", vim.log.levels.WARN)
  else
    vim.notify("[toggle_wrap] word wrap disabled", vim.log.levels.WARN)
  end
end

vim.keymap.set("n", "<leader>w", toggle_wrap)

vim.cmd([[
  highlight Normal guibg=NONE ctermbg=NONE
  highlight NonText guibg=NONE ctermbg=NONE
  highlight SignColumn guibg=NONE ctermbg=NONE
  highlight NormalFloat guibg=NONE ctermbg=NONE
  highlight FloatBorder guibg=NONE ctermbg=NONE
]])

vim.o.wrap = false
vim.o.colorcolumn = "80"

---@diagnostic disable-next-line: param-type-mismatch
vim.api.nvim_create_autocmd("VimResized", {
  pattern = "*",
  callback = function() vim.cmd("wincmd =") end,
})

vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { silent = true })

local indent_group =
  vim.api.nvim_create_augroup("FileTypeIndent", { clear = true })

vim.filetype.add({
  extension = {
    prisma = "prisma",
  },
})

local filetype_settings = {
  javascript = {
    expandtab = true,
    shiftwidth = 2,
    tabstop = 2,
    softtabstop = 2,
  },
  typescript = {
    expandtab = true,
    shiftwidth = 2,
    tabstop = 2,
    softtabstop = 2,
  },
  typescriptreact = {
    expandtab = true,
    shiftwidth = 2,
    tabstop = 2,
    softtabstop = 2,
  },
  css = { expandtab = true, shiftwidth = 2, tabstop = 2, softtabstop = 2 },
  scss = { expandtab = true, shiftwidth = 2, tabstop = 2, softtabstop = 2 },
  json = { expandtab = true, shiftwidth = 2, tabstop = 2, softtabstop = 2 },
  yaml = { expandtab = true, shiftwidth = 2, tabstop = 2, softtabstop = 2 },
  vue = { expandtab = true, shiftwidth = 2, tabstop = 2, softtabstop = 2 },
  svelte = { expandtab = true, shiftwidth = 2, tabstop = 2, softtabstop = 2 },
  prisma = { expandtab = true, shiftwidth = 2, tabstop = 2, softtabstop = 2 },
  python = { expandtab = true, shiftwidth = 4, tabstop = 4, softtabstop = 4 },
  lua = { expandtab = true, shiftwidth = 2, tabstop = 2, softtabstop = 2 },
  go = { expandtab = false, shiftwidth = 4, tabstop = 4, softtabstop = 4 },
  templ = { expandtab = false, shiftwidth = 4, tabstop = 4, softtabstop = 4 },
  c = { expandtab = true, shiftwidth = 2, tabstop = 2, softtabstop = 2 },
  cpp = { expandtab = true, shiftwidth = 2, tabstop = 2, softtabstop = 2 },
  rust = { expandtab = true, shiftwidth = 4, tabstop = 4, softtabstop = 4 },
  java = { expandtab = true, shiftwidth = 2, tabstop = 2, softtabstop = 2 },
  sh = { expandtab = true, shiftwidth = 2, tabstop = 2, softtabstop = 2 },
  bash = { expandtab = true, shiftwidth = 2, tabstop = 2, softtabstop = 2 },
  zsh = { expandtab = true, shiftwidth = 2, tabstop = 2, softtabstop = 2 },
  ruby = { expandtab = true, shiftwidth = 2, tabstop = 2, softtabstop = 2 },
  php = { expandtab = true, shiftwidth = 4, tabstop = 4, softtabstop = 4 },
  markdown = { expandtab = true, shiftwidth = 4, tabstop = 4, softtabstop = 4 },
  xml = { expandtab = true, shiftwidth = 4, tabstop = 4, softtabstop = 4 },
  html = { expandtab = true, shiftwidth = 4, tabstop = 4, softtabstop = 4 },
  groovy = { expandtab = true, shiftwidth = 4, tabstop = 4, softtabstop = 4 },
  txt = { expandtab = true, shiftwidth = 2, tabstop = 2, softtabstop = 2 },
  cmake = { expandtab = true, shiftwidth = 2, tabstop = 2, softtabstop = 2 },
  make = { expandtab = true, shiftwidth = 2, tabstop = 2, softtabstop = 2 },
}

local function set_indent_settings(settings)
  for option, value in pairs(settings) do
    vim.opt_local[option] = value
  end
end

for filetype, settings in pairs(filetype_settings) do
  vim.api.nvim_create_autocmd("FileType", {
    group = indent_group,
    pattern = filetype,
    callback = function() set_indent_settings(settings) end,
    desc = string.format("Set indentation for %s files", filetype),
  })
end

-- NOTE: statusline with timer
vim.g.timer_remaining = nil

local function pick(...)
  for i = 1, select("#", ...) do
    local value = select(i, ...)
    if value ~= nil then
      return value
    end
  end
end

local function get_hl(name)
  local ok, highlight = pcall(vim.api.nvim_get_hl, 0, { name = name, link = false })
  return ok and highlight or {}
end

local function set_statusline_highlights()
  local normal = get_hl("Normal")
  local statusline = get_hl("StatusLine")
  local cursorline = get_hl("CursorLine")
  local directory = get_hl("Directory")
  local warning = get_hl("DiagnosticWarn")
  local info = get_hl("DiagnosticInfo")
  local hint = get_hl("DiagnosticHint")
  local fill_bg = pick(statusline.bg, normal.bg, 0x282828)
  local fill_fg = pick(statusline.fg, normal.fg, 0xebdbb2)
  local body_fg = pick(normal.bg, 0x1d2021)

  vim.api.nvim_set_hl(0, "StatuslineFill", { fg = fill_fg, bg = fill_bg })
  vim.api.nvim_set_hl(0, "StatuslineFile", {
    fg = body_fg,
    bg = pick(directory.fg, fill_fg, 0x83a598),
    bold = true,
  })
  vim.api.nvim_set_hl(0, "StatuslineFileEdge", {
    fg = pick(directory.fg, fill_fg, 0x83a598),
    bg = fill_bg,
  })
  vim.api.nvim_set_hl(0, "StatuslineMeta", {
    fg = fill_fg,
    bg = pick(cursorline.bg, fill_bg, 0x32302f),
  })
  vim.api.nvim_set_hl(0, "StatuslineMetaEdge", {
    fg = pick(cursorline.bg, fill_bg, 0x32302f),
    bg = fill_bg,
  })
  vim.api.nvim_set_hl(0, "StatuslineTimer", {
    fg = body_fg,
    bg = pick(warning.fg, fill_fg, 0xd79921),
    bold = true,
  })
  vim.api.nvim_set_hl(0, "StatuslineTimerEdge", {
    fg = pick(warning.fg, fill_fg, 0xd79921),
    bg = fill_bg,
  })
  vim.api.nvim_set_hl(0, "StatuslineClock", {
    fg = body_fg,
    bg = pick(info.fg, fill_fg, 0x83a598),
  })
  vim.api.nvim_set_hl(0, "StatuslineClockEdge", {
    fg = pick(info.fg, fill_fg, 0x83a598),
    bg = fill_bg,
  })
  vim.api.nvim_set_hl(0, "StatuslinePos", {
    fg = body_fg,
    bg = pick(hint.fg, fill_fg, 0x8ec07c),
    bold = true,
  })
  vim.api.nvim_set_hl(0, "StatuslinePosEdge", {
    fg = pick(hint.fg, fill_fg, 0x8ec07c),
    bg = fill_bg,
  })
end

local function statusline_timer()
  if vim.g.timer_remaining and vim.g.timer_remaining > 0 then
    local mins = math.floor(vim.g.timer_remaining / 60)
    local secs = vim.g.timer_remaining % 60
    return string.format("%02d:%02d", mins, secs)
  end
end

local function statusline_escape(text)
  return text:gsub("%%", "%%%%")
end

local function statusline_segment(edge_hl, body_hl, icon, text)
  return table.concat({
    "%#",
    body_hl,
    "# ",
    icon,
    " ",
    text,
    " ",
    "%#StatuslineFill# ",
  })
end

local function render_statusline()
  local icons = vim.g.have_nerd_font and {
    file = "󰈔",
    clean = "󰄬",
    modified = "󰏫",
    timer = "󰔛",
    clock = "󱑆",
    position = "",
  } or {
    file = "F",
    clean = "=",
    modified = "+",
    timer = "T",
    clock = "C",
    position = "P",
  }

  local file_path = vim.fn.expand("%:~:.")
  if file_path == "" then
    file_path = "[No Name]"
  end

  local modified_text = vim.bo.modified and "edited" or "saved"
  local modified_icon = vim.bo.modified and icons.modified or icons.clean
  local position = string.format("%d:%d", vim.fn.line("."), vim.fn.col("."))
  local left = table.concat({
    "%#StatuslineFill# ",
    statusline_segment(
      "StatuslineFileEdge",
      "StatuslineFile",
      icons.file,
      "%<" .. statusline_escape(file_path)
    ),
    statusline_segment(
      "StatuslineMetaEdge",
      "StatuslineMeta",
      modified_icon,
      modified_text
    ),
  })

  local right_parts = {}
  local remaining = statusline_timer()
  if remaining then
    right_parts[#right_parts + 1] = statusline_segment(
      "StatuslineTimerEdge",
      "StatuslineTimer",
      icons.timer,
      remaining
    )
  end

  right_parts[#right_parts + 1] = statusline_segment(
    "StatuslineClockEdge",
    "StatuslineClock",
    icons.clock,
    os.date("%H:%M:%S")
  )
  right_parts[#right_parts + 1] = statusline_segment(
    "StatuslinePosEdge",
    "StatuslinePos",
    icons.position,
    position
  )

  return left .. "%=" .. table.concat(right_parts)
end

_G.statusline_render = render_statusline

set_statusline_highlights()
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = set_statusline_highlights,
  desc = "Refresh statusline highlight groups",
})

vim.o.statusline = "%!v:lua.statusline_render()"
vim.o.laststatus = 2

local timer = vim.uv.new_timer()

---@diagnostic disable-next-line: need-check-nil
timer:start(
  1000,
  1000,
  vim.schedule_wrap(function()
    if vim.g.timer_remaining and vim.g.timer_remaining > 0 then
      vim.g.timer_remaining = vim.g.timer_remaining - 1
      if vim.g.timer_remaining == 0 then
        vim.notify("[timer] timer finished", vim.log.levels.ERROR)
      end
    end
    vim.cmd("redrawstatus")
  end)
)

vim.api.nvim_create_user_command("TimerStart", function(opts)
  local mins = tonumber(opts.args)
  if not mins or mins < 1 or mins > 60 then
    vim.notify("[timer] usage: :TimerStart <1-60>", vim.log.levels.ERROR)
    return
  end
  vim.g.timer_remaining = mins * 60
  vim.notify(
    string.format("[timer] started: %d minutes", mins),
    vim.log.levels.INFO
  )
end, { nargs = 1 })
