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
  _name = "GUI System",
  debug = {
    messages = {}
  },
  state_map = {},
  menu_map = {
    [GameState.menu] = {
      { text = "Start", state = GameState.game },
      { text = "Quit",  state = GameState.quit }
    },
    [GameState.pause] = {
      { text = "Resume",    state = GameState.game },
      { text = "Main Menu", state = GameState.menu },
      { text = "Quit",      state = GameState.quit }
    }
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
  -- if no function is mapped for this state, return
  -- save color so we can restore it
  local saved_color = Help.saveColor()
  Help.setColor(Color.pink)
  self:drawInfo(state)

  if (self.state_map[state]) then
    self.state_map[state](self, state)
  end

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

function gu:drawInfo(state)
  LG.print("Game State: " .. tostring(GameStateText[state]), 10, 10)
  LG.print("FPS: " .. tostring(love.timer.getFPS()), 10, 30)
end

function gu:drawMenu(state)
  LG.print("Menu! ", 150, 10)
  --- draw menu items
  local menu_items = self.menu_map[state]
  local x = 150
  local y = 50
  local dy = 20
  for i, item in ipairs(menu_items) do
    LG.print(item.text, x, y + (i - 1) * dy)
  end
end

function gu:drawGame(state)
  LG.print("Game!", 150, 10)
end

function gu:drawPause(state)
  LG.print("Pause!", 150, 10)
end

function gu:drawQuit(state)
  LG.print("Quit!", 150, 10)
end

--- map the game states to the function to call for each state
gu.state_map[GameState.game] = gu.drawGame
gu.state_map[GameState.menu] = gu.drawMenu
gu.state_map[GameState.pause] = gu.drawPause
gu.state_map[GameState.quit] = gu.drawQuit

return gu
