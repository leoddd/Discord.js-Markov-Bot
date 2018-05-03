//////////////////////////////
// Command file for leod's bot.
/////
//
// Needs to export a 'call' function that returns a response object as specified in bot_core.
// function call(args, memory, bot, message, config)
//   args: Arguments passed in by the user, like "m!markov arguments are these words"
//   info: An object with information about the current bot state. Keys:
//     memory: The global memory object the bot posesses. Can be manipulated by returning a "memory" dict in the response.
//     message: Discord.js's Message object. Represents the message that triggered this command, if it is a command.
//     command: The name of the command being called, if it is a command.
//     hook: If set, the command was called through a message hook instead of an explicit command.
//     bot: Discord.js Client object. Represents the bot.
//     config: The config object.
//     core: A subset of bot_core to expose some functions to commands. Is eventEmitter, look at its definition in init() for functions.
//           Pay special attention to the command* helper functions.
//
// Additionally, exports a 'help' function that is to return a help string about how to use the command. It receives the following:
// 	 config: The config object. Useful for prefixes or to check if a functionality is enabled.
//   command: The name of the command being asked for help on.
//   message: Discord.js's Message object. Represents the message that asked for help.
/////

// Help function:
exports.help = (config, command, message) => {
	return `This command will give you information for every command I know.\nUsage: \`${config.prefix}${command} [command name]\``;
}

// Command logic:
exports.call = (args, info) => {

	// If the command is called blank, explain it.
	if(args.length === 0) {
		return info.core.getHelpString(info.command, info.message);
	}

	// If the command exists, get its help and check if it had any.
	if(info.core.hasCommand(args[0])) {
		var help_string = info.core.getHelpString(args[0], info.message);

		if(help_string && help_string !== "") {
			return help_string;
		} else {
			return `There is no help available for the \`${args[0]}\` command, oops!`;
		}

	}


	else {
		return `There is no \`${args[0]}\` command.`;
	}

}