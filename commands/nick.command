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
//     config: The confic object.
//
/////

exports.call = (args, info) => {

	// No response in DMs.
	if(!info.message.guild) {
		return "Not even I can set a nickname in a DM, big girl.";

	} else {
		var new_name = args.join(" ");

		info.bot.user.username = new_name;
		info.message.guild.me.setNickname(new_name);
		return `I have become ${info.bot.user.username}.`;
	}

}