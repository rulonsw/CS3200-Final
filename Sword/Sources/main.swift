import Sword

    

bot.on(.ready) { _ in
  bot.editStatus(to:Presence(status: .online, playing:"With Swift, God Dammit"))
}

bot.on(.messageCreate) { data in
  let msg = data[0] as! Message
  if msg.content == "!ping" {
    msg.reply(with: "Pong!")
  }
}

bot.connect()
