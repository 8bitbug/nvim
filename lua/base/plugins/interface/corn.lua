require('corn').setup({
    auto_cmds = true,
    sort_method = 'severity',
    scope = 'line',
    border_style = 'rounded',
    blacklisted_modes = {'i', 'v'},
    blacklisted_severities = {vim.diagnostic.severity.HINT},
    highlights = {
        error = "DiagnosticFloatingError",
        warn = "DiagnosticFloatingWarn",
        info = "DiagnosticFloatingInfo",
        hint = "DiagnosticFloatingHint",
    },
    icons = {
        error = "E",
        warn = "W",
        hint = "H",
        info = "I",
    },
    item_preprocess_func = function(item)
        -- Custom truncation logic can be added here
        return item
    end,
    on_toggle = function(is_hidden)
        -- Toggle virtual text diagnostics when corn is toggled
        vim.diagnostic.config({ virtual_text = is_hidden })
    end,
})

require('corn').toggle(true)
