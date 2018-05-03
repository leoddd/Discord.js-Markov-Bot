//////////////////////////////
// Command file for leod's bot.
/////
//
// Needs to export a 'call' function that returns a response object as specified in bot_core.
// function call(args, memory, bot, message, config)
//   args: Arguments passed in by the user, like "m!markov arguments are these words"
//   info: An object with information about the current bot state. Keys:
//     memory: The global memory object the bot posesses. Can be manipulated by returning a "memory" dict in the response.
//     message: Discord.js's Message object. Represents the message that triggered this command.
//     bot: Discord.js Client object. Represents the bot.
//     config: The config object.
//     core: A subset of bot_core to expose some functions to commands. Is eventEmitter, look at its definition in init() for functions.
//           Pay special attention to the command* helper functions.
/////

exports.call = (args, info) => {

	var signals = [];
	var reload_string = "";

	info.core.commandBundle(args, {

		// Reload markov chain.
		markov: () => {
			var guild_temp = info.temp.guilds[info.message.guild.id];
			guild_temp.markov_state = undefined;
			guild_temp.markov_object = undefined;

			if(guild_temp.hasOwnProperty("since_last_markov")) {
				guild_temp.since_last_markov = 0;
				guild_temp.current_chance = info.config.markov_chance;
			}

			reload_string = list(reload_string, "markov data");
		},

		commands: () => {
			if(info.core.isBotAdmin(info.message)) {
				signals.push("reload");

				reload_string = list(reload_string, "commands");
			}
		},

		all: () => {
			if(info.core.isBotAdmin(info.message)) {
				signals = ["reset"];
				
				reload_string = list(reload_string, "the connection");
			}
		},

		core: function () {
			this.all();
		},

		default: function () {
			this.commands();
		}

	});


	if(reload_string !== "") {
		return {
			"msg": `Reloading ${reload_string}.`,
			"signals": signals,
		};
	} else {
		return "You didn't tell me what to reload.";
	}
}


// Constructs the reload_string.
function list(current_list, str) {
	if(current_list == "") {
		current_list = str;
	} else if(current_list.indexOf(" and ") === -1) {
		current_list = `${str} and ${current_list}`;
	} else {
		current_list = `${str}, ${current_list}`;
	}

	return current_list;
}