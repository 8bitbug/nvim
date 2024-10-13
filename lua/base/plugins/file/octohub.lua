local octohub = require('octohub')

octohub.setup({
  contrib_icons = { '', '', '', '', '', '', '' },
  projects_dir = '~/Projects/',
  per_user_dir = true,
  sort_repos_by = '',
  repo_type = '',
  max_contributions = 50,
  top_lang_count = 15,
  event_count = 5,
  window_width = 90,
  window_height = 60,
  show_recent_activity = true,
  show_contributions = true,
  show_repo_stats = true,
  repo_cache_timeout = 3600 * 24,
  username_cache_timeout = 3600 * 24 * 7,
  events_cache_timeout = 60 * 30,
  contributions_cache_timeout = 3600 * 4,
  user_cache_timeout = 3600 * 24 * 7,
  add_default_keybindings = true,
})
