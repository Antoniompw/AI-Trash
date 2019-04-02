function Trash_can()
	local trash_can = {}

	function BurnTrash(agent)
		agent.trash = 0
	end

	return trash_can
end