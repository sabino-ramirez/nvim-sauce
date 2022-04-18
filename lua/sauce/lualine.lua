local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
	return
end

local hide_in_width = function()
	return vim.fn.winwidth(0) > 80
end

local colors = {
  yellow = '#d4d955',
  blue   = '#80a0ff',
  cyan   = '#79dac8',
  black  = '#080808',
  white  = '#c6c6c6',
  red    = '#cf535d',
  violet = '#d183e8',
  grey   = '#303030',
  green  = '#50806d',
  --bigBar  = '#9faba2'
  bigBar  = '#6f7044'
}

local sauce_theme = {
  normal = {
    a = { fg = colors.black, bg = colors.green },
    b = { fg = colors.white, bg = colors.grey },
    c = { fg = colors.white, bg = colors.grey },
  },

  insert = { a = { fg = colors.black, bg = colors.red } },
  visual = { a = { fg = colors.black, bg = colors.yellow } },
  replace = { a = { fg = colors.black, bg = colors.cyan } },

  inactive = {
    a = { fg = colors.white, bg = colors.black },
    b = { fg = colors.white, bg = colors.black },
    c = { fg = colors.white, bg = colors.black },
  },
}

local branch = {
	"branch",
	icons_enabled = true,
	icon = "",
}

local diagnostics = {
	"diagnostics",
	sources = { "nvim_diagnostic" },
	sections = { "error", "warn" },
	symbols = { error = " ", warn = " " },
	colored = false,
	update_in_insert = true,
	always_visible = true,
}

local mode = {
	"mode",
	fmt = function(str)
		return "-- " .. str .. " --"
	end,
}

local filename = {
	"filename",
  fmt = function(str)
    return "" .. str .. ""
  end,
  file_status = true,
  path = 2,
  symbols = {
    modified = '[+]',
    readonly = '[-]',
  }

}

local diff = {
	"diff",
	colored = false,
	symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
  cond = hide_in_width
}

local spaces = function()
	return "spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
end

local filetype = {
	"filetype",
	icons_enabled = true,
  colored = false,
	--icon = nil,
}

local location = {
	"location",
	padding = 1,
}

local buffers = {
  "buffers",
  show_filename_only = true,
  show_modified_status = true,
  max_length = vim.o.columns * 2 / 3,
  filetype_names = {
        TelescopePrompt = 'Telescope',
        dashboard = 'Dashboard',
        packer = 'Packer',
        fzf = 'FZF',
        alpha = 'Alpha'
      },
  buffers_color = {
        -- Same values as the general color option can be used here.
        active = 'lualine_a_normal',     -- Color for active buffer.
        inactive = 'lualine_b_normal', -- Color for inactive buffer.
      },
}

local tabs = {
  "tabs",
  max_length = vim.o.columns / 3, -- Maximum width of tabs component.
                                  -- Note:
                                  -- It can also be a function that returns
                                  -- the value of `max_length` dynamically.
  mode = 0, -- 0: Shows tab_nr
            -- 1: Shows tab_name
            -- 2: Shows tab_nr + tab_name

  tabs_color = {
    -- Same values as the general color option can be used here.
    active = 'lualine_{section}_normal',     -- Color for active tab.
    inactive = 'lualine_{section}_inactive', -- Color for inactive tab.
  },
}

-- cool function for progress
local progress = function()
	local current_line = vim.fn.line(".")
	local total_lines = vim.fn.line("$")
	local chars = { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
	local line_ratio = current_line / total_lines
	local index = math.ceil(line_ratio * #chars)
	return chars[index]
end


lualine.setup({
	options = {
		icons_enabled = true,
		theme = sauce_theme,
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = { "alpha", "dashboard", "NvimTree", "Outline" },
		always_divide_middle = true,
	},
	sections = {
		lualine_a = { branch, diagnostics },
		lualine_b = { filename },
		lualine_c = {  },
		-- lualine_x = { "encoding", "fileformat", "filetype" },
		lualine_x = { diff, spaces, "encoding", filetype },
		lualine_y = { location },
		lualine_z = { progress },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {
    lualine_a = { buffers },
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = { },
  },
	extensions = {'toggleterm'},
})
