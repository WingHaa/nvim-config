local function keymapOptions(desc)
	return {
		noremap = true,
		silent = true,
		nowait = true,
		desc = "GPT prompt " .. desc,
	}
end

return {
	"robitx/gp.nvim",
	config = function()
		require("gp").setup({
			-- required openai api key
			openai_api_key = require('.env').key(), -- os.getenv("OPENAI_API_KEY")
			-- api endpoint (you can change this to azure endpoint)
			openai_api_endpoint = "https://api.openai.com/v1/chat/completions",
			-- openai_api_endpoint = "https://$URL.openai.azure.com/openai/deployments/{{model}}/chat/completions?api-version=2023-03-15-preview",
			-- prefix for all commands
			cmd_prefix = "Gp",
			-- optional curl parameters (for proxy, etc.)
			-- curl_params = { "--proxy", "http://X.X.X.X:XXXX" }
			curl_params = {},

			-- directory for storing chat files
			chat_dir = vim.fn.stdpath("data"):gsub("/$", "") .. "/gp/chats",
			-- chat model (string with model name or table with model name and parameters)
			chat_model = { model = "gpt-3.5-turbo", temperature = 1.1, top_p = 1 },
			-- chat model system prompt (use this to specify the persona/role of the AI)
			chat_system_prompt = "You are a general AI assistant.",
			-- chat custom instructions (not visible in the chat but prepended to model prompt)
			chat_custom_instructions = "The user provided the additional info about how they would like you to respond:\n\n"
					.. "- If you're unsure don't guess and say you don't know instead.\n"
					.. "- Ask question if you need clarification to provide better answer.\n"
					.. "- Think deeply and carefully from first principles step by step.\n"
					.. "- Zoom out first to see the big picture and then zoom in to details.\n"
					.. "- Use Socratic method to improve your thinking and coding skills.\n"
					.. "- Don't elide any code from your output if the answer requires coding.\n"
					.. "- Take a deep breath; You've got this!\n",
			-- chat user prompt prefix
			chat_user_prefix = "🗨:",
			-- chat assistant prompt prefix
			chat_assistant_prefix = "🤖:",
			-- chat topic generation prompt
			chat_topic_gen_prompt = "Summarize the topic of our conversation above"
					.. " in two or three words. Respond only with those words.",
			-- chat topic model (string with model name or table with model name and parameters)
			chat_topic_gen_model = "gpt-3.5-turbo",
			-- explicitly confirm deletion of a chat file
			chat_confirm_delete = true,
			-- conceal model parameters in chat
			chat_conceal_model_params = true,
			-- local shortcuts bound to the chat buffer
			-- (be careful to choose something which will work across specified modes)
			chat_shortcut_respond = { modes = { "n", "i", "v", "x" }, shortcut = "<C-g><C-g>" },
			chat_shortcut_delete = { modes = { "n", "i", "v", "x" }, shortcut = "<C-g>d" },
			chat_shortcut_new = { modes = { "n", "i", "v", "x" }, shortcut = "<C-g>n" },
			-- default search term when using :GpChatFinder
			chat_finder_pattern = "topic ",

			-- command config and templates bellow are used by commands like GpRewrite, GpEnew, etc.
			-- command prompt prefix for asking user for input
			command_prompt_prefix = "🤖 ~ ",
			-- command model (string with model name or table with model name and parameters)
			command_model = { model = "gpt-3.5-turbo", temperature = 1.1, top_p = 1 },
			-- command system prompt
			command_system_prompt = "You are an AI working as code editor.\n\n"
					.. "Please AVOID COMMENTARY OUTSIDE OF SNIPPET RESPONSE.\n"
					.. "Start and end your answer with:\n\n```",
			-- auto select command response (easier chaining of commands)
			command_auto_select_response = true,

			-- templates
			template_selection = "I have the following code from {{filename}}:"
					.. "\n\n```{{filetype}}\n{{selection}}\n```\n\n{{command}}",
			template_rewrite = "I have the following code from {{filename}}:"
					.. "\n\n```{{filetype}}\n{{selection}}\n```\n\n{{command}}"
					.. "\n\nRespond exclusively with the snippet that should replace the code above.",
			template_append = "I have the following code from {{filename}}:"
					.. "\n\n```{{filetype}}\n{{selection}}\n```\n\n{{command}}"
					.. "\n\nRespond exclusively with the snippet that should be appended after the code above.",
			template_prepend = "I have the following code from {{filename}}:"
					.. "\n\n```{{filetype}}\n{{selection}}\n```\n\n{{command}}"
					.. "\n\nRespond exclusively with the snippet that should be prepended before the code above.",
			template_command = "{{command}}",

			-- https://platform.openai.com/docs/guides/speech-to-text/quickstart
			-- Whisper costs $0.006 / minute (rounded to the nearest second)
			-- by eliminating silence and speeding up the tempo of the recording
			-- we can reduce the cost by 50% or more and get the results faster
			-- directory for storing whisper files
			whisper_dir = "/tmp/gp_whisper",
			-- multiplier of RMS level dB for threshold used by sox to detect silence vs speech
			-- decibels are negative, the recording is normalized to -3dB =>
			-- increase this number to pick up more (weaker) sounds as possible speech
			-- decrease this number to pick up only louder sounds as possible speech
			-- you can disable silence trimming by setting this a very high number (like 1000.0)
			whisper_silence = "1.75",
			-- whisper max recording time (mm:ss)
			whisper_max_time = "05:00",
			-- whisper tempo (1.0 is normal speed)
			whisper_tempo = "1.75",

			-- example hook functions (see Extend functionality section in the README)
			hooks = {
				InspectPlugin = function(plugin, params)
					print(string.format("Plugin structure:\n%s", vim.inspect(plugin)))
					print(string.format("Command params:\n%s", vim.inspect(params)))
				end,

				-- GpImplement rewrites the provided selection/range based on comments in the code
				Implement = function(gp, params)
					local template = "Having following from {{filename}}:\n\n"
							.. "```{{filetype}}\n{{selection}}\n```\n\n"
							.. "Please rewrite this code according to the comment instructions."
							.. "\n\nRespond only with the snippet of finalized code:"

					gp.Prompt(
						params,
						gp.Target.rewrite,
						nil, -- command will run directly without any prompting for user input
						gp.config.command_model,
						template,
						gp.config.command_system_prompt
					)
				end,

				-- your own functions can go here, see README for more examples like
				-- :GpExplain, :GpUnitTests.., :GpBetterChatNew, ..

			},
		})

		-- Chat commands
		vim.keymap.set("n", "<leader>gc", "<cmd>GpChatNew<cr>", keymapOptions("New Chat"))
		vim.keymap.set("n", "<leader>gt", "<cmd>GpChatToggle<cr>", keymapOptions("Toggle Popup Chat"))
		vim.keymap.set("n", "<leader>gf", "<cmd>GpChatFinder<cr>", keymapOptions("Chat Finder"))

		vim.keymap.set("v", "<leader>gc", ":<C-u>'<,'>GpChatNew<cr>", keymapOptions("Visual Chat New"))
		vim.keymap.set("v", "<leader>gv", ":<C-u>'<,'>GpChatPaste<cr>", keymapOptions("Visual Chat Paste"))
		vim.keymap.set("v", "<leader>gt", ":<C-u>'<,'>GpChatToggle<cr>", keymapOptions("Visual Popup Chat"))

		vim.keymap.set("n", "<C-g><C-x>", "<cmd>GpChatNew split<cr>", keymapOptions("New Chat split"))
		vim.keymap.set("n", "<C-g><C-v>", "<cmd>GpChatNew vsplit<cr>", keymapOptions("New Chat vsplit"))
		vim.keymap.set("n", "<C-g><C-t>", "<cmd>GpChatNew tabnew<cr>", keymapOptions("New Chat tabnew"))

		vim.keymap.set("v", "<C-g>x", ":<C-u>'<,'>GpChatNew split<cr>", keymapOptions("Visual Chat New split"))
		vim.keymap.set("v", "<C-g>v", ":<C-u>'<,'>GpChatNew vsplit<cr>", keymapOptions("Visual Chat New vsplit"))
		vim.keymap.set("v", "<C-g>t", ":<C-u>'<,'>GpChatNew tabnew<cr>", keymapOptions("Visual Chat New tabnew"))

		-- Prompt commands
		vim.keymap.set("v", "<leader>gr", ":<C-u>'<,'>GpRewrite<cr>", keymapOptions("Visual Rewrite"))
		vim.keymap.set("v", "<leader>ga", ":<C-u>'<,'>GpAppend<cr>", keymapOptions("Visual Append"))
		vim.keymap.set("v", "<leader>gb", ":<C-u>'<,'>GpPrepend<cr>", keymapOptions("Visual Prepend"))
		vim.keymap.set("v", "<leader>ge", ":<C-u>'<,'>GpEnew<cr>", keymapOptions("Visual Enew"))
		vim.keymap.set("v", "<leader>gp", ":<C-u>'<,'>GpPopup<cr>", keymapOptions("Visual Popup"))

		vim.keymap.set({ "n", "v", "x" }, "<leader>gs", "<cmd>GpStop<cr>", keymapOptions("Stop"))

		-- optional Whisper commands
		-- vim.keymap.set({ "n", "i" }, "<C-g>w", "<cmd>GpWhisper<cr>", keymapOptions("Whisper"))
		-- vim.keymap.set({ "n", "i" }, "<C-g>R", "<cmd>GpWhisperRewrite<cr>", keymapOptions("Inline Rewrite"))
		-- vim.keymap.set({ "n", "i" }, "<C-g>A", "<cmd>GpWhisperAppend<cr>", keymapOptions("Append"))
		-- vim.keymap.set({ "n", "i" }, "<C-g>B", "<cmd>GpWhisperPrepend<cr>", keymapOptions("Prepend"))
		-- vim.keymap.set({ "n", "i" }, "<C-g>E", "<cmd>GpWhisperEnew<cr>", keymapOptions("Enew"))
		-- vim.keymap.set({ "n", "i" }, "<C-g>P", "<cmd>GpWhisperPopup<cr>", keymapOptions("Popup"))

		-- vim.keymap.set("v", "<C-g>w", ":<C-u>'<,'>GpWhisper<cr>", keymapOptions("Whisper"))
		-- vim.keymap.set("v", "<C-g>R", ":<C-u>'<,'>GpWhisperRewrite<cr>", keymapOptions("Visual Rewrite"))
		-- vim.keymap.set("v", "<C-g>A", ":<C-u>'<,'>GpWhisperAppend<cr>", keymapOptions("Visual Append"))
		-- vim.keymap.set("v", "<C-g>B", ":<C-u>'<,'>GpWhisperPrepend<cr>", keymapOptions("Visual Prepend"))
		-- vim.keymap.set("v", "<C-g>E", ":<C-u>'<,'>GpWhisperEnew<cr>", keymapOptions("Visual Enew"))
		-- vim.keymap.set("v", "<C-g>P", ":<C-u>'<,'>GpWhisperPopup<cr>", keymapOptions("Visual Popup"))
	end,
}
