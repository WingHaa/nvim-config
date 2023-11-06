return {
	'echasnovski/mini.ai',
	event = 'InsertEnter',
	version = '*',
	config = function()
		require('mini.ai').setup()
	end
}
