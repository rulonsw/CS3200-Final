import Sword

    
let bot = Sword(token: "MzA2MDY5MjExNTAxODIxOTUz.C-A_tQ.8tBeOVu46mlP9Sv72eI4gP14uyA")

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
