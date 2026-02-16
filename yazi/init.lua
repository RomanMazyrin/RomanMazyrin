-- ~/.config/yazi/init.lua
th.git = th.git or {}
th.git.unknown_sign = " "
th.git.modified_sign = "M"
th.git.added_sign = "+"
th.git.deleted_sign = "-"
th.git.clean_sign = ""

require("git"):setup {
	-- Order of status signs showing in the linemode
	order = 1500,
}
