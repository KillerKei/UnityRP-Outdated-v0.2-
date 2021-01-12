Config = {
	DiscordToken = "NzkwMzM2MzM3MjkwMTk5MTAx.X9_IEg.JiEwkjVereoVCiQZyzwRAv7k4DM",
	GuildId = "786705449767534646",

	-- Format: ["Role Nickname"] = "Role ID" You can get role id by doing \@RoleName
	Roles = {
		["TestRole"] = "Some Role ID" -- This would be checked by doing exports.discord_perms:IsRolePresent(user, "TestRole")
	}
}