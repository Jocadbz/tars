module main

import discord
import os
import infinixius.sysinfo as sys

fn main() {
	// Define shit here.
	token := os.args[1]


	mut bot := discord.bot(token, intents: .message_content | .guild_messages)
	bot.events.on_ready.listen(fn (event discord.ReadyEvent) ! {
		println('Logged as ${event.user.username}! Tars has ${event.guilds.len} guilds')
	})
	bot.events.on_message_create.listen(fn (event discord.MessageCreateEvent) ! {
		// Ping command
		if event.message.content.to_lower() == 'tars, ping me' {
			if event.message.author.id == 727194765610713138 {
				event.creator.rest.create_message(event.message.channel_id, content: 'Hello Joca. Pinging you.')!
			} else {
				return
			}
		}
		// System Stats command
		if event.message.content.to_lower() == 'tars, how are we doing?' {
			if event.message.author.id == 727194765610713138 {
				sys_message := "Hello Joca, here are the Pandora status.
Our ${sys.cpu_model()!}, is having a load of ${sys.cpu_usage()}%, running on ${sys.cpu_temp()!}°C.
Memory stats report that we are using ${sys.memory_total()!-sys.memory_free()!}Kb bytes, with ${sys.memory_available()!}Kb remaining.
We are running for ${sys.uptime()!/60} Minutes!"
				event.creator.rest.create_message(event.message.channel_id, content: sys_message)!
			} else {
				return
			}
		}
		// Reboot command
		if event.message.content.to_lower() == 'tars, reboot' {
			if event.message.author.id == 727194765610713138 {
				event.creator.rest.create_message(event.message.channel_id, content: 'Understood. See you on the other side.')!
				os.system('reboot')
			} else {
				return
			}
		}
		// Restart Denjibot
		if event.message.content.to_lower() == 'tars, restart jack frost' {
			if event.message.author.id == 727194765610713138 {
				event.creator.rest.create_message(event.message.channel_id, content: 'Understood. Doing it now.')!
				os.system("systemctl restart denjibot")
			} else {
				return
			}
		}
	})
	bot.launch()!
}