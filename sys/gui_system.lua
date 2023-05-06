--- Assume Event will always be available
Color = {
  black = { red = 0, green = 0, blue = 0, alpha = 255 / 255 },
  blue = { red = 0, green = 0, blue = 255 / 255, alpha = 255 / 255 },
  green = { red = 0, green = 255 / 255, blue = 0, alpha = 255 / 255 },
  pink = { red = 255 / 255, green = 84 / 255, blue = 244 / 255, alpha = 255 / 255 },
  purple = { red = 255 / 255, green = 0, blue = 255 / 255, alpha = 255 / 255 },
  red = { red = 255 / 255, green = 0, blue = 0, alpha = 255 / 255 },
  white = { red = 255 / 255, green = 255 / 255, blue = 255 / 255, alpha = 255 / 255 },
  yellow = { red = 255 / 255, green = 255 / 255, blue = 0, alpha = 255 / 255 },
}

local gu = {
  debug = {
    messages = {}
  }
}

function gu:subscribeToEvents(state)
  Event:subscribe(EventType.load, self, self.load)
  Event:subscribe(EventType.draw, self, self.draw)
  Event:subscribe(EventType.update, self, self.update)
  Event:subscribe(EventType.keypressed, self, self.keypressed)
  Event:subscribe(EventType.state_change, self, self.stateChange)
end

function gu:load(state)
  print("GUI.load: ", state)
end

function gu:draw(state)
  -- save color so we can restore it
  local saved_color = Help.saveColor()

  -- draw cool gui stuff
  Help.setColor(Color.pink)
  LG.print("Game State: " .. tostring(GameStateText[state]), 10, 10)

  -- restore original color
  Help.loadColor(saved_color)
end

function gu:update(state, dt)

end

function gu:stateChange(state, new_state)
  print("GUI.state_change: ", state, "=>", new_state)
end

function gu:keypressed(state, k)

end

return gu
